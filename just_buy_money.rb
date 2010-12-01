require 'strategy'

class JustBuyMoney < Strategy
  def action_phase
    # Never do any actions
    @player.pass_actions
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
    else
      @player.buy :copper
      puts "Buying Copper." if verbose?
    end
  end
end
