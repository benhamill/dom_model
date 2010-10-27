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

  def village options
    draw 1
    @p.actions_left += 2
  end

  def smithy options
    draw 3
  end
end
