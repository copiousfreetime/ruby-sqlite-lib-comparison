# frozen_string_literal: true

require_relative './common'

def sqlite3_run(count)
  db = SQLite3::Database.new(DB_PATH)
  results = db.execute('select * from foo')
  db.close
  raise unless results.size == count
end

def extralite_run(count)
  db = Extralite::Database.new(DB_PATH)
  results = db.query_array('select * from foo')
  db.close
  raise unless results.size == count
end

def amalgalite_run(count)
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
