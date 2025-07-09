
require_relative './common'
require 'vernier'

def amalgalite_run(count)
  db = Amalgalite::Database.new(DB_PATH, "r")
  db.type_map = ::Amalgalite::TypeMaps::StorageMap.new
  results = db.execute('select * from foo')
  db.close
end

count = 1_000

prepare_database(count)

def extralite_run(count)
  db = Extralite::Database.new(DB_PATH)
  results = db.query_array('select * from foo')
  db.close
end


#Vernier.profile(out: "amalgalite_profile.json") do

  Benchmark.ips do |x|
    x.config(:time => 5, :warmup => 3)
    x.report("amalgalite") { amalgalite_run(count) }
    x.compare!
  end
#end

# Vernier.profile(out: "extralite_profile.json") do
#   1.times do |x|
#     extralite_run(count)
#   end
# end

#count.times do |x|
  #amalgalite_run(count)
#end
