require 'player'

@games_over_100 = 0
@games_array = []

def run
  p = Player.new
  @p = p

  tm_count = 0
  chapel_count = 0
  played_treasure_maps = false
  copper_count = 7
  p_count = 0

  while true do
    # puts "Turn ##{p.turn_number}"
    # puts "Hand: #{p.hand.inspect}"

    if p.turn_number > 100
      # puts "Exiting for too many turns."
      @games_over_100 += 1
      break
    end

    #action phase
    if p.hand.count(:treasure_map) == 2
      p.treasure_map
      # puts "Playing Treasure Maps."
      if played_treasure_maps
        # puts "Playing second TMs."
      else
        played_treasure_maps = true
      end
    elsif p.hand.include? :chapel
      keepers = [:chapel, :treasure_map, :province, :gold]

      keepers << :copper if copper_count <= 4 and tm_count < 2

      cards = p.hand.reject { |card| keepers.include? card }
      cards.delete_at(cards.index(:copper)) if cards.count(:copper) >= 4 and tm_count < 2
      copper_count -= cards.count(:copper)
      p.chapel(*cards)
      # puts "Playing Chapel with: #{cards.inspect}"
    end

    #buy phase
    if tm_count < 2 and p.hand_value >= 4
      p.buy :treasure_map
      # puts "Buying Treasure Map."
      tm_count += 1
    elsif chapel_count < 1 and p.hand_value >= 2
      p.buy :chapel
      # puts "Buying Chapel."
      chapel_count += 1
    elsif p.hand_value >= 8
      p.buy :province
      # puts "Buying Province."
      p_count += 1
    elsif p.hand_value >= 6
      p.buy :gold
    end

    if p_count >= 6
      @games_array << p.turn_number
      # puts p.inspect
      break
    end

    p.end_turn
  end

  # puts p.inspect
end

# 100_000.times do
#   run
#   if @p.turn_number == 12
#     puts @p.inspect
#     break
#   end
# end

100_000.times { run }

# run

puts @p.inspect

puts "Games over 100 turns: #{@games_over_100}"
puts "Games under 100 turns: #{@games_array.length}"
puts "Min: #{@games_array.min} Max: #{@games_array.max} Avg: #{@games_array.inject(0.0) { |total, item| total += item} / @games_array.length }"
