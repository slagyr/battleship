require 'limelight/util'

module Profile

  attr_reader :profile
  prop_reader :player_name, :author_name, :description
  prop_reader :coverage_graph, :flog_graph, :simplicity_graph, :battle_graph, :average_graph
  prop_reader :player_list

  def profile=(player_profile)
    @profile = player_profile
    player_name.text = @profile.name
    author_name.text = @profile.author
    description.text = @profile.description

    average_graph.populate(@profile.average_score, @profile.average_score.to_s)
    battle_graph.populate(@profile.battle_score, @profile.battle_score.to_s)
    simplicity_graph.populate(@profile.simplicity_score, @profile.simplicity_score.to_s)
    coverage_graph.populate(@profile.coverage_score, @profile.coverage_score.to_s)
    flog_graph.populate(@profile.flog_score, @profile.flog_score.to_s)
  end

  def perform_analysis
    average_graph.populate(0, "analyzing...")
    battle_graph.populate(0, "analyzing...")
    simplicity_graph.populate(0, "analyzing...")
    coverage_graph.populate(0, "analyzing...")
    flog_graph.populate(0, "analyzing...")   
    @profile.perform_analysis(self)
  end

  def update_battle_score(score, description)
    battle_graph.populate(score, description)
  end

  def update_simplicity_score(score, description)
    simplicity_graph.populate(score, description)
  end

  def update_coverage_score(score, description)
    coverage_graph.populate(score, description)
  end

  def update_flog_score(score, description)
    flog_graph.populate(score, description)
  end

  def update_average_score(score)
    average_graph.populate(score, score.to_s)
    player_list.find_by_name("player_list_item").each do |item|
      item.update if item.profile == profile
    end
  end

end