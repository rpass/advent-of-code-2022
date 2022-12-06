require_relative './supply_stacks.rb'

file_data = File.open(File.path("#{__dir__}/input.txt")).read

supply_stack_data, crane_instruction_data = file_data.split(/\n\n/)

supply_stacks = SupplyStack.new(supply_stack_data)
crane_instructions = CraneInstructionSet.new(crane_instruction_data)

p "Crane 9000"
p Crane.new(supply_stacks).execute_instructions(crane_instructions).map(&:last).join

supply_stacks_9001 = SupplyStack.new(supply_stack_data)
p "Crane 9001"
p Crane.new(supply_stacks_9001).execute_instructions(crane_instructions, 9001).map(&:last).join
