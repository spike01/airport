module Weather

  STORM_ODDS = 0.25
  
  def weather
    rand <= STORM_ODDS ? :stormy : :sunny
  end

end
