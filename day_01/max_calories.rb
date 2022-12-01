file_data = File.open(File.path("#{__dir__}/input.txt")).read

elf_knapsacks = file_data.split("\n\n").map { _1.split("\n") }

def part_one(elf_knapsacks)
  elf_knapsacks.map {_1.map(&:to_i).sum}.max
end

def part_two(elf_knapsacks)
  elf_knapsacks.map {_1.map(&:to_i).sum}.sort.last(3).sum
end

puts "Part I:", part_one(elf_knapsacks)
puts "Part II:", part_two(elf_knapsacks)
