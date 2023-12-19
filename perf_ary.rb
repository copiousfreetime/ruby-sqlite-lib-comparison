# frozen_string_literal: true

require 'sqlite3'
require 'extralite'
require 'amalgalite'
require 'debug'

require 'benchmark/ips'
require 'fileutils'

DB_PATH = 'tmp/sqlite3_perf_test.db'

def prepare_database(count)
  puts "Preparing database #{DB_PATH} with #{count} records"
  FileUtils.rm(DB_PATH) rescue nil
  db = Amalgalite::Database.new(DB_PATH, "w+")
  db.execute('create table foo ( a integer primary key, b text )')
  db.execute('begin;')
  count.times { db.execute('insert into foo (b) values (?)', "hello#{rand(1000)}" )}
  db.execute('commit;')
end

def sqlite3_run(count)
  raise "Nope" unless File.exist?(DB_PATH)
  db = SQLite3::Database.new(DB_PATH)
  results = db.execute('select * from foo')
  db.close
  raise unless results.size == count
end

def extralite_run(count)
  raise "Nope" unless File.exist?(DB_PATH)
  db = Extralite::Database.new(DB_PATH)
  results = db.query_ary('select * from foo')
  db.close
  raise unless results.size == count
end

def amalgalite_run(count)
  raise "Nope" unless File.exist?(DB_PATH)
  db = Amalgalite::Database.new(DB_PATH, "r")
  results = db.execute('select * from foo')
  db.close
  raise unless results.size == count
end

[10, 1000, 100000].each do |c|
  puts; puts; puts "Record count: #{c}"

  prepare_database(c)

  Benchmark.ips do |x|
    x.config(:time => 3, :warmup => 1)

    x.report("extralite") { extralite_run(c) }
    x.report("amalgalite") { amalgalite_run(c) }
    x.report("sqlite3") { sqlite3_run(c) }

    x.compare!
  end
end
