class Player
  private

  def treasure_map options
    trash :treasure_map
    play_area.delete_first :treasure_map
    @deck += [:gold, :gold, :gold, :gold]
  end

  def chapel options
    trash *options[:cards]
  end
end
