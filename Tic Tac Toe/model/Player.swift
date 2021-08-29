//
//  Player.swift
//  Tic Tac Toe
//
//  Created by Kittisak Boonchalee on 23/8/21.
//

import Foundation

class Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.player == rhs.player &&
            lhs.markSymbol == rhs.markSymbol
    }
    
    let player: PlayerType
    var turn: Bool
    var markSymbol: String
    var isWin: Bool = false
    var indexesChoose: Set<Int> = []
    static var human = Player(.human, false, "")
    static var computer = Player(.computer,false, "")
    
    init(_ Player:PlayerType,_ Turn:Bool,_ mark:String) {
        player = Player
        turn = Turn
        markSymbol = mark
    }
    
    func findBestMove() -> Int{
        var bestValue = -1000
        var bestMove = 8
        
        for button in BoardManager.board{
            if button.mark == "" && button.isChosen == false {
                button.mark = Player.computer.markSymbol
                button.isChosen = true
                let moveValue = miniMax(depth: 0,comTurn: false)
                button.mark = ""
                button.isChosen = false
                
                if moveValue > bestValue{
                    bestMove = button.tag
                    bestValue = moveValue
                }
            }
        }
        return bestMove
    }
    
    func evaluate() -> Int {
        let board = BoardManager.board
        for row in stride(from: 0, to: 9, by: 3){
            if board[row].isChosen && board[row+1].isChosen && board[row+2].isChosen {
                if (board[row].mark == board[row+1].mark) && (board[row+1].mark == board[row+2].mark){
                    if (board[row].mark == Player.computer.markSymbol){
                        return 10
                    }
                    else if (board[row].mark == Player.human.markSymbol){
                        return -10
                    }
                }
            }
        }
        
        for col in 0..<3{
            if board[col].isChosen && board[col+3].isChosen && board[col+6].isChosen {
                if (board[col].mark == board[col+3].mark) && (board[col+3].mark == board[col+6].mark){
                    if (board[col].mark == Player.computer.markSymbol){
                        return 10
                    }
                    else if (board[col].mark == Player.human.markSymbol){
                        return -10
                    }
                }
            }
        }
        
        if board[0].isChosen && board[4].isChosen && board[8].isChosen {
            if board[0].mark == board[4].mark && board[4].mark == board[8].mark {
                if (board[0].mark == Player.computer.markSymbol){
                    return 10
                }
                else if (board[0].mark == Player.human.markSymbol){
                    return -10
                }
            }
        }
        
        if board[2].isChosen && board[4].isChosen && board[6].isChosen {
            if board[2].mark == board[4].mark && board[4].mark == board[6].mark {
                if (board[2].mark == Player.computer.markSymbol){
                    return 10
                }
                else if (board[2].mark == Player.human.markSymbol){
                    return -10
                }
            }
        }
        
        return 0
    }
    
    func miniMax(depth:Int,comTurn:Bool) -> Int{
        let score = evaluate()
        
        if score == 10 {
            return score
        }
        
        if score == -10 {
            return score
        }
        
        if isMoveLeft() == false{
            return 0
        }
        
        if comTurn{
            var best = -1000
            
            for button in BoardManager.board{
                
                if button.mark == "" && button.isChosen == false{
                    button.mark = Player.computer.markSymbol
                    button.isChosen = true
                    best = max(best, miniMax(depth: depth + 1, comTurn: !comTurn))
                    button.mark = ""
                    button.isChosen = false
                }
            }
            return best
        }else {
            var best = 1000
            
            for button in BoardManager.board{
                
                if button.mark == "" && button.isChosen == false{
                    button.mark = Player.human.markSymbol
                    button.isChosen = true
                    best = min(best, miniMax(depth: depth + 1, comTurn: !comTurn))
                    button.mark = ""
                    button.isChosen = false
                }
            }
            return best
        }
        
    }
    
    func isMoveLeft() -> Bool {
        for button in BoardManager.board{
            guard button.isChosen else {
                return true
            }
        }
        return false
    }
    
    static func resetPlayer(){
        human = Player(.human, false, "")
        computer = Player(.computer, false, "")
    }
    
}

enum PlayerType {
    case human
    case computer
}
