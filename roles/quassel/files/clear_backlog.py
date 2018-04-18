#!/usr/bin/env python2
import logging
import sys
import sqlite3
import os
import shutil

from contextlib import closing

############################################################
# INIT
############################################################

# Logging
log_formatter = logging.Formatter(
    '%(asctime)s - %(levelname)-10s - %(name)-20s - %(funcName)-30s - %(message)s')
root_logger = logging.getLogger()
root_logger.setLevel(logging.INFO)

# Set schedule logger to ERROR
logging.getLogger('schedule').setLevel(logging.ERROR)

# Set console logger
console_handler = logging.StreamHandler(sys.stdout)
console_handler.setFormatter(log_formatter)
root_logger.addHandler(console_handler)

# Set chosen logging level
root_logger.setLevel(logging.DEBUG)
log = root_logger.getChild('quassel_backlog_clear')


############################################################
# FUNCTIONS
############################################################

def error_exit(msg, restore_db=False, db_path=None):
    log.error(msg)
    if restore_db and db_path:
        backup_db_path = os.path.join(os.path.dirname(db_path), 'quassel-storage.sqlite.bak')
        if os.path.isfile(backup_db_path):
            log.info("Restoring backup of database '%s' to '%s'", backup_db_path, db_path)
            shutil.move(backup_db_path, db_path)
        else:
            log.error("Unable to restore backup of database '%s' because it did not exist...", backup_db_path)

    sys.exit(1)


def backup_database(db_path):
    try:
        backup_path = os.path.join(os.path.dirname(db_path), 'quassel-storage.sqlite.bak')
        log.info("Copying '%s' to '%s'", db_path, backup_path)
        shutil.copyfile(db_path, backup_path)
        log.info("Done!")
        return True
    except Exception:
        log.exception("Exception backup up database '%s': ", db_path)
    return False


def get_buffers(cursor):
    try:
        log.info("Fetching buffers")
        return cursor.execute("SELECT * FROM buffer").fetchall()
    except Exception:
        log.exception("Exception fetching buffers from database: ")
    return None


def remove_backlog(cursor, buffer_id, last_seen_msg_id):
    try:
        return cursor.execute("DELETE FROM backlog WHERE bufferid = ? AND messageid < ?",
                              (buffer_id, last_seen_msg_id,))
    except Exception:
        log.exception("Exception clearing backlog prior to %d from buffer %d: ", last_seen_msg_id, buffer_id)
    return None


def dump_db(main_conn, new_db):
    try:
        log.info("Dumping database to '%s'", new_db)
        script = ''.join(main_conn.iterdump())

        con = sqlite3.connect(new_db)
        con.executescript(script)
        con.close()
        return True
    except Exception:
        log.exception("Exception dumping database to '%s': ", new_db)
    return False


############################################################
# MAIN
############################################################

if __name__ == "__main__":
    quassel_db_path = "/opt/quassel/quassel-storage.sqlite"

    # pass sys argv
    if len(sys.argv) > 1:
        quassel_db_path = sys.argv[1]

    if not os.path.isfile(quassel_db_path):
        error_exit("'%s' was not a valid filepath..." % quassel_db_path)

    log.info("Using quassel_db_path = '%s'", quassel_db_path)

    # is quassel stopped?
    log.info("Have you stopped quassel core? - Y / N")
    is_stopped = raw_input()
    if not is_stopped.lower().startswith('y'):
        error_exit("Quassel Core MUST be stopped before proceeding...")

    # backup database
    if not backup_database(quassel_db_path):
        error_exit("Aborting due to failure to backup database...")

    # open connection to db
    try:
        with sqlite3.connect(quassel_db_path) as conn:
            conn.row_factory = sqlite3.Row
            with closing(conn.cursor()) as c:
                # fetch buffers
                buffers = get_buffers(c)
                if not buffers:
                    error_exit("Failed retrieving buffers")

                log.info("Fetched %d buffers: %s", len(buffers), ','.join(str(x['bufferid']) for x in buffers))

                # clear backlog
                log.info("Clearing backlogs from collected buffers")
                for qbuffer in buffers:
                    backlog_clear_result = remove_backlog(c, qbuffer['bufferid'], qbuffer['lastseenmsgid'])
                    if not backlog_clear_result:
                        error_exit("Failed clearing backlog for messages from bufferid %d before lastseenmsgid %d" %
                                   qbuffer['bufferid'], qbuffer['lastseenmsgid'], True, quassel_db_path)
                    log.info("Cleared %d messages from backlog for buffer %d", c.rowcount, qbuffer['bufferid'])
                log.info("Finished clearing backlogs!")

                # dump db to save space
                pre_dump_size = os.path.getsize(quassel_db_path)
                new_db_path = os.path.join(os.path.dirname(quassel_db_path), 'quassel-storage.sqlite.new')
                if not dump_db(conn, new_db_path):
                    error_exit("Failed dumping database to save space...", True, quassel_db_path)
                post_dump_size = os.path.getsize(new_db_path)
                log.info("Dumped database! Old size: %s bytes - New Size: %s bytes", pre_dump_size, post_dump_size)

        # move newly dumped db to old path
        log.info("Overwriting old database '%s' with '%s'", quassel_db_path, new_db_path)
        shutil.move(new_db_path, quassel_db_path)

    except Exception:
        log.exception("Exception while clearing quassel backlog: ")

    log.info("Finished!")
