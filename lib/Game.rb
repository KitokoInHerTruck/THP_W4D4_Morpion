require 'colorize'

class Player
    attr_accessor :name, :symbol
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  end
  
  class Board
    attr_accessor :grid
    def initialize
      @grid = {"A1" => " ", "A2" => " ", "A3" => " ",
               "B1" => " ", "B2" => " ", "B3" => " ",
               "C1" => " ", "C2" => " ", "C3" => " "}
    end
  
    def display
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts "    1   2   3"
      puts "  +---+---+---+".colorize(:light_blue)
      puts "A | #{@grid["A1"]} | #{@grid["A2"]} | #{@grid["A3"]} |"
      puts "  +---+---+---+".colorize(:light_blue)
      puts "B | #{@grid["B1"]} | #{@grid["B2"]} | #{@grid["B3"]} |"
      puts "  +---+---+---+".colorize(:light_blue)
      puts "C | #{@grid["C1"]} | #{@grid["C2"]} | #{@grid["C3"]} |"
      puts "  +---+---+---+".colorize(:light_blue)
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
    end
  
    def update(position, symbol)
      @grid[position] = symbol
    end
  
    def empty_positions
      @grid.select { |_, value| value == " " }.keys
    end
  end
  
  class Game
    def initialize
      @board = Board.new
      @player1 = Player.new(get_player_name(1), "X")
      @player2 = Player.new(get_player_name(2), "O")
      @current_player = @player1
    end
  
    def get_player_name(player_number)
      puts "Quel est ton nom petit Padawan #{player_number}?"
      gets.chomp
    end
  
    def switch_players
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  
    def play
      loop do
        @board.display
        position = get_player_choice
        @board.update(position, @current_player.symbol)
        if game_over?
          @board.display
          puts "#{@current_player.name} T'AS GAGNéééééééééééé!!!! Tu veux un PIN'S ??? "
          break
        elsif @board.empty_positions.empty?
          @board.display
          puts "Gros nazes tous les deux. Recommencez !"
          break
        end
        switch_players
      end
    end
  
    def get_player_choice
      puts "#{@current_player.name} (#{@current_player.symbol}), pour choisir une case, écrit par exemple : A1"
      position = gets.chomp
      until @board.grid.keys.include?(position) && @board.grid[position] == " "
        puts "M'enfin !! Choisis une autre cause :| "
        position = gets.chomp
      end
      position
    end
  
    def game_over?
      winning_positions = [["A1", "A2", "A3"], ["B1", "B2", "B3"], ["C1", "C2", "C3"],
      ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"],
      ["A1", "B2", "C3"], ["A3", "B2", "C1"]]
winning_positions.any? do |positions|
positions.all? { |position| @board.grid[position] == @current_player.symbol }
end
end
end

game = Game.new
game.play