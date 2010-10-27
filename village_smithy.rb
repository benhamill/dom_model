require 'strategy'

class VillageSmithy < Strategy
  def action_phase
    if @player.hand.include? :village
      puts "Playing Village." if verbose?
      @player.play :village
    elsif @player.hand.include? :smithy
      puts "Playing Smithy." if verbose?
      @player.play :smithy
    else
      @player.pass_actions
      puts "Doing nothing." if verbose?
    end
  end

  def buy_phase
    if @player.can_afford? :province
      @player.buy :province
      puts "Buying Province." if verbose?
      @province_count += 1
    elsif @player.can_afford? :gold
      @player.buy :gold
      puts "Buying Gold." if verbose?
    elsif @player.can_afford? :smithy
      @player.buy :smithy
      puts "Buying Smithy." if verbose?
    elsif @player.can_afford? :village
      @player.buy :village
      puts "Buying Village." if verbose?
    else
      @player.pass_buys
      puts "Buying nothing." if verbose?
    end
  end
end
