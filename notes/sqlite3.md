# SQLite3

## build strategy

- embedded source code
- ship tonnes of binaries

## compilation options

              "-DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1",
              "-DSQLITE_USE_URI=1",
              "-DSQLITE_ENABLE_DBPAGE_VTAB=1",
              "-DSQLITE_ENABLE_DBSTAT_VTAB=1"

## Ruby portions

- Error Codes / Status are in ruby
- ruby does the actual step through and result set creation
- flag to send results as hash
- get_first_row
- get_first_value
- ResultSet class
    - iterates over as array or hash
    - encapsulates the statement and the db
- Exceptions
- Fork Safety
- Pragma Module
    - includes getting table information
- Statements
    - stats hash for the statement
- type convertor
- version and metadata info


  RUBY_VERSION =~ /(\d+\.\d+)/
  require "sqlite3/#{$1}/sqlite3_native"

## C portions

allocation / deallocation
    - TypedData_Make_Struct
    - alloc / dealloc
    - define_alloc_function

module SQLite3
    - some singleton functions
    - version
    - some compilation status
    - Blob
    - some C constants
    - sqlite3_status
    module Database
    module Statement
- aggregator setup
- Sqlite3::Backup is a top level class
- Sqlite3::Database
    - open
    - close
    - collation
    - authorizer
    - aggregation
    - function
    - loads extensions from a file
    - exec batch
- Errors are converted to Exception classes
    - can have code
    - can have code with sql that was the exception
- Statement
    - column names
    - column types
    - binding params
    - does bind text16 and utf8
    - does step in c
