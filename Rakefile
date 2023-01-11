# exec test (tests/**/*_test.rb)
# this is the default task
task :test do
  Dir.glob('tests/**/*_test.rb').each do |file|
    sh "ruby #{file}"
  end
end

task default: :test
