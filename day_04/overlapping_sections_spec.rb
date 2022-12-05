require 'rspec'
require_relative './overlapping_sections'

RSpec.describe CampCleanupRoster do
  describe '#fully_containing_pairs' do
    it 'returns the ranges where one completely fits in the other' do
      section_assignments = [
        [[1,4], [2,3]],
        [[1,2], [3,4]]
      ]

      roster = described_class.new(section_assignments)

      expected_pairs = section_assignments.first.map { Range.new *_1 }
      expect(roster.fully_containing_pairs).to eq([expected_pairs])
    end
  end

  describe '#overlapping_pairs' do
    it 'returns the ranges that intersect' do
      section_assignments = [
        [[1,4], [4,5]],
        [[1,2], [3,4]],
        [[2,6], [3,9]]
      ]

      roster = described_class.new(section_assignments)

      expected_pairs = [
        section_assignments.first.map { Range.new *_1 },
        section_assignments.last.map { Range.new *_1 }
      ]

      expect(roster.overlapping_pairs).to eq(expected_pairs)
    end
  end
end
