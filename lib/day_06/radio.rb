class Radio
  def initialize(data)
    @data = data
  end

  def marker_index
    marker(@data, 4)
  end

  def message_index
    marker(@data, 14)
  end

  private

  def marker(data, uniq_block_length)
    rolling_window = []
    @data.lazy.each_with_index do |char, index|
      rolling_window.shift unless rolling_window.size < uniq_block_length
      rolling_window << char

      next if index < uniq_block_length - 1

      return index + 1 if rolling_window.uniq.size == uniq_block_length
    end
  end
end
