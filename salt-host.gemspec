lib = File.expand_path("../lib", __FILE__)
STDERR.puts lib
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'salt'

Gem::Specification.new do |spec|
  spec.name          = "salt-host"
  spec.version       = Salt::VERSION
  spec.authors       = ["Peter Meulbroek"]
  spec.email         = ["pmeulbroek@riskfocus.com"]

  spec.summary       = %q{A set of classes that corresponds to a host within vagrant that is configured by salt.  DRY}
  spec.description   =<<END 
Salt config is vagrant is very repetitive.  To avoid a lot of copy-paste, I've created these config classes.  They represent
each of the major config categories of salt:  the minion, the syndic, and the master.  The config is controlled by a config structure
passed to the creator.  This is VERY MUCH a work in progres
END
  spec.homepage      = "https://github.com/petermeulbroek/salt-vagrant"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
#    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/petermeulbroek/salt-vagrant"
    spec.metadata["changelog_uri"] = "https://github.com/petermeulbroek/salt-vagrant"  #FIXME
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
