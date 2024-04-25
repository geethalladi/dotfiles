#!/usr/bin/env python3

import os

IGNORE = [
    'node_modules',
    'venv',
    '.cache',
    '.local',
    '.metadata',
    'htmlcov',
    'build',
    'target',
    '.mypy_cache',
    '__pycache__',
    '"*.class"',
    '"*.pyc"',
    '"*.elc"',
    '.DS_Store',
]

SYSTEM_DIRECTORIES = [
    'Documents',
    'Desktop',
    'Downloads',
]

PERSONAL = [
    'repo',
    'work',
    'dotfiles',
    'freshworks',
    'org',
    'private',
    'installed.d',
    'slipbox',
    '.emacs.d',
    '.config',
    '.ssh',
    '.tsh',
    '.logseq',
    '.gitconfig',
    '.gitconfig-self',
    '.gitconfig-work',
    'iTerm2',
]

ALL = SYSTEM_DIRECTORIES + PERSONAL

SOURCE = '/Users/galladi'
DEST = '/Volumes/Backup'


def exclude_switches(ignored=IGNORE):
    """
    Get the exclude switches
    """
    excluded = map(lambda x: '--exclude=%s' % x, ignored)
    return " ".join(excluded)


def rsync_backup_command(directory, source=SOURCE, destination=DEST,
                         ignored=IGNORE):
    """
    Return the rsync command
    """
    src = os.path.join(source, directory)
    dest = os.path.join(destination)
    excluded = exclude_switches(ignored)
    return 'rsync -apv "%s" "%s" %s' % (src, dest, excluded)


def backup_all():
    """
    Backup all the artifacts
    """
    # create brewfile.lock
    # backup idea settings
    backup()  # backup the data folders


def backup(directories=ALL, source=SOURCE, dest=DEST, ignored=IGNORE):
    """
    Backup the given directories from source to destination
    """
    for d in directories:
        cmd = rsync_backup_command(d, source, dest, ignored)
        print("\n**********************************************\n")
        print("Running ", cmd)
        os.system(cmd)


def _cleanup(files):
    """
    Cleanup the given files
    """
    for f in files:
        cmd = 'rm -rf {}'.format(f)
        print("\n**********************************************\n")
        print("Running ", cmd)
        os.system(cmd)


def _cleanup_system(directories):
    """
    Cleanup the files in the system directories
    """
    for d in directories:
        cmd = 'rm -rf {}/*'.format(d)
        print("\n**********************************************\n")
        print("Running ", cmd)
        os.system(cmd)


def cleanup():
    """
    Cleanup everything
    """
    _cleanup_system(SYSTEM_DIRECTORIES)
    _cleanup(PERSONAL)
