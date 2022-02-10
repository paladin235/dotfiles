#!/usr/bin/env python3

import os
from argparse import ArgumentParser

from os.path import expanduser, join, dirname, abspath, isfile


def parse():
    parser = ArgumentParser(description='Install dotfiles with symlinks')
    args = parser.parse_args()
    return args


class DotfileManager:
    def __init__(self) -> None:
        self._backup_root = None
        self.home_path = expanduser('~')

    @property
    def backup_root(self):
        if self._backup_root is None:
            self._backup_root = join(self.home_path, '.dotfiles-backup')
            os.mkdir(self._backup_root)
        return self._backup_root

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
            backup_path = join(self.backup_root, dest_path)
            print(f'Moving file to backup: {dest_path} -> {backup_path}')
            os.rename(dest_path, backup_path)
            return False
        else:
            raise RuntimeError(f'Found an unexpected directory: {dest_path}')

    def install_dotfiles(self) -> None:
        current_dir = abspath(dirname(__file__))

        for name in os.listdir(current_dir):
            if not name.startswith('.'):
                continue
            if not isfile(name):
                continue
            if name.endswith('.iml'):
                continue

            src_path = join(current_dir, name)
            dest_path = join(self.home_path, name)
            linked = False
            if os.path.exists(dest_path):
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
