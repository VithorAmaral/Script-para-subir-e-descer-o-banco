#!/bin/bash
# description: Starts and stops the Oracle listener and database
source /u01/scripts/profiles/CDBRMSCO.sh

case "$1" in
    'start')
        # Start the listener:
        lsnrctl start

        # Start the databases:
        sqlplus '/ as sysdba' <<'EOF'
            startup
            exit
EOF
        ;;
    'stop')
        # Stop the listener:
        lsnrctl stop

        # Stop the databases:
        sqlplus '/ as sysdba' <<'EOF'
            shutdown immediate
            exit
EOF
        ;;
esac
