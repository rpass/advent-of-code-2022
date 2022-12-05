require 'set'

class CampCleanupRoster
  def initialize(section_assignments)
    @section_assignments = ranges(section_assignments).to_a
  end

  def fully_containing_pairs
    @section_assignments.filter do |first_range, second_range|
      first_range.to_set.subset?(second_range.to_set) ||
        second_range.to_set.subset?(first_range.to_set)
    end
  end

  def overlapping_pairs
    @section_assignments.filter do |first_range, second_range|
      first_range.to_set.intersect?(second_range.to_set)
    end
  end

  private

  def ranges(section_assignments)
    section_assignments.map do |first_range, second_range|
      [
        (first_range.first..first_range.last),
        (second_range.first..second_range.last)
      ]
    end
  end
end
