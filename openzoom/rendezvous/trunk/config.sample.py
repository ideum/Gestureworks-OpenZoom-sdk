#
#   OpenZoom Rendezvous
#
#   Copyright (c) 2007-2009, Daniel Gasienica <daniel@gasienica.ch>
#
#   OpenZoom is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   OpenZoom is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with OpenZoom. If not, see <http://www.gnu.org/licenses/>.
#

# FLICKR
API_KEY = ""
API_SECRET = ""
USER_ID = ""

# FTP
FTP_HOST = ""
FTP_USER = ""
FTP_PASSWORD = ""
FTP_PATH = ""

# Settings
SOURCE_DIR = ""
TMP_DIR = "tmp"
LOG_DIR = "log"
LOG_FILE = "rendezvous.log"

MAIN_URI = "http://static.example.com/images"
EXTRA_URI = ["http://t0.example.com/images",
             "http://t1.example.com/images",
             "http://t2.example.com/images",
             "http://t3.example.com/images"]

# ERROR HANDLING
DOWNLOAD_RETRIES = 3
PYRAMID_RETRIES = 3
DESCRIPTOR_RETRIES = 3
FTP_RETRIES = 5
MACHINE_TAG_RETRIES = 5