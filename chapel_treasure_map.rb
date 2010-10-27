require 'strategy'

class ChapelTreasureMap < Strategy
  def counts
    super

    @tm_count = 0
    @chapel_count = 0
    @copper_count = 7
  end

  def action_phase
    if @player.hand.count(:treasure_map) == 2
      @player.play :treasure_map
      puts "Playing Treasure Maps." if verbose?
    elsif @player.hand.include? :chapel
      keepers = [:chapel, :treasure_map, :province, :gold]

      keepers << :copper if @copper_count <= 4 and @tm_count < 2

      cards = @player.hand.reject { |card| keepers.include? card }
      cards.delete_first(:copper) if cards.count(:copper) >= 4 and @tm_count < 2
      @copper_count -= cards.count(:copper)

      if cards.empty?
        @player.pass_actions # avoid infinite loop
      else
        @player.play :chapel, :cards => cards
        puts "Playing Chapel with: #{cards.inspect}" if verbose?
      end
    else
      @player.pass_actions
      puts "Doing nothing." if verbose?
    end
  end

  def buy_phase
    if @tm_count < 2 and @player.can_afford?(:treasure_map)
      @player.buy :treasure_map
      puts "Buying Treasure Map." if verbose?
      @tm_count += 1
    elsif @chapel_count < 1 and @player.can_afford?(:chapel)
      @player.buy :chapel
      puts "Buying Chapel." if verbose?
      @chapel_count += 1
    elsif @player.can_afford?(:province)
      @player.buy :province
      puts "Buying Province." if verbose?
      @province_count += 1
    elsif @player.can_afford?(:gold)
      @player.buy :gold
      puts "Buying Gold." if verbose?
    else
      puts "Buying nothing." if verbose?
      @player.pass_buys
    end
  end
end
