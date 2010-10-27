require 'strategy'

class JustBuyMoney < Strategy
  def counts
    @copper_count = 7
    @p_count = 0
  end

  def action_phase
    # Nothing for this strategy.
  end

  def buy_phase
    if @p.can_afford? :province
      @p.buy :province
      puts "Buying Province." if verbose?
      @p_count += 1
    elsif @p.can_afford? :gold
      @p.buy :gold
      puts "Buying Gold." if verbose?
    elsif @p.can_afford? :silver
      @p.buy :silver
      puts "Buying Silver." if verbose?
    end
  end

  def stop_conditions
    @p_count >= 6
  end
end
