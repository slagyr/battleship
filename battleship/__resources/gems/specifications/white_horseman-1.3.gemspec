# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{white_horseman}
  s.version = "1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Doug Bradbury"]
  s.date = %q{2008-12-01}
  s.description = %q{The apocalypse is here}
  s.email = %q{doug@8thlight.com}
  s.files = ["Battleship.Rakefile", "lib", "lib/white_horseman", "lib/white_horseman/analyst.rb", "lib/white_horseman/battlefield.rb", "lib/white_horseman/captain.rb", "lib/white_horseman/cell_status.rb", "lib/white_horseman/coordinates.rb", "lib/white_horseman/fleet_admiral.rb", "lib/white_horseman/opponent.rb", "lib/white_horseman/placement.rb", "lib/white_horseman/scout.rb", "lib/white_horseman/ship.rb", "lib/white_horseman/white_horseman.rb", "pkg", "Rakefile", "spec", "spec/spec_helper.rb", "spec/white_horseman", "spec/white_horseman/analyst_spec.rb", "spec/white_horseman/battlefield_spec.rb", "spec/white_horseman/captain_spec.rb", "spec/white_horseman/cell_status_spec.rb", "spec/white_horseman/coordinates_spec.rb", "spec/white_horseman/fleet_admiral_spec.rb", "spec/white_horseman/opponent_spec.rb", "spec/white_horseman/placement_spec.rb", "spec/white_horseman/scout_spec.rb", "spec/white_horseman/ship_spec.rb", "spec/white_horseman/white_horesman_integration_spec.rb", "spec/white_horseman/white_horseman_spec.rb", "test_data", "test_data/testman.data"]
  s.homepage = %q{http://sparring.rubyforge.org/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sparring}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Battleship Player:White Horseman}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
