module Weather

  def weather
    return :stormy if rand <= 0.3
    :sunny
  end
end
