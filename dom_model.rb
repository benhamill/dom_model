require 'player'
require 'chapel_treasure_map'
require 'just_buy_money'

class Array
  def delete_first item
    self.delete_at(self.index(item))
  end
end
