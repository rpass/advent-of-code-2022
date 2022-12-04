class Rucksack
  attr_reader :items

  def initialize(items='')
    @items = items
  end

  def compartment_items
    [
      @items[0...@items.size / 2],
      @items[@items.size / 2..]
    ]
  end

  def mispacked_item
    compartment_items[0]
      .chars
      .intersection(compartment_items[1].chars)
      .first
  end

  def priority_of(item)
    (('a'..'z').to_a + ('A'..'Z').to_a).index(item) + 1
  end

  def priority_of_mispacked_item
    priority_of(mispacked_item)
  end
end

class ElfGroup
  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def badge
    @rucksacks.map(&:items).map(&:chars).reduce(:intersection).first
  end
end
