#!/opt/rubies/ruby-3.4.1/bin/ruby

require 'bundler/inline'

gemfile do
  source "https://rubygems.org/"
  gem 'stackprof'
#  gem 'amalgalite', path: "../amalgalite"
  gem "extralite"
#  gem 'benchmark-ips'
end

DB_PATH = 'tmp/sqlite3_perf_test.db'
#require_relative './common'
#require 'vernier'

def amalgalite_run(count)
  db = Amalgalite::Database.new(DB_PATH, "r")
  results = db.execute('select * from foo')
  db.close
end

def extralite_run(count)
  db = Extralite::Database.new(DB_PATH)
  results = db.query_array('select * from foo')
  db.close
  raise unless results.size == count
end


count = 1_000_000

#prepare_database(count)

#Vernier.profile(out: "time_profile.json") do
  2.times do |x|
#    amalgalite_run(count)
    extralite_run(count)
  end
#end

#count.times do |x|
  #amalgalite_run(count)
#end
