//
//  File.swift
//  Tic Tac Toe
//
//  Created by Kittisak Boonchalee on 23/8/21.
//

import Foundation

struct Card {
    let broadIndex: Int
    let picked: Bool
}

class BoardManager {
    
    static var board = Array<CustomButton>()
    
    static func checkWinCondition() -> Bool{
        for row in stride(from: 0, to: 9, by: 3){
            if board[row].isChosen && board[row+1].isChosen && board[row+2].isChosen {
                if (board[row].mark == board[row+1].mark) && (board[row+1].mark == board[row+2].mark){
                    if (board[row].mark == Player.computer.markSymbol){
                        Player.computer.isWin = true
                    }
                    else if (board[row].mark == Player.human.markSymbol){
                        Player.human.isWin = true
                    }
                    return true
                }
            }
        }
        
        for col in 0..<3{
            if board[col].isChosen && board[col+3].isChosen && board[col+6].isChosen {
                if (board[col].mark == board[col+3].mark) && (board[col+3].mark == board[col+6].mark){
                    if (board[col].mark == Player.computer.markSymbol){
                        Player.computer.isWin = true
                    }
                    else if (board[col].mark == Player.human.markSymbol){
                        Player.human.isWin = true
                    }
                    return true
                }
            }
        }
        
        if board[0].isChosen && board[4].isChosen && board[8].isChosen {
            if board[0].mark == board[4].mark && board[4].mark == board[8].mark {
                if (board[0].mark == Player.computer.markSymbol){
                    Player.computer.isWin = true
                }
                else if (board[0].mark == Player.human.markSymbol){
                    Player.human.isWin = true
                }
                return true
            }
        }
        
        if board[2].isChosen && board[4].isChosen && board[6].isChosen {
            if board[2].mark == board[4].mark && board[4].mark == board[6].mark {
                if (board[2].mark == Player.computer.markSymbol){
                    Player.computer.isWin = true
                }
                else if (board[2].mark == Player.human.markSymbol){
                    Player.human.isWin = true
                }
                return true
            }
        }
        return false
    }
    
    static func checkDrawCondition() -> Bool{
        for button in BoardManager.board{
            if button.isChosen == false {
                return false
            }
        }
        return true
    }
    
    static func clearBoard() {
        BoardManager.board = Array<CustomButton>()
    }
    
    
}
