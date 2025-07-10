desc 'Run all performance runs'
task :perf => [:perf_ary, :perf_hash, :perf_prepared]

desc 'Run performance tests for array results'
task :perf_ary do
  sh "bundle exec ruby perf_ary.rb"
end
