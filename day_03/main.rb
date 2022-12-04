require_relative './rucksack_reorg.rb'

file_data = File.open(File.path("#{__dir__}/input.txt")).read

rucksacks = file_data.split("\n").map { Rucksack.new(_1) }

p "Part I: #{rucksacks.sum { _1.priority_of_mispacked_item }}"

rucksack_groups_of_3 = rucksacks.each_slice(3).to_a
p rucksack_groups_of_3.first.map(&:items)
elf_groups = rucksack_groups_of_3.map { ElfGroup.new(_1) }
badges = elf_groups.map(&:badge)

p "Part II: #{badges.map { Rucksack.new.priority_of(_1) }.sum }"
