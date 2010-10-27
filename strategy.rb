require 'player'

class Strategy
  def initialize verbose = false, turn_limit = 100
    @games_over_limit = 0
    @games_array = []
    @verbose = verbose
    @turn_limit = turn_limit
  end

  def verbose?
    !!@verbose
  end

  def run iterations=1
    iterations.times { play_game }
    report(iterations)
  end

  def play_game
    @p = Player.new
    counts

    loop do
      if verbose?
        puts "Turn ##{@p.turn_number}"
        puts "Hand: #{@p.hand.inspect}"
        puts "Deck: #{@p.deck.inspect}"
        puts "Discard Pile: #{@p.discard_pile.inspect}"
      end

      if @p.turn_number > @turn_limit
        puts "Exiting for too many turns." if verbose?
        @games_over_limit += 1
        break
      end

      puts "Action Phase:" if verbose?
      action_phase
      puts "Play Area: #{@p.play_area.inspect}" if verbose?

      puts "Buy Phase:" if verbose?
      buy_phase

      if stop_conditions
        @games_array << @p.turn_number
        break
      end

      @p.end_turn
    end
  end

  def report iterations
    puts @p.inspect # Show last player object.

    puts "Games played: #{iterations}"
    puts "Games over #{@turn_limit} turns: #{@games_over_limit}"
    puts "Games under #{@turn_limit} turns: #{@games_array.length}"
    puts "Min: #{@games_array.min} Max: #{@games_array.max} Avg: #{@games_array.inject(0.0) { |total, item| total += item} / @games_array.length }"
  end
end
