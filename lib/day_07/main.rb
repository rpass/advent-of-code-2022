require_relative './file_directory'

file_data = File.open(File.path("#{__dir__}/input.txt")).read

directory = Phile.parse(file_data)

p "Part I"
p directory.all_directories.uniq.filter { _1.size < 100000 }.sum(&:size)

p "Part II"
free_space = 70000000 - directory.size
needed_space = 30000000 - free_space
p directory.all_directories.uniq.filter { _1.size >= needed_space }.min { |a, b| a.size <=> b.size }.size
