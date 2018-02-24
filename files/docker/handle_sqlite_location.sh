#!/bin/ash
set -e

DEFAULT_LOCATION=/opt/teamspeak/ts3server.sqlitedb
DATA_LOCATION=/data/ts3server.sqlitedb

# Checking if files exist to make sure we're backing up the database to data
if [ ! -f ${DEFAULT_LOCATION} ] && [ -f ${DATA_LOCATION} ]
then
    ln -s ${DATA_LOCATION} ${DEFAULT_LOCATION}
fi

if [ -f ${DEFAULT_LOCATION} ] && [ ! -f ${DATA_LOCATION} ]
then
    mv ${DEFAULT_LOCATION} ${DATA_LOCATION}
    ln -s ${DATA_LOCATION} ${DEFAULT_LOCATION}
fi

if [ -f ${DEFAULT_LOCATION} ] && [ -f ${DATA_LOCATION} ]
then
    rm ${DEFAULT_LOCATION}
    ln -s ${DATA_LOCATION} ${DEFAULT_LOCATION}
fi
