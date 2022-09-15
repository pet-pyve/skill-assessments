# Creating Tic Tac Toe in R!

#getting input from user func
input <- function() {
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  cat("X or O? ")
  symbol <- readLines(con = con, n = 1)
}

#creating the board
board <- matrix(data=NA, nrow = 3, ncol = 3)

#getting input from user
symbol <- input()

#check the input 
if (symbol != 'X' & symbol != 'O') {
  print("wrong!")
} else {
  print("right!")
}



