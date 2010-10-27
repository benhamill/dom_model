require 'card_costs'
require 'card_effects'

class Player
  attr_reader :hand, :turn_number

  def initialize
    @deck = [:estate, :estate, :estate, :copper, :copper, :copper, :copper, :copper, :copper, :copper].shuffle
    @hand = []
    @discard = []
    @play_area = []
    @turn_number = 1

    self.draw
  end

  def play card, options = {}
    @play_area << remove_card_from_hand card
    self.send card, options
  end

  def trash *cards
    cards.each do |card|
      remove_card_from_hand card
    end
  end

  def shuffle
    @deck += @discard
    @discard = []
    @deck.shuffle
  end

  def draw(num = 5)
    cards = @deck.pop(num)

    if cards.length < num
      more = num - cards.length
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
    @discard += @play_area
    @hand = []
    @play_area = []
  end

  def end_turn
    discard
    @turn_number += 1
    draw
  end

  private

  def remove_card_from_hand card
    @hand.delete_at(@hand.index(card))
  end
end
