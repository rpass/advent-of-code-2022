require 'rspec'
require_relative '../../lib/day_07/file_directory.rb'

RSpec.describe Phile do
  describe '#size' do
    it 'sums up the sizes of all the Files within the directory' do
      contents = [
        Phile.new('a.txt', 'f', size: 20),
        Phile.new('b.txt', 'f', size: 70),
        Phile.new('c.txt', 'f', size: 10)
      ]

      fd = described_class.new('the_dir', 'd', contents: contents)

      expect(fd.size).to eq(100)
    end

    it 'sums up the sizes of sub directories which contain files' do
      contents = [
        Phile.new('a', 'd', contents: [
          Phile.new('a.txt', 'f', size: 70),
        ]),
        Phile.new('b', 'd', contents: [
          Phile.new('b.txt', 'f', size: 30)
        ])
      ]

      fd = described_class.new('the_dir', 'd', contents: contents)

      expect(fd.size).to eq(100)
    end
  end

  describe '.parse' do
    it 'parses input into a collection of Philes' do
      input = <<~INPUT
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
      INPUT

      expected_phile_directory = Phile.new('/', 'd', contents: [
        Phile.new('a', 'd', contents: [
          Phile.new('e', 'd', contents: [
            Phile.new('i', 'f', size: 584),
          ]),
          Phile.new('f', 'f', size: 29116),
          Phile.new('g', 'f', size: 2557),
          Phile.new('h.lst', 'f', size: 62596),
        ]),
        Phile.new('b.txt', 'f', size: 14848514),
        Phile.new('c.dat', 'f', size: 8504156),
        Phile.new('d', 'd', contents: [
          Phile.new('j', 'f', size: 4060174),
          Phile.new('d.log', 'f', size: 8033020),
          Phile.new('d.ext', 'f', size: 5626152),
          Phile.new('k', 'f', size: 7214296),
        ]),
      ])

      expect(described_class.parse(input)).to eq(expected_phile_directory)
    end
  end
end
