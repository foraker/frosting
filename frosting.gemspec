Gem::Specification.new do |s|
  s.name        = 'frosting'
  s.version     = '0.0.9'
  s.date        = '2016-03-22'
  s.summary     = "Let's make presenters easy."
  s.description = "Adds some methods to your controllers and a base presenter. Get that presentation logic out of your models."
  s.authors     = ["Ben Eddy", "Jon Evans"]
  s.email       = 'rubygems@foraker.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'http://www.github.com/foraker/frosting'
  s.license     = 'MIT'

  s.add_dependency "activesupport"

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rspec', '~> 2.0'
end
