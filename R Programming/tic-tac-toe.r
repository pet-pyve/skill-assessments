# Creating Tic Tac Toe in R!

library(gsubfn)

# getting input from user
input <- function(input_str) {
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  cat(input_str)
  symbol <- readLines(con = con, n = 1)
}

print_board <- function(board) {
  Sys.sleep(1)
  cat("\nCurrent board: \n")
  cat("\n~~~~~~~~~~~~~~~~~~~\n")
  print(board)
  cat("~~~~~~~~~~~~~~~~~~~\n")
  Sys.sleep(1)
}

# print output at the start of each loop
print_round_info <- function(round_num, board) {
  cat("\n########################\n")
  cat("\n###### Round #", round_num, " ######\n")
  cat("\n########################\n")
  print_board(board)
}

#added function for readability
is_space_free <- function(board, pos) {
  return(is.na(board[pos]))
}

#return winning move position
check_for_winning_move <- function(symbol, board) {
  for (i in 1:9) {
    if(is_space_free(board, i)) {
      board_dup <- board
      board_dup[i] <- symbol
      if(check_win(board_dup, symbol) == 1) {
        return(i)
      }
    }
  }
  return(-1)
}

# computer move - slightly smarter than random implementation

computer_move <- function(comp_symbol, player_symbol, board) {
  
  cat("\nPlayer ", comp_symbol, "turn: \n")
  
  #check if the computer can win with this move
  move <- check_for_winning_move(comp_symbol, board)
  
  #check if player could win next move, and prevent
  if (move == -1) {
    move <- check_for_winning_move(player_symbol, board)
  }
  
  #otherwise, move randomly
  if (move == -1) {
    spaces_free <- which(is.na(board))
    move <- sample(spaces_free, 1)

    #double assurance we're not overwriting anything
    while (is.na(board[move]) == FALSE) {
      move <- sample(spaces_free, 1)
    }
  }

  board[move] <- comp_symbol

  cat("\nComputer move registered \n")
  print_board(board)

  return(board)
}

# user move
user_move <- function(symbol, board) {
  
  cat("\nPlayer ", symbol, "turn: \n")
  
  confirm <- FALSE
  while (confirm == FALSE) {
    row <- input("What row? ")
    col <- input("What column? ")

    int_row <- as.integer(row)
    int_col <- as.integer(col)

    # checking input
    if (int_row %in% c(1, 2, 3) == FALSE | int_col %in% c(1, 2, 3) == FALSE) {
      cat("Incorrect input! Please enter numbers between 1 - 3\n")
      Sys.sleep(1)
      next
    }

    confirm_str <- input("Confirm placement? [y/n] ")


    if (confirm_str == "y") {
      # making sure the place isnt taken
      if (is.na(board[int_row, int_col]) == TRUE) {
        confirm <- TRUE
      } else {
        cat("Space taken!\n")
        Sys.sleep(1)
      }
    } else {
      cat("Move cancelled - input again!\n")
      Sys.sleep(1)
    }
  }

  board[int_row, int_col] <- symbol

  cat("Move placed! \n")
  print_board(board)

  return(board)
}

# check all the win states
check_win <- function(board, symbol) {
  
  symbol_vector <- c(symbol, symbol, symbol)
  win <- 0
  # check row & col win condition (works because 3 by 3)
  for (r in 1:3) {
    if (setequal(board[r, ], symbol_vector) | setequal(board[, r], symbol_vector)) {
      win <- 1
    }
  }

  # check diagonal
  diagonal_1 <- c(board[1, 1], board[2, 2], board[3, 3])
  diagonal_2 <- c(board[1, 3], board[2, 2], board[3, 1])

  if (setequal(diagonal_1, symbol_vector) | setequal(diagonal_2, symbol_vector)) {
    win <- 1
  }
  
  if (win != 1) {
    # check for stalemate
    spaces_free <- which(is.na(board))
    if (any(spaces_free) == FALSE) {
      win <- 2
    }
  }

  return(win)
}

#assigning the comp and player symbols
get_player_symbol <- function() {
  
  # assigning player symbol
  player_symbol <- input("X or O? ")
  
  # checking input
  while (!(player_symbol %in% c("X", "O"))) {
    cat("Wrong input! Please choose X or O\n")
    Sys.sleep(1)
    player_symbol <- input(" ")
  }
  
  #first letter in list is player, next is comp
  if (player_symbol == "X") {
    return (c("X", "O"))
  } else {
    return (c("O", "X"))
  }
  
}

# who is going first?
first_turn_order <- function(player_symbol) {
  if (player_symbol == 'X') {
    return ("Player")
  }
  else {
    return ("Computer")
  }
}

print_winner <- function(symbol) {
  # Prints who won!
  if (game_fin == 1) {
    cat(symbol, " wins!")
  } else {
    cat("Stalemate!")
  }
}


# creating the board
board <- matrix(data = NA, nrow = 3, ncol = 3)

list[player_symbol, comp_symbol] = get_player_symbol()

# game loop
game_fin <- 0 # 0 is no win yet, 1 is win, 2 is stalemate
round_counter <- 2
turn <- first_turn_order(player_symbol)

while (game_fin == 0) {
  
  #as game loops every turn, we only want to print this every second turn
  if ((round_counter %% 2) == 0) {
    print_round_info((round_counter/2), board)
  }
  
  #if it's the computer's turn
  if (turn == "Computer") {
    board <- computer_move(comp_symbol, player_symbol, board)
    game_fin <- check_win(board, comp_symbol)
    if (game_fin != 0) {
      print_winner(comp_symbol)
      break
    }
    turn <- "Player"
  } else {
    #if it's the player's turn
    board <- user_move(player_symbol, board)
    game_fin <- check_win(board, player_symbol)
    if (game_fin != 0) {
      print_winner(player_symbol)
      break
    }
    turn <- "Computer"
  }
  
  round_counter <- round_counter + 1
 
}

