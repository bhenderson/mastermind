#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), "/../spec_helper")

module Mastermind 
  describe Game do 
    before(:each) do
      @messenger = mock("messenger").as_null_object
      @game = Game.new(@messenger)
    end

    context "starting up" do 
      it "should send a welcome message" do 
        @messenger.should_receive(:puts).with("Welcome to Mastermind! You have eight guesses") 
        @game.start(%w[r g y c])
      end 

      it "should prompt for the first guess (passing the code to start)" do
        @messenger.should_receive(:puts).with("Enter guess:")
        @game.start(%w[r g y c])
      end

      context "marking a guess" do
        before(:each) do
          @game.start(%w[r g y c])                      
        end
        context "with all 4 colors correct in the correct places" do
          it "should mark the guess with bbbb" do
            @messenger.should_receive(:puts).with("bbbb") 
            @game.guess(%w[r g y c]) 
          end
        end
        
        context "with all 4 colors correct and 2 in the correct places" do
          it "should mark the guess with bbww" do
            @messenger.should_receive(:puts).with("bbww")
            @game.guess(%w[r g c y])
          end
        end

        context "with all 4 colors correct and 1 in the correct place" do 
          it "should mark the guess with bwww" do 
            @messenger.should_receive(:puts).with("bwww") 
            @game.guess(%w[y r g c]) 
          end 
        end 

        context "with duplicates in the guess that match a peg in the code" do
          context "by color and position" do
            it "should add a single b to the mark" do
              @game.start(%w[r y g c])
              @messenger.should_receive(:puts).with("bbb")
              @game.guess(%w[r y g g])
            end
          end
        end

        context "after a guess is given, the remaining number of tries should be displayed" do
          context "after the first guess" do
            it "should say 7 tries left" do
              @game.tries.should == 8
              @game.guess(%w[r y g g])
              @game.tries.should == 7
            end
          end
        end

      end #marking a guess

    end 
  end 
end 

