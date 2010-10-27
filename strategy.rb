require 'player'

class Strategy
  def initialize verbose = false
    @games_over_100 = 0
    @games_array = []
    @verbose = verbose
  end

  def verbose?
    !!@verbose
  end

  def run iterations=100_000
    iterations.times { play_game }
    report(iterations)
  end

  def play_game
    @p = Player.new
    counts

    loop do
      puts "Turn ##{@p.turn_number}" if verbose?
      puts "Hand: #{@p.hand.inspect}" if verbose?

      if @p.turn_number > 100
        puts "Exiting for too many turns." if verbose?
        @games_over_100 += 1
        break
      end

      action_phase
      buy_phase
      break if stop_conditions

      @p.end_turn
    end
  end

  def report iterations
    puts @p.inspect

    puts "Games played: #{iterations}"
    puts "Games over 100 turns: #{@games_over_100}"
    puts "Games under 100 turns: #{@games_array.length}"
    puts "Min: #{@games_array.min} Max: #{@games_array.max} Avg: #{@games_array.inject(0.0) { |total, item| total += item} / @games_array.length }"
  end
end
