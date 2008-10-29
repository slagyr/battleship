module ResultGraph

  def self.extended(prop)
    prop.build do
      result_graph_bar :width => "50%"
      result_graph_text :text => "No results collected"
    end
  end

  def score
    return @score
  end

  def populate(score, text)
    @score = score
    bar = find_by_name("result_graph_bar")[0]
    bar.style.width = "#{score}%"
    if score < 25
      bar.style.background_color = "red"
    elsif score < 50
      bar.style.background_color = "orange"
    elsif score < 75
      bar.style.background_color = "yellow"
    else
      bar.style.background_color = "green"
    end
    find_by_name("result_graph_text")[0].text = text  
  end

end