class Player
  def treasure_map
    trash :treasure_map, :treasure_map
    4.times { @deck << :gold }
  end

  def chapel *cards
    trash *cards
  end
end
