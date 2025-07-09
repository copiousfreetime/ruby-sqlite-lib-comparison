require './common'

require 'stackprof'

count = 1_000_000

prepare_database(count)

StackProf.run(mode: :cpu,
              raw: true,
              out: 'tmp/stackprof-cpu-amalgalite.dump') do
  db = Amalgalite::Database.new(DB_PATH, "r")
  results = db.execute('select * from foo')
  db.close
end
