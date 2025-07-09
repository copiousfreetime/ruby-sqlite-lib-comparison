require 'sqlite3'
require 'extralite'
require 'amalgalite'
#require 'debug'

require 'benchmark/ips'
require 'fileutils'
require 'stackprof'

DB_PATH = 'tmp/sqlite3_perf_test.db'

def prepare_database(count)
  puts "Preparing database #{DB_PATH} with #{count} records"
  FileUtils.rm(DB_PATH) rescue nil
  db = Extralite::Database.new(DB_PATH)
  db.execute('create table foo ( a integer primary key, b text )')
  db.execute('begin;')
  count.times { db.execute('insert into foo (b) values (?)', "hello#{rand(1000)}" )}
  db.execute('commit;')
end

