require 'card_costs'
require 'card_effects'

class Player
  attr_reader :hand, :turn_number, :deck, :discard_pile, :play_area, :actions_left, :buys_left

  def initialize
    @deck = [:estate, :estate, :estate, :copper, :copper, :copper, :copper, :copper, :copper, :copper].shuffle
    @hand = []
    @discard_pile = []
    @play_area = []
    @turn_number = 1
    @actions_left = 1
    @buys_left = 1

    self.draw
  end

  def play card, options = {}
    @actions_left -= 1
    @play_area << hand.delete_first(card)
    self.send card, options
  end

  def pass_actions
    @actions_left = 0
  end

  def trash *cards
    cards.each do |card|
      hand.delete_first card
    end
  end

  def shuffle
    @deck += @discard_pile
    @discard_pile = []
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
    @buys_left -= 1
    @discard_pile << card
  end

  def pass_buys
    @buys_left = 0
  end

  def discard
    @discard_pile += @hand
    @discard_pile += @play_area
    @hand = []
    @play_area = []
  end

  def end_turn
    discard
    @turn_number += 1
    @actions_left = 1
    @buys_left = 1
    draw
  end
end
