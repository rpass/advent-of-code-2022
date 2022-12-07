require_relative './radio'

file_data = File.open(File.path("#{__dir__}/input.txt")).read

p Radio.new(file_data.chars).marker_index
p Radio.new(file_data.chars).message_index
