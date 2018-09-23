#!/usr/bin/env python3

"""
        ____  _             _____              _       _____ _
       |  _ \| | _____  __ |_   _| __ __ _ ___| |__   |  ___(_)_  _____ _ __
       | |_) | |/ _ \ \/ /   | || '__/ _` / __| '_ \  | |_  | \ \/ / _ \ '__|
       |  __/| |  __/>  <    | || | | (_| \__ \ | | | |  _| | |>  <  __/ |
       |_|   |_|\___/_/\_\   |_||_|  \__,_|___/_| |_| |_|   |_/_/\_\___|_|

    #########################################################################
    # Title:      Plex Trash Fixer                                          #
    # Author(s):  L3uddz                                                    #
    # URL:        https://github.com/cloudbox/cloudbox                      #
    # --                                                                    #
    #         Part of the Cloudbox project: https://cloudbox.works          #
    #########################################################################
    #                   GNU General Public License v3.0                     #
    #########################################################################


"""


import json
import os
import sqlite3
import sys
from shutil import copyfile

############################################################
# CONFIG
############################################################

# DATABASE_PATH = "C:\\Users\\Olaf\\Desktop\\com.plexapp.plugins.library.db"
DATABASE_PATH = "/opt/plex/Library/Application Support" \
                "/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db"


############################################################
# PARSER CLASSES
############################################################

class MetadataItem:
    def __init__(self, meta):
        self.id = meta[0]
        self.library_section_id = meta[1]
        self.parent_id = meta[2]
        self.metadata_type = meta[3]
        self.guid = meta[4]
        self.media_item_count = meta[5]
        self.title = meta[6]
        self.title_sort = meta[7]
        self.original_title = meta[8]
        self.studio = meta[9]
        self.rating = meta[10]
        self.rating_count = meta[11]
        self.tagline = meta[12]
        self.summary = meta[13]
        self.trivia = meta[14]
        self.quotes = meta[15]
        self.content_rating = meta[16]
        self.content_rating_age = meta[17]
        self.index = meta[18]
        self.absolute_index = meta[19]
        self.duration = meta[20]
        self.user_thumb_url = meta[21]
        self.user_art_url = meta[22]
        self.user_banner_url = meta[23]
        self.user_music_url = meta[24]
        self.user_fields = meta[25]
        self.tags_genre = meta[26]
        self.tags_collection = meta[27]
        self.tags_director = meta[28]
        self.tags_writer = meta[29]
        self.tags_star = meta[30]
        self.originally_available_at = meta[31]
        self.available_at = meta[32]
        self.expires_at = meta[33]
        self.refreshed_at = meta[34]
        self.year = meta[35]
        self.added_at = meta[36]
        self.created_at = meta[37]
        self.updated_at = meta[38]
        self.deleted_at = meta[39]
        self.tags_country = meta[40]
        self.extra_data = meta[41]
        self.hash = meta[42]
        self.audience_rating = meta[43]
        self.changed_at = meta[44]
        self.resources_changed_at = meta[45]

    def __repr__(self):
        return json.dumps(self.__dict__)


############################################################
# FUNCS
############################################################

def backup_database():
    backup_path = os.path.join(os.path.dirname(sys.argv[0]), 'com.plexapp.plugins.library.db.bak')
    print("Backing Up Database: %s to %s" % (DATABASE_PATH, backup_path))
    return copyfile(DATABASE_PATH, backup_path)


def load_database():
    db = None
    try:
        db = sqlite3.connect(DATABASE_PATH)
    except Exception as ex:
        print("Exception while loading database:", ex)
        sys.exit(1)
    return db


def find_deleted(db):
    items = []
    try:
        print("Searching for deleted items")
        cursor = db.cursor()
        cursor.execute('SELECT * FROM metadata_items WHERE deleted_at IS NOT NULL')
        raw_items = cursor.fetchall()
        for item in raw_items:
            items.append(MetadataItem(item))
    except Exception as ex:
        print("Exception while querying for deleted metadata_items:", ex)
        db.close()
        sys.exit(1)
    return items


def set_field_null(db, table, field, id):
    print("Setting %r from table %r to NULL for id: %d" % (field, table, id))
    cursor = db.cursor()
    cursor.execute(''' UPDATE {} SET {} = ? WHERE id = ? '''.format(table, field), (None, id))


############################################################
# MAIN
############################################################

if __name__ == "__main__":
    # backup database
    backup_database()

    # load database
    print("Loading Plex Database")
    database = load_database()
    if not database:
        print("Database could not be loaded...")
        sys.exit(1)
    else:
        print("Loaded database")

    # find deleted metadata items
    deleted_items = find_deleted(database)
    if not deleted_items:
        print("There were no deleted items!")
        database.close()
        sys.exit(0)
    print("Found %d deleted items: %r" % (len(deleted_items), deleted_items))

    # loop list resetting deleted_at field
    for deleted_item in deleted_items:
        set_field_null(database, 'metadata_items', 'deleted_at', deleted_item.id)
    try:
        database.commit()
    except Exception as ex:
        print("Exception while committing changes:", ex)
        print("Rolling back...")
        database.rollback()

    # close database
    database.close()
    print("Finished")
