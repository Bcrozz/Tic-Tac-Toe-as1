//
//  FirstViewController.swift
//  Tic Tac Toe
//
//  Created by Kittisak Boonchalee on 25/8/21.
//

import UIKit

class FirstViewController: UIViewController {

    weak var delegate: ReceiveDataFromVC?
    
    let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        return blurView
    }()
    
    let whoPlayFirstView: WhoPlayFirstView = {
        let view = WhoPlayFirstView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whoPlayFirstView.delegate = self
        view.addSubview(blurView)
        view.addSubview(whoPlayFirstView)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurView.frame = view.bounds
        whoPlayFirstView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 100))
        whoPlayFirstView.center = view.center
    }
    

}

protocol ReceiveDataFromVC: AnyObject {
    
    func receiveData(comTurn: Bool)
    
}

extension FirstViewController: ReceiveDataFromView {
    
    func receiveDataFromView() {
        delegate?.receiveData(comTurn: Player.computer.turn)
        dismiss(animated: true, completion: nil)
    }
    
    
}

