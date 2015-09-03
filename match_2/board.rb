require_relative 'card'

class Board

  attr_reader :grid

  ANIMALS = [:anteater, :bear, :cat, :dog, :elephant, :frog, :gorilla,
             :hound, :impala, :jaguar, :kangaroo, :llama, :monkey,
             :newt, :octopus, :porcupine]

  def initialize(size)
    @grid = Array.new(size) { Array.new(size) }
    populate_board
  end

  def display
    @grid.each do |row|
      puts(row.map { |card| card.to_s }.join(" | "))
    end
  end

  def valid_move?(pos)
    row, col = pos

    if row.between?(0, @grid.length - 1) && col.between?(0, @grid.length - 1)
      if self[pos].hidden?
        return true
      end
    end
    false
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  private

    def populate_board
      available_locations = []

      @grid.each_with_index do |row, r|
        row.each_with_index do |node, c|
          available_locations << [r, c]
        end
      end

      until available_locations.empty?
        animal = ANIMALS.sample
        next if @grid.flatten.include?(animal)

        2.times do
          pos = available_locations.shuffle!.shift
          self[pos] = Card.new(animal)
        end
      end
    end
end
