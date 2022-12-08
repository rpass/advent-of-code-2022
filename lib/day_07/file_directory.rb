class Phile
  attr_reader :name, :type, :size
  attr_accessor :contents, :parent

  def initialize(name, type, size: 0, contents: [], parent: nil)
    @name = name
    @type = type
    @size = size
    @contents = contents
    @parent = parent
  end

  def self.parse(input)
    input_lines = input.split("\n")
    root = Phile.new(input_lines.first.match(/\$ cd (.+)/).captures.first, 'd', contents: [])
    current_phile = root
    input_lines[1..].each do |input_line|
      if input_line.match(/^dir/)
        current_phile.contents << Phile.new(input_line.split(" ").last, 'd', parent: current_phile)
      elsif input_line.match(/^\d+/)
        output_line = input_line.split(" ")
        current_phile.contents << Phile.new(output_line.last, 'f', size: output_line.first.to_i, parent: current_phile)
      end

      command_match = input_line.match(/\$ (?<command>\w+)\s?(?<options>.*)/)
      next if command_match.nil? || command_match[:command] == 'ls'

      if command_match[:command] == 'cd'
        if command_match[:options].strip != '..'
          current_phile = current_phile.contents[current_phile.contents.index { |f| f.name == command_match[:options] }]
        else
          current_phile = current_phile.parent
        end
      end
    end
    root
  end

  def size
    return @size if @type == 'f'

    @contents.sum(&:size)
  end

  def all_directories
    return [] if type == 'f'

    [self, *contents.flat_map(&:all_directories)]
  end

  def total_small_dirs
    return @size if @type == 'f'

    @contents.filter { _1.type == 'd' && _1.size < 100000 }.sum(&:size)
  end

  def ==(other)
    @name == other.name &&
      @type == other.type &&
      @contents == other.contents
  end
end
