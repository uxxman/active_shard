require_relative 'lib/active_shard/version'

Gem::Specification.new do |spec|
  spec.name        = 'active_shard'
  spec.version     = ActiveShard::VERSION
  spec.authors     = ['Usman']
  spec.email       = ['uxman.sherwani@gmail.com']
  spec.homepage    = 'https://github.com/uxxman/active_shard'
  spec.summary     = 'Rails horizontal sharding helper'
  spec.description = 'Helper to ease rails horizontal sharding.'

  spec.required_ruby_version = Gem::Requirement.new('>= 3.1.3')

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['{lib}/**/*', 'README.md']

  spec.add_runtime_dependency 'rails', '>= 7.0.4'
end
