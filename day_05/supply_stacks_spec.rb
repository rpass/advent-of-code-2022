require 'rspec'
require_relative './supply_stacks'

RSpec.describe SupplyStack do
  describe '#stacks' do
    it 'returns a list of stacks' do
      input = <<~RAW
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3
      RAW

      supply_stack = SupplyStack.new(input)

      expect(supply_stack.stacks).to eq(
        [["Z", "N"], ["M", "C", "D"], ["P"]]
      )
    end

    it 'returns a list of stacks' do
      input = <<~RAW

      [N]
      [Z]     [P]
       1   2   3
      RAW

      supply_stack = SupplyStack.new(input)

      expect(supply_stack.stacks).to eq(
        [["Z", "N"], [], ["P"]]
      )
    end
  end
end

RSpec.describe CraneInstructionSet do
  describe '#parse_instructions' do
    it 'returns a list instructions' do
      input = <<~RAW
        move 1 from 2 to 1
        move 3 from 1 to 3
        move 2 from 2 to 1
        move 1 from 1 to 2
      RAW

      instruction_set = described_class.new("")

      expect(instruction_set.parse_instructions(input)).to eq(
        [
          [1,2,1],
          [3,1,3],
          [2,2,1],
          [1,1,2]
        ]
      )
    end
  end
end

RSpec.describe Crane do
  describe '#execute_instructions' do
    context 'crane 9000' do
      it 'follows the instructions on the supply stack' do
        stack_input = <<~RAW
            [D]
        [N] [C]
        [Z] [M] [P]
         1   2   3
        RAW
        supply_stack = SupplyStack.new(stack_input)

        instruction_input = <<~RAW
          move 1 from 2 to 1
          move 3 from 1 to 3
          move 2 from 2 to 1
          move 1 from 1 to 2
        RAW

        instruction_set = CraneInstructionSet.new(instruction_input)

        crane = described_class.new(supply_stack)

        expect(crane.execute_instructions(instruction_set)).to eq(
          [["C"], ["M"], ["P", "D", "N", "Z"]]
        )
      end
    end

    context 'crane 9001' do
      it 'follows the multicrate at a time instructions' do
        stack_input = <<~RAW
            [D]
        [N] [C]
        [Z] [M] [P]
         1   2   3
        RAW
        supply_stack = SupplyStack.new(stack_input)

        instruction_input = <<~RAW
          move 1 from 2 to 1
          move 3 from 1 to 3
          move 2 from 2 to 1
          move 1 from 1 to 2
        RAW

        instruction_set = CraneInstructionSet.new(instruction_input)

        crane = described_class.new(supply_stack)

        expect(crane.execute_instructions(instruction_set, 9001)).to eq(
          [["M"], ["C"], ["P", "Z", "N", "D"]]
        )
      end

      it 'moves the crates in the same order they are' do
        stack_input = <<~RAW
        [C]
        [M]
         1   2
        RAW
        supply_stack = SupplyStack.new(stack_input)

        instruction_input = <<~RAW
          move 2 from 1 to 2
        RAW

        instruction_set = CraneInstructionSet.new(instruction_input)

        crane = described_class.new(supply_stack)

        expect(crane.execute_instructions(instruction_set, 9001)).to eq(
          [[], ["M","C"]]
        )
      end

      it 'moves the crates on top of the destination stack' do
        stack_input = <<~RAW
        [C]
        [M] [Z]
         1   2
        RAW
        supply_stack = SupplyStack.new(stack_input)

        instruction_input = <<~RAW
          move 2 from 1 to 2
        RAW

        instruction_set = CraneInstructionSet.new(instruction_input)

        crane = described_class.new(supply_stack)

        expect(crane.execute_instructions(instruction_set, 9001)).to eq(
          [[], ["Z", "M","C"]]
        )
      end
    end
  end
end
