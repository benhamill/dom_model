class Player
  attr_reader :hand, :turn_number

  def initialize
    @deck = [:estate, :estate, :estate, :copper, :copper, :copper, :copper, :copper, :copper, :copper].shuffle
    @hand = []
    @discard = []
    @turn_number = 1

    self.draw
  end

  def trash *cards
    cards.each do |card|
      @hand.delete_at(@hand.index(card))
    end
  end

  def shuffle
    @deck += @discard
    @discard = []
    @deck.shuffle
  end

  def draw(num = 5)
    cards = @deck.pop(num)

    if cards.length < 5
      more = 5 - cards.length
      shuffle
      cards += @deck.pop(more)
    end

    @hand += cards
  end

  def buy card
    @discard << card
  end

  def discard
    @discard += @hand
    @hand = []
  end

  def end_turn
    discard
    @turn_number += 1
    draw
  end

  def treasure_map
    trash :treasure_map, :treasure_map
    4.times { @deck << :gold }
  end

  def chapel *cards
    trash *cards
  end

  def hand_value
    hand.inject(0) do |coins, card|
      coins += 1 if card == :copper
      coins += 3 if card == :gold

      coins
    end
  end
end
