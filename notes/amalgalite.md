# Amalgalite

## Build Strategy

- embedded source code
- build binary for various platforms

## compilation options

$CFLAGS += " -DSQLITE_ENABLE_BYTECODE_VTAB=1"
$CFLAGS += " -DSQLITE_ENABLE_COLUMN_METADATA=1"
$CFLAGS += " -DSQLITE_ENABLE_DBSTAT_VTAB=1"
$CFLAGS += " -DSQLITE_ENABLE_DBPAGE_VTAB=1"
$CFLAGS += " -DSQLITE_ENABLE_EXPLAIN_COMMENTS=1"
$CFLAGS += " -DSQLITE_ENABLE_FTS3=1"
$CFLAGS += " -DSQLITE_ENABLE_FTS3_PARENTHESIS=1"
$CFLAGS += " -DSQLITE_ENABLE_FTS4=1"
$CFLAGS += " -DSQLITE_ENABLE_FTS5=1"
$CFLAGS += " -DSQLITE_ENABLE_GEOPOLY=1"
$CFLAGS += " -DSQLITE_ENABLE_MATH_FUNCTIONS=1"
$CFLAGS += " -DSQLITE_ENABLE_MEMORY_MANAGEMENT=1"
$CFLAGS += " -DSQLITE_ENABLE_NORMALIZE=1"
$CFLAGS += " -DSQLITE_ENABLE_NULL_TRIM=1"
$CFLAGS += " -DSQLITE_ENABLE_PREUPDATE_HOOK=1"
$CFLAGS ++ " -DSQLITE_EANBLE_QPSG=1"
$CFLAGS += " -DSQLITE_ENABLE_RBU=1"
$CFLAGS += " -DSQLITE_ENABLE_RTREE=1"
$CFLAGS += " -DSQLITE_ENABLE_SESSION=1"
$CFLAGS += " -DSQLITE_ENABLE_SNAPSHOT=1"
$CFLAGS += " -DSQLITE_ENABLE_STMTVTAB=1"
$CFLAGS += " -DSQLITE_ENABLE_STAT4=1"
$CFLAGS += " -DSQLITE_ENABLE_UNLOCK_NOTIFY=1"
$CFLAGS += " -DSQLITE_ENABLE_SOUNDEX=1"

$CFLAGS += " -DSQLITE_USE_ALLOCA=1"
$CFLAGS += " -DSQLITE_OMIT_DEPRECATED=1"

ignoreable_warnings = %w[ write-strings ]
ignore_by_compiler = {
  "clang" => %w[
                  empty-body
                  incompatible-pointer-types-discards-qualifiers
                  shorten-64-to-32
                  sign-compare
                  unused-const-variable
                  unused-variable
                  unused-but-set-variable
                  undef
  ],
  "gcc" => %w[
              declaration-after-statement
              implicit-function-declaration
              unused-variable
              unused-but-set-variable
              maybe-uninitialized
              old-style-definition
              undef
  ]
}

## Ruby portions
- Quite a bit of all the logic is in amalgalite
- it goes in and out of the c / ruby api boundary a lot

## C Portions

allocation / deallocation
    - DataGetStruct
    - Data_Wrap_Struct
    - ALLOC

- Lots of sqlite utility functions
- quotes and parses strings
- Blob class
- All the constant are defined in C
- All the SQLite3 items are under the module SQLite3
- does backup - but doesn't yield progress
- has the whole store code in the db and require it issue
