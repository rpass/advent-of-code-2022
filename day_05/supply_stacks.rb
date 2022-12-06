class SupplyStack
  attr_accessor :stacks

  def initialize(input)
    @stacks = parse_input(input)
  end

  def parse_input(input)
    input_lines = input.split("\n")
    no_of_stacks = input_lines.last.split(" ").last.to_i
    layers = input_lines[0...-1]

    item_layers = layers.map do |layer|
      layer
        .gsub(/\s{4,5}/, " ! ")  # temporarily replace empty spaces with '!'
        .gsub(/\[|\]/, "") # remove '[' and ']'
        .split(" ")
    end

    item_layers
      .map { _1.fill("", _1.length...no_of_stacks) } # padright to prep for transpose
      .transpose
      .map { _1.delete_if { |el| el == '!' || el == ""}.reverse }
  end

  def visualize(stacks_to_vis)
    longest_stack = stacks_to_vis.map(&:size).max
    visual = stacks_to_vis.map { _1.dup.fill(" ", _1.size...longest_stack).reverse }.transpose.map { _1.join(" ") }.join("\n")
    puts visual
  end
end

class CraneInstructionSet
  attr_accessor :instructions
  def initialize(instruction_input)
    @instructions = parse_instructions(instruction_input)
  end

  def parse_instructions(input)
    input
      .split("\n")
      .map { _1.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i) }
  end
end

class Crane
  def initialize(supply_stack)
    @supply_stack = supply_stack
  end

  def execute_instructions(instruction_set, crane_version=9000)
    output_stack = @supply_stack.stacks.clone

    instruction_set.instructions.each do |no_of_crates_to_move, source_index, destination_index|
      p "move #{no_of_crates_to_move} from #{source_index} to #{destination_index}"
      destination_stack = output_stack[destination_index - 1]
      source_stack = output_stack[source_index - 1]

      if crane_version == 9001
        crates_to_move = source_stack.pop(no_of_crates_to_move)
        destination_stack.push(*crates_to_move)
        @supply_stack.visualize(output_stack.clone)
      else
        no_of_crates_to_move.times do
          destination_stack.push(source_stack.pop)
        end
      end
    end

    output_stack
  end
end
