# encoding: utf-8
require 'rake'
generators = %w(clearance clearance_views)

namespace :generator do
  desc "Run the clearance generator"
  task :clearance do
    system "cd test/rails_root && ./script/generate clearance -f && rake db:migrate db:test:prepare"
  end

  desc "Run the clearance views generator"
  task :clearance_views do
    system "cd test/rails_root && ./script/generate clearance_views -f"
  end
end

task :default => []

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name        = "minifbclearance"
  gem.summary     = "Rails authentication with facebook single sign-on OR email & password."
  gem.description = "Painless user registration and sign-in using Facebook single sign-on with JS. Typical email login still works too."
  gem.email       = "pelaez89{at}gmail.com"
  gem.version     = "0.1"
  gem.homepage    = "http://github.com/davidpelaez/minifb-clearance"
  gem.authors     = ["MiniFB:Appoxy","Dan Croak", "Mike Burns", "Jason Morrison",
                     "Joe Ferris", "Eugene Bolshakov", "Nick Quaranto",
                     "Josh Nichols", "Mike Breen", "Marcel Görner",
                     "Bence Nagy", "Ben Mabey", "Eloy Duran",
                     "Tim Pope", "Mihai Anca", "Mark Cornick",
                     "Shay Arnett", "Jon Yurek", "Chad Pytel"]
  gem.files       = FileList["[A-Z]*", "{app,config,generators,lib,shoulda_macros,rails}/**/*"]
end

Jeweler::GemcutterTasks.new
