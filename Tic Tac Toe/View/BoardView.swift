//
//  BoardView.swift
//  Tic Tac Toe
//
//  Created by Kittisak Boonchalee on 25/8/21.
//

import UIKit

class BoardView: UIView {
    
    let path = UIBezierPath()
    
    let xPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 241, green: 244, blue: 227, alpha: 1)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        tableSetup()
        UIColor.black.setStroke()
        path.lineWidth = 10
        path.lineJoinStyle = .round
        path.stroke()
        buttonsSetUp()
    }
    
    func tableSetup() {
        
        let widthOfMark = (bounds.width - 50)/3
        
        let startPointOfWidth = 10 + widthOfMark
        
        for i in stride(from: startPointOfWidth + 10, to: bounds.width - 40, by: startPointOfWidth) {
            
            path.move(to: CGPoint(x: i, y: 10))
            
            path.addLine(to: CGPoint(x: i,y: bounds.origin.y + bounds.height - 10))
            
            path.close()
            
        }
        
        let heightOfMark = 100
        
        let startPointOfHeight = heightOfMark + 10
        
        for i in stride(from: startPointOfHeight, to: 300, by: startPointOfHeight){
            
            path.move(to: CGPoint(x: 10, y: i))
            
            path.addLine(to: CGPoint(x: bounds.origin.x + bounds.width - 10, y: CGFloat(i)))
            
            path.close()
        }
        
    }
    
    func buttonsSetUp() {
        let widthOfMark = Double((bounds.width - 50)/3)
        let heightOfMark :Double = 100
        var x :Double = 15
        var y :Double = 5
        var count = 0
        for i in 0..<9 {
            let button = CustomButton()
            if count == 3 {
                count = 0
                x = 15
                y = y + heightOfMark + 10
            }
            button.frame = CGRect(x: x, y: y, width: widthOfMark, height: heightOfMark)
            button.tag = i
            button.tintColor = .lightGray
            addSubview(button)
            button.addTarget(self, action: #selector(didChoose), for: .touchUpInside)
            BoardManager.board.append(button)
            x = x + widthOfMark + 10
            count = count + 1
        }
    }
    
    @objc func didChoose(_ sender:CustomButton){
        isUserInteractionEnabled = false
        if Player.human.turn && sender.isChosen == false{
            sender.setBackgroundImage(UIImage(systemName: Player.human.markSymbol), for: .normal)
            sender.mark = Player.human.markSymbol
            sender.isChosen = true
            sender.removeTarget(self, action: nil, for: .touchUpInside)
            Player.human.turn.toggle()
            Player.computer.turn.toggle()
            //check win,draw conditiion
            guard !BoardManager.checkDrawCondition() else {
                NotificationCenter.default.post(name: NSNotification.Name("player draw"), object: self)
                return
            }
            guard !BoardManager.checkWinCondition() else {
                NotificationCenter.default.post(name: NSNotification.Name("player win"), object: self)
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.didChoose(BoardManager.board[Player.computer.findBestMove()])
            }
            isUserInteractionEnabled = true
        }else if Player.computer.turn && sender.isChosen == false {
            isUserInteractionEnabled = false
            sender.setBackgroundImage(UIImage(systemName: Player.computer.markSymbol), for: .normal)
            sender.mark = Player.computer.markSymbol
            sender.isChosen = true
            sender.removeTarget(self, action: nil, for: .touchUpInside)
            Player.human.turn.toggle()
            Player.computer.turn.toggle()
            //check win,draw condition
            guard !BoardManager.checkDrawCondition() else {
                NotificationCenter.default.post(name: NSNotification.Name("player draw"), object: self)
                return
            }
            guard !BoardManager.checkWinCondition() else {
                NotificationCenter.default.post(name: NSNotification.Name("player win"), object: self)
                return
            }
            isUserInteractionEnabled = true
        }
    }
    
    func resetButtons() {
        BoardManager.clearBoard()
        subviews.forEach{ $0.removeFromSuperview() }
        buttonsSetUp()
    }
    

}

class CustomButton: UIButton {
    var mark:String = ""
    var isChosen = false
}


