require 'player'

class Strategy
  # Feel free to override these two:
  def counts; @province_count = 0; end
  def stop_conditions; @province_count >= 6; end

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
    @player = Player.new
    counts

    loop do
      puts "\n--------------- TURN #{@player.turn_number} ---------------" if verbose?
      puts @player.inspect if verbose?

      if @player.turn_number > @turn_limit
        puts "Exiting for too many turns." if verbose?
        @games_over_limit += 1
        break
      end

      puts "Action Phase:" if verbose?
      while @player.actions_left > 0
        puts "Hand: #{@player.hand.inspect}" if verbose?
        action_phase
        puts "Play Area: #{@player.play_area.inspect}" if verbose?
        puts "Actions: #{@player.actions_left} Buys: #{@player.buys_left}" if verbose?
      end

      puts "Buy Phase ($#{@player.hand_value}):" if verbose?
      puts "Hand: #{@player.hand.inspect}" if verbose?
      while @player.buys_left > 0
        buy_phase
        puts "Actions: #{@player.actions_left} Buys: #{@player.buys_left}" if verbose?
      end

      if stop_conditions
        @games_array << @player.turn_number
        break
      end

      @player.end_turn
    end
  end

  def report iterations
    puts @player.inspect # Show last player object.

    puts "Games played: #{iterations}"
    puts "Games over #{@turn_limit} turns: #{@games_over_limit}"
    puts "Games under #{@turn_limit} turns: #{@games_array.length}"
    puts "Min: #{@games_array.min} Max: #{@games_array.max} Avg: #{@games_array.inject(0.0) { |total, item| total += item} / @games_array.length }"
  end
end
