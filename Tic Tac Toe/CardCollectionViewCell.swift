//
//  CardCollectionViewCell.swift
//  Tic Tac Toe
//
//  Created by Kittisak Boonchalee on 23/8/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
