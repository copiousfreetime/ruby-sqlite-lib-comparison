# frozen_string_literal: true
require_relative './common'
require 'stackprof'

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

def extralite_iterator_run(count)
  db = Extralite::Database.new(DB_PATH)
  results = []
  db.query('select * from foo') do |row|
    results << row
  end
  db.close
  raise unless results.size == count
end

def amalgalite_run(count)
  db = Amalgalite::Database.new(DB_PATH, "r")
  db.type_map = ::Amalgalite::TypeMaps::StorageMap.new
  results = db.execute('select * from foo')
  db.close
  raise unless results.size == count
end

def load_results_meta(stmt_api, column_count)
  column_count.times do |idx|
    name     = stmt_api.column_name( idx )
    db_name  = stmt_api.column_database_name( idx )
    tbl_name = stmt_api.column_table_name( idx )
    col_name = stmt_api.column_origin_name( idx )
    schema = ::Amalgalite::Column.new( db_name, tbl_name, col_name, idx )
    schema.declared_data_type = stmt_api.column_declared_type( idx )
  end
end

def amalgalite_api_run(count)
  mode = ::Amalgalite::SQLite3::Constants::Open::READWRITE | ::Amalgalite::SQLite3::Constants::Open::CREATE
  api = Amalgalite::SQLite3::Database.open(DB_PATH, mode)

  sql = "select * from foo"
  stmt_api = api.prepare(sql)
  result_meta = load_results_meta(stmt_api, 2)
  results = []
  loop do
    case rc = stmt_api.step
    when ::Amalgalite::SQLite3::Constants::ResultCode::ROW
      id = stmt_api.column_int64( 0 )
      txt = stmt_api.column_text( 1 )
      results << [ id, txt ]
    when ::Amalgalite::SQLite3::Constants::ResultCode::DONE
      break
    end
  end
  stmt_api.close
  api.close
  raise unless results.size == count
end

runs = [ 10, 1_000, 10_000, 1_000_000 ]
runs.each do |c|
  puts; puts; puts "Record count: #{c}"

  prepare_database(c)
  Benchmark.ips do |x|
    x.config(:time => 5, :warmup => 3)

    x.report("extralite") { extralite_run(c) }
    x.report("extralite-iterator") { extralite_iterator_run(c) }
    x.report("amalgalite") { amalgalite_run(c) }
    x.report("amalgalite-api") { amalgalite_api_run(c) }

    x.report("sqlite3") { sqlite3_run(c) }

    x.compare!
  end
end
