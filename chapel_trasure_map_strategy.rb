require 'strategy'

class ChapelTreasureMap < Strategy
  def counts
    @tm_count = 0
    @chapel_count = 0
    @played_treasure_maps = false
    @copper_count = 7
    @p_count = 0
  end

  def action_phase
    if @p.hand.count(:treasure_map) == 2
      @p.treasure_map
      puts "Playing Treasure Maps." if verbose?
      if @played_treasure_maps
        puts "Playing second TMs." if verbose?
      else
        @played_treasure_maps = true
      end
    elsif @p.hand.include? :chapel
      keepers = [:chapel, :treasure_map, :province, :gold]

      keepers << :copper if @copper_count <= 4 and @tm_count < 2

      cards = @p.hand.reject { |card| keepers.include? card }
      cards.delete_at(cards.index(:copper)) if cards.count(:copper) >= 4 and @tm_count < 2
      @copper_count -= cards.count(:copper)
      @p.chapel(*cards)
      puts "Playing Chapel with: #{cards.inspect}" if verbose?
    end
  end

  def buy_phase
    if @tm_count < 2 and @p.hand_value >= 4
      @p.buy :treasure_map
      puts "Buying Treasure Map." if verbose?
      @tm_count += 1
    elsif @chapel_count < 1 and @p.hand_value >= 2
      @p.buy :chapel
      puts "Buying Chapel." if verbose?
      @chapel_count += 1
    elsif @p.hand_value >= 8
      @p.buy :province
      puts "Buying Province." if verbose?
      @p_count += 1
    elsif @p.hand_value >= 6
      @p.buy :gold
      puts "Buying Gold." if verbose?
    end
  end

  def stop_conditions
    if @p_count >= 6
      return true
    end
  end
end
