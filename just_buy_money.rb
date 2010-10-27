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
  end

  def stop_conditions
    @p_count >= 6
  end
end
