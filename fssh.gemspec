# encoding: UTF-8

# Copyright 2012 Forrager
# http://www.apache.org/licenses/LICENSE-2.0

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'fssh/version'

Gem::Specification.new do |s|
  s.name     = "fssh"
  s.version  = ::FSSH::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cameron@forrager.com"]
  s.homepage = "http://forrager.com"

  s.description = s.summary = "Easily ssh into remote Amazon EC2 hosts by name."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary  = ""

  s.add_dependency 'amazon-ec2', '~> 0.9.17'

  s.require_path = 'lib'

  s.files = Dir["{lib}/**/*", "Gemfile", "History.txt", "LICENSE", "README.md", "Rakefile", "fssh.gemspec"]
  s.executables << "fssh"
  s.executables << "fscp"
  s.executables << "ftunnel"
end
