require 'rake/testtask'

Rake::TestTask.new do |t|
  ENV["ENV"] = "test"
  t.libs.push 'test'
  t.pattern = '*_spec.rb'
end

desc 'Generates a coverage report'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end
