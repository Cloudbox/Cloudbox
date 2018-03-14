#!/usr/bin/env python3
import logging
import os
import sys
from logging.handlers import RotatingFileHandler

import ruamel.yaml

############################################################
# INIT
############################################################


log = None


def init_logging(playbook_path):
    # log settings
    log_format = '%(asctime)s - %(levelname)-10s - %(name)-35s - %(funcName)-35s - %(message)s'
    log_file_path = os.path.join(playbook_path, "settings-updater.log")
    log_level = logging.DEBUG

    # init root_logger
    log_formatter = logging.Formatter(log_format)
    root_logger = logging.getLogger()
    root_logger.setLevel(log_level)

    # init console_logger
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(log_formatter)
    root_logger.addHandler(console_handler)

    # init file_logger
    file_handler = RotatingFileHandler(
        log_file_path,
        maxBytes=1024 * 1024 * 5,
        backupCount=5
    )
    file_handler.setFormatter(log_formatter)
    root_logger.addHandler(file_handler)

    # Set chosen logging level
    root_logger.setLevel(log_level)

    # Get logger
    return root_logger.getChild("settings-updater")


############################################################
# UPDATER
############################################################

def load_settings(file_to_load):
    settings = None
    try:
        settings = ruamel.yaml.round_trip_load(open(file_to_load, "r").read())
    except Exception:
        log.exception("Exception loading %s: ", file_to_load)
    return settings


def dump_settings(settings, file_to_dump):
    dumped = False
    try:
        with open(file_to_dump, 'w') as fp:
            fp.write(ruamel.yaml.round_trip_dump(settings, indent=2, block_seq_indent=2, explicit_start=True))
        dumped = True
    except Exception:
        log.exception("Exception dumping upgraded %s: ", file_to_dump)
    return dumped


def upgrade_settings(defaults, current):
    upgraded = False
    res = current.copy()
    for k, v in defaults.items():
        if k not in current:
            res[k] = v
            upgraded = True
            log.info("Added %s", k)

        if hasattr(v, 'items'):
            if k in current:
                sub_upgrade, res[k] = upgrade_settings(v, current[k])
                if sub_upgrade:
                    upgraded = True
            else:
                res[k] = v
                upgraded = True
                log.info("Added %s", k)

    return upgraded, res


############################################################
# MAIN
############################################################

if __name__ == "__main__":
    # get playbook dir
    if not len(sys.argv) >= 2:
        print("Playbook dir must be passed as an argument")
        sys.exit(1)
    playbook_dir = sys.argv[1]

    # init logging
    log = init_logging(playbook_dir)

    # load settings
    default_settings = load_settings(os.path.join(playbook_dir, "settings.yml.default"))
    if not default_settings:
        log.error("Failed loading settings.yml.default, aborting...")
        sys.exit(1)

    current_settings = load_settings(os.path.join(playbook_dir, "settings.yml"))
    if not current_settings:
        log.error("Failed loading settings.yml, aborting...")
        sys.exit(1)

    # compare/upgrade settings
    did_upgrade, upgraded_settings = upgrade_settings(default_settings, current_settings)
    if not did_upgrade:
        log.info("There were no settings changes to apply.")
        sys.exit(0)
    else:
        if not dump_settings(upgraded_settings, os.path.join(playbook_dir, "settings.yml")):
            log.error("Failed dumping updated settings.yml")
            sys.exit(1)
        log.info("Successfully upgraded settings.yml")
        sys.exit(2)
