require_relative './overlapping_sections'

file_data = File.open(File.path("#{__dir__}/input.txt")).read

section_assignments = file_data.split("\n").map { _1.split(',').map { |x| x.split('-') } }

cleaning_roster = CampCleanupRoster.new(section_assignments)

cleaning_roster.fully_containing_pairs.size
cleaning_roster.overlapping_pairs.size
