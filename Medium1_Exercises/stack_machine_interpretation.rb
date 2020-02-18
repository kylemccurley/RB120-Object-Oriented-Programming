# Minilang class to process the operations
# frozen_string_literal: true

class Minilang
  attr_accessor :register

  def initialize(op_string)
    @operations = op_string.split(' ')
    @register = 0
    @stack = []
  end

  def eval
    operations.each do |op|
      case op
      when 'PRINT' then print
      when 'PUSH' then push
      when 'MOD' then mod
      when 'MULT' then mult
      when 'ADD' then add
      when 'POP' then pop
      when 'DIV' then div
      when 'SUB' then sub
      else
        if op.to_i != 0
          self.register = op.to_i
        else
          puts 'That is an invalid operation.'
          break
        end
      end
    end
  end

  private

  attr_reader :operations, :stack

  def print
    puts register
  end

  def push
    stack.push(register)
  end

  def mult
    self.register *= stack.pop
  end

  def mod
    self.register %= stack.pop
  end

  def add
    self.register += stack.pop
  end

  def pop
    self.register = stack.pop
  end

  def div
    self.register /= stack.pop
  end

  def sub
    self.register -= stack.pop
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
