class Player
  def treasure_map
    trash :treasure_map, :treasure_map
    @deck += [:gold, :gold, :gold, :gold]
  end

  def chapel *cards
    trash *cards
  end
end
