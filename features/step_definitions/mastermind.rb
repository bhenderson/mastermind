#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---

def messenger
  @messenger ||= StringIO.new
end

def game
  @game ||= Mastermind::Game.new(messenger)
end

def messages_should_include(message)
  messenger.string.split("\n").should include(message)
end

Given /^I am not yet playing$/ do
end

Given /^the secret code is (. . . .)$/ do |code|
  game.start(code.split)
end

When /^I guess (.*)$/ do |code|
  game.guess(code.split)
end

When /^I start a new game$/ do
  game.start(%w[r g y c])
end

Then /^the game should say "(.*)"$/ do |message|
  messages_should_include(message)
end

Then /^the mark should be (.*)$/ do |mark|
  messages_should_include(mark)
end

Then /^the game should say You have (\d+) tries left!$/ do |try|
  messages_should_include(try)
end
