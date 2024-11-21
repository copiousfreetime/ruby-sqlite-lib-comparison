# frozen_string_literal: true

require_relative './common'

def sqlite3_prepare
  db = SQLite3::Database.new(DB_PATH, :results_as_hash => true)
  db.prepare('select * from foo')
end

def sqlite3_run(stmt, count)
  results = stmt.execute.to_a
  raise unless results.size == count
end

def extralite_prepare
  db = Extralite::Database.new(DB_PATH)
  db.prepare('select * from foo')
end

def extralite_run(query, count)
  results = query.to_a
  raise unless results.size == count
end

[10, 1000, 100000].each do |c|
  puts; puts; puts "Record count: #{c}"

  prepare_database(c)

  sqlite3_stmt = sqlite3_prepare
  extralite_stmt = extralite_prepare

  Benchmark.ips do |x|
    x.config(:time => 3, :warmup => 1)

    x.report("sqlite3")   { sqlite3_run(sqlite3_stmt, c) }
    x.report("extralite") { extralite_run(extralite_stmt, c) }

    x.compare!
  end
end
