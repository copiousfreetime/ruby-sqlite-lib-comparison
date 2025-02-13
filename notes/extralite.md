# Extralite

## build strategy

- embedded source code
- compile on gem installation


## compilation options

$CFLAGS += ' -Wno-undef'
$CFLAGS += ' -Wno-discarded-qualifiers'
$CFLAGS += ' -Wno-unused-function'

 enable the session extension
$defs += '-DSQLITE_ENABLE_SESSION'
$defs += '-DSQLITE_ENABLE_PREUPDATE_HOOK'
$defs += '-DEXTRALITE_ENABLE_CHANGESET'

$defs += '-DHAVE_SQLITE3_ENABLE_LOAD_EXTENSION'
$defs += '-DHAVE_SQLITE3_LOAD_EXTENSION'
$defs += '-DHAVE_SQLITE3_PREPARE_V2'
$defs += '-DHAVE_SQLITE3_ERROR_OFFSET'
$defs += '-DHAVE_SQLITE3SESSION_CHANGESET'

## Ruby portions

## C portions

allocation / deallocation
    - TypedData_Wrap_Struct
    -

- Changeset for tracking changes to the databse
- sqlite3session_create, sqlite3changeset_op
- Database mark moveable, mark gc_location
- progress handler on db to begin with
- gvl threshold
- sets pragmas on db open as options
- database.query with sql, bind params and yields rows
- query - single row
- execute vs. query
- runtime status of the db
- backup is a single call, block yields progress
- progress handler to allow suspention of calls and restarting
- query methods for all the styles of returning values
- Interator method to iterate through query results
- Query to encapsulate prepared queries
