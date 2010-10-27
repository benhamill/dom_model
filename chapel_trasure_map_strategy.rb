require 'strategy'

class ChapelTreasureMap < Strategy
  def counts
    @tm_count = 0
    @chapel_count = 0
    @copper_count = 7
    @p_count = 0
  end

  def action_phase
    if @p.hand.count(:treasure_map) == 2
      @p.play :treasure_map
      puts "Playing Treasure Maps." if verbose?
    elsif @p.hand.include? :chapel
      keepers = [:chapel, :treasure_map, :province, :gold]

      keepers << :copper if @copper_count <= 4 and @tm_count < 2

      cards = @p.hand.reject { |card| keepers.include? card }
      cards.delete_first(:copper) if cards.count(:copper) >= 4 and @tm_count < 2
      @copper_count -= cards.count(:copper)

      unless cards.empty?
        @p.play :chapel, :cards => cards
        puts "Playing Chapel with: #{cards.inspect}" if verbose?
      end
    else
      puts "Doing nothing." if verbose?
    end
  end

  def buy_phase
    if @tm_count < 2 and @p.can_afford?(:treasure_map)
      @p.buy :treasure_map
      puts "Buying Treasure Map." if verbose?
      @tm_count += 1
    elsif @chapel_count < 1 and @p.can_afford?(:chapel)
      @p.buy :chapel
      puts "Buying Chapel." if verbose?
      @chapel_count += 1
    elsif @p.can_afford?(:province)
      @p.buy :province
      puts "Buying Province." if verbose?
      @p_count += 1
    elsif @p.can_afford?(:gold)
      @p.buy :gold
      puts "Buying Gold." if verbose?
    else
      puts "Buying nothing." if verbose?
    end
  end

  def stop_conditions
    @p_count >= 6
  end
end

class Array
  def delete_first item
    self.delete_at(self.index(item))
  end
end
