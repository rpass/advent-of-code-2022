require 'rspec'
require_relative './rucksack_reorg.rb'

RSpec.describe Rucksack do
  describe 'compartment_items' do
    it 'splits the items in a rucksack between the two compartments' do
      rucksack = described_class.new('abcdefgh')

      expect(rucksack.compartment_items).to eq(['abcd', 'efgh'])
    end
  end

  describe 'mispacked_item' do
    it 'finds the mispacked item in a rucksack' do
      rucksack = described_class.new('abxdex')

      expect(rucksack.mispacked_item).to eq('x')
    end
  end

  describe 'priority_of_item' do
    it 'returns the priority of the items' do
      rucksack = described_class.new
      item_chars = ('a'..'z').to_a + ('A'..'Z').to_a
      priorities = item_chars.map { rucksack.priority_of(_1) }

      expect(priorities).to eq((1..52).to_a)
    end
  end

  describe 'priority_of_mispacked_item' do
    it 'returns the priority of the mispacked item' do
      rucksack = described_class.new('abxdex')

      expect(rucksack.priority_of_mispacked_item).to eq(24)
    end
  end
end

RSpec.describe ElfGroup do
  describe 'badge' do
    it 'returns the item that all three elves in the group share' do
      rucksacks = [
        Rucksack.new('abcx'),
        Rucksack.new('defx'),
        Rucksack.new('ghix'),
      ]

      elf_group = described_class.new(rucksacks)

      expect(elf_group.badge).to eq('x')
    end
  end
end
