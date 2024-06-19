# Francisco Urquizo
# tic_tac_toe.py
def print_board(board):
    for row in board:
        print(" | ".join(row))
        print("-" * 5)

def check_winner(board):
    for row in board:
        if row[0] == row[1] == row[2] and row[0] != " ":
            return row[0]
    for col in range(3):
        if board[0][col] == board[1][col] == board[2][col] and board[0][col] != " ":
            return board[0][col]
    if board[0][0] == board[1][1] == board[2][2] and board[0][0] != " ":
        return board[0][0]
    if board[0][2] == board[1][1] == board[2][0] and board[0][2] != " ":
        return board[0][2]
    return None

def main():
    board = [
        ["X", "O", "X"],
        [" ", "X", "O"],
        ["O", "X", "O"]
    ]
    print("Tic Tac Toe Board:")
    print_board(board)
    winner = check_winner(board)
    if winner:
        print(f"The winner is {winner}!")
    else:
        print("It's a tie!")

if __name__ == "__main__":
    main()
