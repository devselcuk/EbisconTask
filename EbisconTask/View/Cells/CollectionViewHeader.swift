//
//  CollectionViewHeader.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 10.02.23.
//

import UIKit
import EasyPeasy

class CollectionViewHeader : UICollectionReusableView {
    
    static let identifier = "CollectionHeaderView"
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Discover New Products"
        label.font = .appLargeTitle
        label.textColor = .titleBlue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.easy.layout(
            Leading().to(self),
            CenterY().to(self)
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
