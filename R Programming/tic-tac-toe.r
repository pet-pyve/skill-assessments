# Creating Tic Tac Toe in R!

#getting input from user func
input <- function(input_str) {
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  cat(input_str)
  symbol <- readLines(con = con, n = 1)
}

#print output at the start of each loop
print_round_info <- function(round_num, board) {
  cat("########################\n")
  cat("###### Round #", round_counter, " ######\n")
  cat("########################\n")
  Sys.sleep(1)
  cat("Current board: \n")
  cat("~~~~~~~~~~~~~~~~~~~\n")
  print(board)
  cat("~~~~~~~~~~~~~~~~~~~\n")
  Sys.sleep(1)
}

#computer move - just picks randomly from available places
computer_move <- function(symbol, board) {
  spaces_free <- which(is.na(board))
  pos <- sample(spaces_free, 1)
  
  while (is.na(board[pos]) == FALSE) {
    pos <- sample(spaces_free, 1) 
  }
  board[pos] <- symbol
  
  cat('Computer move registered \n')
  cat("~~~~~~~~~~~~~~~~~~~\n")
  print(board)
  cat("~~~~~~~~~~~~~~~~~~~\n")
  Sys.sleep(1)
  
  return(board)
  
}

#user move 
user_move <- function(symbol, board) {
  confirm = FALSE
  while (confirm == FALSE) {
    row <- input("What row?")
    col <- input("What column?")
    
    int_row <- as.integer(row)
    int_col <- as.integer(col)
    
    #checking input
    if (int_row %in% c(1, 2, 3) == FALSE | int_col  %in% c(1, 2, 3) == FALSE) {
      cat('Incorrect input! Please enter numbers between 1 - 3\n')
      Sys.sleep(1)
      next
    }
    
    confirm_str <- input("Confirm placement? [y/n]")

    
    if (confirm_str == 'y') {
     
      #making sure the place isnt taken
      if (is.na(board[int_row, int_col]) == TRUE) {
        confirm <- TRUE 
      }
      else {
        cat("Space taken!\n")
        Sys.sleep(1)
      }

    } else {
      cat("Move cancelled - input again!\n")
      Sys.sleep(1)
    }
    
  }

  board[int_row, int_col] <- symbol
  
  cat('Move placed! \n')
  cat("~~~~~~~~~~~~~~~~~~~\n")
  print(board)
  cat("~~~~~~~~~~~~~~~~~~~\n")
  Sys.sleep(1)
  
  return(board)
  
}

#check all the win states
check_win <- function(board, symbol_vector) {
  win <- 0
  #check row & col win condition (works because 3 by 3)
  for (r in 1:3) {
    if (setequal(board[r,], symbol_vector) | setequal(board[,r], symbol_vector)) {
      win <- 1
    }
  }

  #check diagonal
  diagonal_1 = c(board[1,1], board[2,2], board[3,3])
  diagonal_2 = c(board[1,3], board[2,2], board[3,1])
  if (setequal(diagonal_1, symbol_vector) | setequal(diagonal_2, symbol_vector)) {
    win = 1
  }
  
  if (win == 1 && setequal(c('O', 'O', 'O'), symbol_vector)) {
    win <- 2
  }
  
  #check for stalemate
  spaces_free <- which(is.na(board))
  if (any(spaces_free) == FALSE) {
      win <- 3

  }
  
  return(win)
}

#creating the board
board <- matrix(data=NA, nrow = 3, ncol = 3)

comp_symbol = ''

#assigning player symbol
player_symbol <- input("X or O? ")

#checking input
while (player_symbol != 'X' & player_symbol != 'O') {
  cat("Wrong input! Please choose X or O")
  Sys.sleep(1)
  player_symbol <- input()

}

if (player_symbol == 'X') {
  comp_symbol = 'O'
} else  {
  comp_symbol = 'X'
} 

#game loop 
game_fin <- 0 # 0 is false, 1 is x win, 2 is o win and 3 stalemate
round_counter <- 1

while (game_fin == 0) {
  print_round_info(round_counter, board)
  cat("Player 'X' turn: \n")
  Sys.sleep(1)
  if (comp_symbol == 'X') {
    board <- computer_move(comp_symbol, board)
    game_fin <- check_win(board, c('X', 'X', 'X'))
    if (game_fin != 0) {
      next
    }
    board <- user_move(player_symbol, board)
    game_fin <- check_win(board, c('O', 'O', 'O'))
    if (game_fin != 0) {
      next
    }
  } else {
    board <- user_move(player_symbol, board)
    game_fin <- check_win(board, c('X', 'X', 'X'))
    if (game_fin != 0) {
      next
    }
    board <- computer_move(comp_symbol, board)
    game_fin <- check_win(board, c('O', 'O', 'O'))
    if (game_fin != 0) {
      next
    }
  }
  
  round_counter <- round_counter + 1
}

if (game_fin == 1) {
  cat("X wins!")
} else if (game_fin == 2) {
  cat("O wins!")
} else {
  cat("Stalemate!")
}





