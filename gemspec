# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'abnf-utils'
  s.version = '0.0.1'

  s.authors = ['Nathan Ladd']
  s.email = 'nathanladd+github@gmail.com'
  s.homepage = 'https://github.com/ntl/abnf-pg'
  s.licenses = %w(MIT)
  s.summary = 'ABNF parser generator for ruby'
  s.description = 'ABNF parser generator for ruby'

  s.require_paths = %w(lib)
  s.files = Dir.glob 'lib/**/*'
  s.platform = Gem::Platform::RUBY

  s.add_development_dependency 'test_bench', '~> 0', '>= 0.3.3'
end
