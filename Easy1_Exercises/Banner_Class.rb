=begin
Observations from Test Cases:
  - The width of the banner will be the width of the string + 2 (1 for each side)
  - The height of the banner will always be 3.
  - The width will need to be dynamic in accordance to the length of the string.

  The banner will the format of:
    - horizontal_rule:
      - Beginning will be a +
      - Afterward it is '+-' + (the length of the message * '-') + '-+'
    - empty_line:
      - Will be the horizontal line + an empty space + another horizontal line.
    - message_line:
      - will be the '|' + an empty space + the message + an empty space + the horizontal empty_line
    - horizontal_rule
      - beginning will be a +
      - Afterward it is '+-' + the length of the message * '-') + '-+'.
=end

class Banner
  def initialize(message)
    @length = message.size + 2
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    '+' + ('-' * length) + '+'
  end

  def empty_line
    '|' + (' ' * @length) + '|'
  end

  def message_line
    "| #{message} |"
  end

  private

  attr_reader :length, :message
end
banner = Banner.new('')
puts banner

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
