require 'rspec'
require_relative '../../lib/day_06/radio.rb'

RSpec.describe Radio do
  describe '#marker_index' do
    it 'finds the index of the marker' do
      datastream_marker_pairs = [
        ['mjqjpqmgbljsphdztnvjfqwrcgsmlb', 7],
        ['bvwbjplbgvbhsrlpgdmjqwftvncz', 5],
        ['nppdvjthqldpwncqszvftbrmjlhg', 6],
        ['nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 10],
        ['zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 11]
      ]

      radios = datastream_marker_pairs.map { |data, _marker_index| described_class.new(data.chars) }

      expect(radios.map(&:marker_index)).to eq(datastream_marker_pairs.map { _1.last })
    end
  end

  describe '#message_index' do
    it 'finds the index of the message marker' do
      datastream_marker_pairs = [
        ['mjqjpqmgbljsphdztnvjfqwrcgsmlb', 19],
        ['bvwbjplbgvbhsrlpgdmjqwftvncz', 23],
        ['nppdvjthqldpwncqszvftbrmjlhg', 23],
        ['nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 29],
        ['zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 26]
      ]

      radios = datastream_marker_pairs.map { |data, _message_index| described_class.new(data.chars) }

      expect(radios.map(&:message_index)).to eq(datastream_marker_pairs.map { _1.last })
    end
  end
end
