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
            os.makedirs(backup_root)
        return backup_root

    def install(self) -> None:
        self.install_dotfiles()
        self.make_vim_dirs()

    def make_vim_dirs(self):
        os.makedirs(join(self.user_home, '.vim', 'swap'), exist_ok=True)
        os.makedirs(join(self.user_home, '.vim', 'undo'), exist_ok=True)
        os.makedirs(join(self.user_home, '.vim', 'backup'), exist_ok=True)

    def move_to_backup(self, src_path, dest_path):
        if os.path.islink(dest_path):
            if os.path.realpath(dest_path) == src_path:
                print(f'Symlink already exists: {src_path} -> {dest_path}')
                return True
            print(f'Removing symlink: {dest_path}')
            os.remove(dest_path)
            return False
        else:
            backup_path = join(self.backup_root, basename(dest_path))
            print(f'Moving file to backup: {dest_path} -> {backup_path}')
            os.rename(dest_path, backup_path)
            return False

    def install_dotfiles(self) -> None:
        for name in os.listdir(self.home_dir):
            src_path = join(self.home_dir, name)
            dest_path = join(self.user_home, name)
            if os.path.isfile(src_path):
                self.safe_link(src_path, dest_path)
            elif name == '.config':
                os.makedirs(dest_path, exist_ok=True)
                for entry in os.listdir(src_path):
                    inner_path = join(dest_path, entry)
                    self.safe_link(join(src_path, entry), inner_path)

    def safe_link(self, src_path, dest_path):
        linked = False
        if os.path.exists(dest_path) or os.path.islink(dest_path):
            linked = self.move_to_backup(src_path, dest_path)
        if not linked:
            print(f'Creating symlink: {src_path} -> {dest_path}')
            os.symlink(src_path, dest_path)


def main():
    args = parse()
    manager = DotfileManager()
    manager.install()


if __name__ == '__main__':
    main()
