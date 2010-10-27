require 'player'
require 'chapel_treasure_map'
require 'just_buy_money'
require 'village_smithy'

class Array
  def delete_first item
    self.delete_at(self.index(item))
  end
end
