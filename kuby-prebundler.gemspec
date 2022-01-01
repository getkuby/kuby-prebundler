$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'kuby/prebundler/version'

Gem::Specification.new do |s|
  s.name     = 'kuby-prebundler'
  s.version  = ::Kuby::Prebundler::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/getkuby/kuby-prebundler'

  s.description = s.summary = 'Use Prebundler to install your bundle when building Docker images with Kuby.'

  s.platform = Gem::Platform::RUBY

  s.add_dependency 'kuby-core', '>= 0.16.0', '< 1.0'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'kuby-prebundler.gemspec']
end
