module Weather

  STORM_ODDS = 0.25
  
  def weather
    return :stormy if rand <= STORM_ODDS
    :sunny
  end

end
