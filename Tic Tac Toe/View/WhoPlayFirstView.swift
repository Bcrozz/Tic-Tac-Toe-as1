//
//  WhoPlayFirstView.swift
//  Tic Tac Toe
//
//  Created by Kittisak Boonchalee on 28/8/21.
//

import UIKit

class WhoPlayFirstView: UIView {
    
    weak var delegate: ReceiveDataFromView?
    
    let path = UIBezierPath()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Who wil play first ?"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 18)
        label.shadowColor = .gray
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(titleLabel)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        path.move(to: CGPoint(x: 0, y: 40))
        path.addLine(to: CGPoint(x: rect.width, y: 40))
        path.close()
        path.move(to: CGPoint(x: rect.width/2 - 1, y: 40))
        path.addLine(to: CGPoint(x: rect.width/2 - 1, y: rect.height ))
        path.close()
        UIColor.gray.setStroke()
        path.lineWidth = 3
        path.stroke()
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: 10, width: 200, height: 20)
    }
    
    func setUpButton(){
        for i in 0..<2{
            let xPoint = bounds.width/2
            let chooseButton = UIButton()
            if i == 0 {
                let youNSAtriString =  NSAttributedString(string: "You",
                                   attributes:
                                    [.font:UIFont(name: "Chalkboard SE Bold", size: 18)])
                chooseButton.setAttributedTitle(youNSAtriString, for: .normal)
                chooseButton.frame = CGRect(x: CGFloat(i) * xPoint, y: 40, width: bounds.width/2 - 2, height: bounds.height - 40)
            }else {
                let comNSAtriString =  NSAttributedString(string: "Computer",
                                   attributes:
                                    [.font:UIFont(name: "Chalkboard SE Bold", size: 18)])
                chooseButton.setAttributedTitle(comNSAtriString, for: .normal)
                chooseButton.frame = CGRect(x: CGFloat(i) * xPoint , y: 40, width: bounds.width/2 , height: bounds.height - 40)
            }
            chooseButton.backgroundColor = .systemGray3
            chooseButton.tag = i
            chooseButton.addTarget(self, action: #selector(didChooseWhoPlayFirst), for: .touchUpInside)
            addSubview(chooseButton)
        }
    }
    
    func setUpSymbol(){
        for i in 0..<2{
            let xPoint = bounds.width/2
            let chooseButton = UIButton()
            if i == 0 {
                chooseButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
                chooseButton.frame = CGRect(x: CGFloat(i) * xPoint, y: 40, width: bounds.width/2 - 2, height: bounds.height - 40)
            }else {
                chooseButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
                chooseButton.frame = CGRect(x: CGFloat(i) * xPoint , y: 40, width: bounds.width/2 , height: bounds.height - 40)
            }
            chooseButton.backgroundColor = .systemGray3
            chooseButton.tintColor = .white
            chooseButton.tag = i
            chooseButton.addTarget(self, action: #selector(didChooseSymbol), for: .touchUpInside)
            addSubview(chooseButton)
        }
    }
    
    @objc func didChooseWhoPlayFirst(_ sender:UIButton){
        if sender.tag == 0 {
            Player.human.turn = true
        }else {
            Player.computer.turn = true
        }
        subviews.forEach { View in
            guard View as? UIButton != nil else {
                return
            }
            View.removeFromSuperview()
        }
        titleLabel.text = "Choose the symbol"
        setUpSymbol()
    }
    
    @objc func didChooseSymbol(_ sender:UIButton){
        if sender.tag == 0{
            Player.human.markSymbol = "xmark"
            Player.computer.markSymbol = "circle"
        }else {
            Player.human.markSymbol = "circle"
            Player.computer.markSymbol = "xmark"
        }
        delegate?.receiveDataFromView()
    }
    
}

protocol ReceiveDataFromView: AnyObject {
    
    func receiveDataFromView()
    
}


