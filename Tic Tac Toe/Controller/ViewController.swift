//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Kittisak Boonchalee on 23/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    var resetButton: UIButton = {
        let button = UIButton()
        let attriStrng = NSAttributedString(string: "Reset Game",
                                            attributes: [
                                                .font:UIFont(name: "Chalkboard SE Bold", size: 20),
                                                .foregroundColor:UIColor.brown
                                            ])
        button.setAttributedTitle(attriStrng, for: .normal)
        button.backgroundColor = .systemGray4
        button.tintColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        return button
    }()
    
        
    let boardView: BoardView = {
        let view = BoardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 165, green: 201, blue: 205, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Tic Tac Toe"
        view.addSubview(boardView)
        view.addSubview(resetButton)
        NotificationCenter.default.addObserver(self, selector: #selector(winAlert), name: NSNotification.Name("player win"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drawAlert), name: NSNotification.Name("player draw"), object: nil)
        presentFVC()
    }
    
    
    override func viewDidLayoutSubviews() {
        boardView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top + 50, width: view.bounds.width, height: 330)
        resetButton.frame = CGRect(x: 125, y: boardView.frame.origin.y + boardView.frame.height + 50, width: 150, height: 100)
    }
    
    func presentFVC(){
        let vc = FirstViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
 
    @objc func resetGame() {
        BoardManager.clearBoard()
        boardView.subviews.forEach{ $0.removeFromSuperview() }
        boardView.buttonsSetUp()
        Player.resetPlayer()
        boardView.isUserInteractionEnabled = true
        presentFVC()
    }
    
    
    func checkWinConditon(indexesChoose: Set<Int>) -> Bool{
        for win in WinCondition.winCondition {
            if win.isSubset(of: indexesChoose){
                return true
            }
        }
        return false
    }
    
    @objc func winAlert(){
        var alertString:String = ""
        if Player.human.isWin {
            alertString = "You Won!!!"
        }
        if Player.computer.isWin {
            alertString = "Computer Won!!!"
        }
        let alert = UIAlertController(title: nil,
                                      message: alertString,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func drawAlert(){
        let alert = UIAlertController(title: nil,
                                      message: "Draw!!!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: ReceiveDataFromVC {
    
    func receiveData(comTurn: Bool) {
        if comTurn {
            let buttonChosenByCom = BoardManager.board[Player.computer.findBestMove()]
            boardView.didChoose(buttonChosenByCom)
        }
    }
}
