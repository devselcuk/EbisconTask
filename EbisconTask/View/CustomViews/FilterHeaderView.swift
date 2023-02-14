//
//  FilterHeaderView.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 09.02.23.
//

import UIKit
import EasyPeasy


class FilterReusableView : UICollectionReusableView {
    
    static let identifier = "FilterReusableView"
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "CUISINES"
        label.font = .appText
        label.textColor = .greyButtonColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.easy.layout(
            Leading(16).to(self),
            CenterY().to(self)
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
