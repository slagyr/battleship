require 'limelight/util'

module Profile

  attr_reader :profile
  prop_reader :player_name, :author_name, :description
  prop_reader :coverage_graph, :flog_graph, :simplicity_graph, :battle_graph

  def profile=(player_profile)
    @profile = player_profile
    player_name.text = @profile.name
    author_name.text = @profile.author
    description.text = @profile.description

    battle_graph.populate(@profile.battle_score, @profile.battle_score.to_s)
    simplicity_graph.populate(@profile.simplicity_score, @profile.simplicity_score.to_s)
    coverage_graph.populate(@profile.coverage_score, @profile.coverage_score.to_s)
    flog_graph.populate(@profile.flog_score, @profile.flog_score.to_s)
  end

end