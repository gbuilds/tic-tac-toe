class Game
  attr_accessor :board, :active_player
  
  def initialize(name, name2)
    @player_1 = Player.new(name)
    @player_2 = Player.new(name2)
    @board = Board.new
    @active_player = 1
  end
  
  def check_for_win
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
    mark = active_player == 1 ? "X" : "O"
    move = move_getter
    @board.add_move_to_board(move, mark)
    change_who_moves
    display_who_moves
    show_board
  end
  
  def change_who_moves
    if @active_player == 1
      @active_player = 2
    else
      @active_player = 1
    end
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


newgame = Game.new("Jen", "Ben")
newgame.show_help
newgame.show_board
newgame.turn
newgame.turn
newgame.turn
newgame.turn

# new Game object
# two new player objects
# new board object, which is empty
# new turn
# player modifies the board object
# board object checks itself for a win
# player modifies the board object

# 3 arrays
# occupied, unoccupied
# x , o pieces
# 1, 2, 3
# 4, 5, 6
# 7, 8, 9
# 1, 5, 9
# 3, 5, 7
# 1, 4, 7
# 2, 5, 8
# 3, 6, 9
# player 1, player 2
# board
# player 1 puts an x in any unoccupied square
# is it unoccupied? yes. put an x. now it is occupied
# check if player 1 has 3 x's in a row?
# player 2 views the board. selects spot for O. is it unoccupied? place O.
# it is p1's turn again.
# board... keep track of where x's and o's are placed

