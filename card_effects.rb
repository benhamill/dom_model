class Player
  private

  def treasure_map
    trash :treasure_map, :treasure_map
    @deck += [:gold, :gold, :gold, :gold]
  end

  def chapel options
    trash *options[:cards]
  end
end
