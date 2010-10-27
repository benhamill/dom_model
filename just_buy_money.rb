require 'strategy'

class JustBuyMoney < Strategy
  def counts
    @province_count = 0
  end

  def action_phase
    # Nothing for this strategy.
  end

  def buy_phase
    if @player.can_afford? :province
      @player.buy :province
      puts "Buying Province." if verbose?
      @province_count += 1
    elsif @player.can_afford? :gold
      @player.buy :gold
      puts "Buying Gold." if verbose?
    elsif @player.can_afford? :silver
      @player.buy :silver
      puts "Buying Silver." if verbose?
    end
  end

  def stop_conditions
    @province_count >= 6
  end
end
