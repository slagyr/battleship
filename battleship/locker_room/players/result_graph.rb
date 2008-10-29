module ResultGraph

  prop_reader :profile

  def self.extended(prop)
    prop.build do
      result_graph_bar :width => "0%"
      result_graph_text :text => ""
    end
  end

  def score
    return @score
  end

  def populate(score, text)
    @score = score
    bar = find_by_name("result_graph_bar")[0]
    bar.style.width = "#{score || 0}%"
    bar.style.background_color = profile.profile.color_for_score(score)
    find_by_name("result_graph_text")[0].text = text  
  end

end