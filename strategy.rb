require 'player'

module Strategy
  def initialize
    @games_over_100 = 0
    @games_array = []
  end

  def run iterations
    iterations.times { play_game }
  end

  def play_game
    @p = Player.new

    loop do
      # puts "Turn ##{@p.turn_number}"
      # puts "Hand: #{@p.hand.inspect}"

      if @p.turn_number > 100
        # puts "Exiting for too many turns."
        @games_over_100 += 1
        break
      end

      action_phase
      buy_phase
      break if stop_conditions

      @p.end_turn
    end
  end

  def report
    puts @p.inspect

    puts "Games over 100 turns: #{@games_over_100}"
    puts "Games under 100 turns: #{@games_array.length}"
    puts "Min: #{@games_array.min} Max: #{@games_array.max} Avg: #{@games_array.inject(0.0) { |total, item| total += item} / @games_array.length }"
  end
end
