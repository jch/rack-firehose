$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-firehose"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jerry Cheung"]
  s.email       = ["jerry@intridea.com"]
  s.homepage    = "https://github.com/jch/rack-firehose"
  s.summary     = %q{Mount rack application alongside Firehose.io}
  s.description = %q{Mount rack application alongside Firehose.io}
  s.license     = "BSD"

  s.rubyforge_project = "rack-firehose"

  s.add_runtime_dependency 'rack'
  s.add_runtime_dependency 'firehose'

  s.files         = `git ls-files`.split("\n").select {|f| f !~ /^example/}
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
