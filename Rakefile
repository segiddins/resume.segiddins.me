desc "Initializes your working copy to have the correct submodules and gems"
task :bootstrap do
  puts "Updating submodules..."
  `git submodule update --init --recursive`

  Dir.chdir 'resume' do
    puts 'Building resume'
    puts `bundle install && bundle exec rake generate`
  end

  puts "Installing gems"
  `bundle install`
end
begin
    require 'middleman-gh-pages'

    task :deploy do
      `cp resume/build/resume.html source/index.html.erb`
      `cp 'resume/build/Samuel E. Giddins Resume.pdf' 'source/Samuel E. Giddins Resume.pdf'`
      `cp resume/build/resume.json source/resume.json`
      Rake::Task["publish"].invoke
    end

    desc 'Runs the web server locally and watches for changes'
    task :run do
      sh "bundle exec middleman server --port 4567"
    end
rescue Exception => e
    puts 'You must run `rake bootstrap` first!'
end
