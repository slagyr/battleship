# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{statemachine}
  s.version = "0.4.1"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Micah Martin"]
  s.autorequire = %q{statemachine}
  s.cert_chain = nil
  s.date = %q{2007-05-20}
  s.description = %q{Statemachine is a ruby library for building Finite State Machines (FSM), also known as Finite State Automata (FSA).}
  s.email = %q{statemachine-devel@rubyforge.org}
  s.files = ["CHANGES", "LICENSE", "Rakefile", "README", "TODO", "lib/statemachine.rb", "lib/statemachine/action_invokation.rb", "lib/statemachine/builder.rb", "lib/statemachine/state.rb", "lib/statemachine/statemachine.rb", "lib/statemachine/superstate.rb", "lib/statemachine/transition.rb", "lib/statemachine/version.rb", "spec/action_invokation_spec.rb", "spec/builder_spec.rb", "spec/default_transition_spec.rb", "spec/history_spec.rb", "spec/sm_action_parameterization_spec.rb", "spec/sm_entry_exit_actions_spec.rb", "spec/sm_odds_n_ends_spec.rb", "spec/sm_simple_spec.rb", "spec/sm_super_state_spec.rb", "spec/sm_turnstile_spec.rb", "spec/spec_helper.rb", "spec/transition_spec.rb"]
  s.homepage = %q{http://statemachine.rubyforge.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{statemachine}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Statemachine-0.4.1 - Statemachine Library for Ruby http://statemachine.rubyforge.org/}
  s.test_files = ["spec/action_invokation_spec.rb", "spec/builder_spec.rb", "spec/default_transition_spec.rb", "spec/history_spec.rb", "spec/sm_action_parameterization_spec.rb", "spec/sm_entry_exit_actions_spec.rb", "spec/sm_odds_n_ends_spec.rb", "spec/sm_simple_spec.rb", "spec/sm_super_state_spec.rb", "spec/sm_turnstile_spec.rb", "spec/transition_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
