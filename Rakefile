# encoding: utf-8
require 'rake'
generators = %w(fbdoorman)

namespace :generator do
  desc "Run the fbdoorman generator"
  task :minifbclearance do
    system "cd test/rails_root && ./script/generate fbdoorman -f && rake db:migrate db:test:prepare"
  end
end

task :default => []

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name        = "fbdoorman"
  gem.summary     = "Rails authentication with facebook single sign-on OR email & password."
  gem.description = "Painless user registration and sign-in using Facebook single sign-on with JS. Typical email login still works too."
  gem.email       = "pelaez89{at}gmail.com"
  gem.version     = "0.0.1"
  gem.homepage    = "http://github.com/davidpelaez/minifb-clearance"
  gem.authors     = ["Fbdoorman: David Pelaez","MiniFB:Appoxy","Dan Croak", "Mike Burns", "Jason Morrison",
                     "Joe Ferris", "Eugene Bolshakov", "Nick Quaranto",
                     "Josh Nichols", "Mike Breen", "Marcel Görner",
                     "Bence Nagy", "Ben Mabey", "Eloy Duran",
                     "Tim Pope", "Mihai Anca", "Mark Cornick",
                     "Shay Arnett", "Jon Yurek", "Chad Pytel"]
  gem.files       = FileList["[A-Z]*", "{app,config,generators,lib,shoulda_macros,rails}/**/*"]
end

Jeweler::GemcutterTasks.new
