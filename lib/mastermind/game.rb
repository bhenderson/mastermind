#!/usr/bin/env ruby


module Mastermind
  class Game

    attr_accessor :tries

    def initialize(messenger)
      @messenger = messenger
      @tries = 8
    end

    def start(code)
      @messenger.puts "Welcome to Mastermind! You have eight guesses"
      @messenger.puts "Enter guess:"
      @code = code
    end

    def process_guess(guess)
      @guess = guess.map {|x| x.split(//)}.flatten
    end

    def guess(guess)
      process_guess(guess)
      result = [nil, nil, nil, nil]
      tmp = @code.dup
      @guess.each_with_index do |peg,index| 
        if tmp[index] == peg
          result[index] = "b"
          tmp[index] = nil
        end
      end
      @guess.each_with_index do |peg,index|
        if tmp.include?(peg)
          result[index] ||= "w"
          tmp[tmp.index(peg)] = nil
        end
      end

      @tries -= 1 if @tries > 1
      @messenger.puts result.compact.sort.join
      @messenger.puts "You have #{@tries} left!"
    end
  end
end
