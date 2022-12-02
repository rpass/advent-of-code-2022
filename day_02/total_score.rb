file_data = File.open(File.path("#{__dir__}/input.txt")).read

rounds = file_data.split("\n").map(&:split)

module RPS
  def versus(other)
    return 6 if beats == other
    return 0 if loses_to == other

    3
  end
end

class Rock
  extend ::RPS

  def self.selection_score
    1
  end

  def self.beats
    Scissors
  end

  def self.loses_to
    Paper
  end
end

class Paper
  extend ::RPS

  def self.selection_score
    2
  end

  def self.beats
    Rock
  end

  def self.loses_to
    Scissors
  end
end

class Scissors
  extend ::RPS

  def self.selection_score
    3
  end

  def self.beats
    Paper
  end

  def self.loses_to
    Rock
  end
end

def round_outcome_score_part_one(their_choice, your_choice)
  their_shape = {
    'A': Rock,
    'B': Paper,
    'C': Scissors
  }[their_choice.to_sym]

  your_shape = {
    'X': Rock,
    'Y': Paper,
    'Z': Scissors,
  }[your_choice.to_sym]

  your_shape.versus their_shape
end

def round_outcome_score_part_two(their_choice, the_outcome)
  {
    'X': 0,
    'Y': 3,
    'Z': 6,
  }[the_outcome.to_sym]
end

def your_choice_score_part_one(your_choice)
  {
    'X': Rock,
    'Y': Paper,
    'Z': Scissors,
  }[your_choice.to_sym].selection_score
end

def your_choice_score_part_two(their_choice, the_outcome)
  their_shape = {
    'A': Rock,
    'B': Paper,
    'C': Scissors
  }[their_choice.to_sym]

  your_shape = {
    'X': their_shape.beats,
    'Y': their_shape,
    'Z': their_shape.loses_to,
  }[the_outcome.to_sym]

    your_shape.selection_score
end

def total_score_part_one(rounds)
  rounds.reduce(0) do |total, round|
    opponents_choice, your_choice = round
    round_score = your_choice_score_part_one(your_choice) + round_outcome_score_part_one(opponents_choice, your_choice)

    total + round_score
  end
end

def total_score_part_two(rounds)
  rounds.reduce(0) do |total, round|
    opponents_choice, the_outcome = round
    round_score = your_choice_score_part_two(opponents_choice, the_outcome) + round_outcome_score_part_two(opponents_choice, the_outcome)

    total + round_score
  end
end

total_score_part_one(rounds)
total_score_part_two(rounds)
