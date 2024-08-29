#!/usr/bin/env python3

import os
from argparse import ArgumentParser
from functools import cached_property

from os.path import expanduser, join, dirname, abspath, isfile, basename


def parse():
    parser = ArgumentParser(description='Install dotfiles with symlinks')
    args = parser.parse_args()
    return args


class DotfileManager:
    def __init__(self) -> None:
        self.current_dir = abspath(dirname(__file__))
        self.user_home = expanduser('~')
        self.home_dir = join(self.current_dir, 'home')

    @cached_property
    def backup_root(self):
        backup_root = join(self.user_home, '.dotfiles-backup')
        if not os.path.exists(backup_root):
            os.mkdir(backup_root)
        return backup_root

    def install(self) -> None:
        self.install_dotfiles()

    def move_to_backup(self, src_path, dest_path):
        if os.path.islink(dest_path):
            if os.path.realpath(dest_path) == src_path:
                print(f'Symlink already exists: {src_path} -> {dest_path}')
                return True
            print(f'Removing symlink: {dest_path}')
            os.remove(dest_path)
            return False
        elif os.path.isfile(dest_path):
            backup_path = join(self.backup_root, basename(dest_path))
            print(f'Moving file to backup: {dest_path} -> {backup_path}')
            os.rename(dest_path, backup_path)
            return False
        else:
            raise RuntimeError(f'Found an unexpected directory: {dest_path}')

    def install_dotfiles(self) -> None:
        for name in os.listdir(self.home_dir):
            src_path = join(self.home_dir, name)
            dest_path = join(self.user_home, name)
            linked = False
            if os.path.exists(dest_path):
                linked = self.move_to_backup(src_path, dest_path)
            elif os.path.islink(dest_path):
                os.remove(dest_path)

            if not linked:
                print(f'Creating symlink: {src_path} -> {dest_path}')
                os.symlink(src_path, dest_path)


def main():
    args = parse()
    manager = DotfileManager()
    manager.install()


if __name__ == '__main__':
    main()
