class Game
  attr_accessor :board, :active_player
  
  def initialize(name, name2)
    @player_1 = Player.new(name)
    @player_2 = Player.new(name2)
    @board = Board.new
    @active_player = 1
    @gaming = true
  end
  
  def show_board
    @board.display
  end
  
  def show_help
    puts "Make your move by entering a coordinate."
    puts "'?' indicates an open spot."
    puts "Board coordinates:"
    puts "123"
    puts "456"
    puts "789\n\n"
  end
  
  def turn
    while @gaming
      mark = active_player == 1 ? "X" : "O"
      move = move_getter
      @board.add_move_to_board(move, mark)
      if @board.game_won?
        show_board
        declare_victory
        @gaming = false
      elsif @board.game_tied?
        show_board
        @gaming = false
      else
        change_who_moves
        display_who_moves
        show_board
      end
    end
  end
  
  def change_who_moves
    if @active_player == 1
      @active_player = 2
    else
      @active_player = 1
    end
  end
  
  def declare_victory
    name = @active_player == 2 ? @player_2.name : @player_1.name
    puts "#{name} IS THE WINNER!"
  end  
    
  def display_who_moves
    name = @active_player == 2 ? @player_2.name : @player_1.name
    puts "#{name}'s turn."
  end
  
  def move_getter
    good_move = false
    while good_move == false
      if @active_player == 1
        move = @player_1.make_move.to_i
      else
        move = @player_2.make_move.to_i
      end
      if !(1..9).include?(move)
        puts "You didn't enter a number between 1-9."
      elsif !@board.is_space_open?(move)
        puts "You didn't move into an empty space."
      else
        good_move = true
      end
    end
    move
  end
  
end

class Board
  
  def initialize
    @grid = Array.new(9, "?")
  end
  
  def display
    puts "Gameboard:"
    puts @grid[0..2].join
    puts @grid[3..5].join
    puts @grid[6..8].join
  end
  
  def  add_move_to_board(int, mark)
      @grid[int-1] = mark
  end
  
  def is_space_open?(int)
    if @grid[int-1] == "?"
      true
    else
      false
    end
  end
  
  def game_won?
    game_won = false
    paths_to_victory = [
    @grid[0..2],
    @grid[3..5],
    @grid[6..8],
    [@grid[0], @grid[4], @grid[8]],
    [@grid[2], @grid[4], @grid[6]],
    [@grid[0], @grid[3], @grid[6]],
    [@grid[1], @grid[4], @grid[7]],
    [@grid[2], @grid[5], @grid[8]]]

    paths_to_victory.each do |path| 
      if path.join =~ /XXX|OOO/
        puts "Winner!"
        game_won = true
      end
    end
    game_won
  end
  
  def game_tied?
    game_tied = false
    if @grid.all? {|x| x != "?"}
      game_tied = true
      puts "After an intense struggle the game ends in a tie!"
    end
    game_tied
  end

end

class Player
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def make_move
    puts "Enter a coordinate to make your move:"
    @move = gets.chomp.to_i
    @move
  end
end


newgame = Game.new("First Player", "Second Player")
newgame.show_help
newgame.show_board
newgame.turn