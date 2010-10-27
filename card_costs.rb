class Player
  CARD_COSTS = {
    :copper => 0,
    :silver => 3,
    :gold => 6,

    :estate => 2,
    :duchy => 5,
    :province => 8,

    :chapel => 2,
    :treasure_map => 4,
  }

  def can_afford? card
    hand_value >= CARD_COSTS[card]
  end

  def hand_value
    hand.inject(0) do |coins, card|
      coins += 1 if card == :copper
      coins += 2 if card == :silver
      coins += 3 if card == :gold

      coins
    end
  end
end
