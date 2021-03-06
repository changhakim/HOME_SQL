#!/bin/sh

#-------------------------------------------------------
# File: deallocate_table_nonsystem.sh
# Desc: Perform Table Deallocate - Non-System Users
# Runs: Four Times per Month = 0 0 1,8,15,22 * *
# Parm: 1 - Megabytes to Keep (default 4)
#-------------------------------------------------------
#  1.0  07/11/2002  Initial script creation
#  1.1  07/12/2002  Added whenever sqlerror
#  1.2  08/08/2002  Added TJS_SQL_SET1 and TJS_SQL_SET2
#-------------------------------------------------------

if [ $# -lt 1 ]
then
  TJS_MEGS_KEEP=4
else
  TJS_MEGS_KEEP=$1
fi

. $TJS_DIR/tjs_start_log.sh

$ORACLE_HOME/bin/sqlplus -s <<EOF
$ORACLE_DBA_UID/$ORACLE_DBA_UPW
WHENEVER SQLERROR EXIT FAILURE
$TJS_SQL_SET1
spool $TJS_TMP_FILE
select 'alter table '||owner||'.'||table_name||' deallocate unused keep $TJS_MEGS_KEEP M;'
from all_tables
where owner not in ('SYS','SYSTEM','DBSNMP','OUTLN')
  and tablespace_name != 'SYSTEM'
  and table_name not like 'SYS_IOT_OVER%'
order by owner, table_name;
spool off
$TJS_SQL_SET2
@$TJS_TMP_FILE
EOF
TJS_RETURN_CODE=$?

rm -f $TJS_TMP_FILE

. $TJS_DIR/tjs_stop_log.sh