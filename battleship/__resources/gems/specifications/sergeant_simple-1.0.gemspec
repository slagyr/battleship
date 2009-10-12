# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sergeant_simple}
  s.version = "1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Micah Martin"]
  s.date = %q{2008-11-03}
  s.description = %q{A very simple player.}
  s.email = %q{micah@8thlight.com}
  s.files = ["Battleship.Rakefile", "lib", "lib/sergeant_simple", "lib/sergeant_simple/sergeant_simple.rb", "Rakefile", "spec", "spec/sergeant_simple", "spec/sergeant_simple/sergeant_simple_spec.rb", "spec/spec_helper.rb"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Battleship Player:Sergeant Simple}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
