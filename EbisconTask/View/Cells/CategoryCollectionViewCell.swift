//
//  CategoryCollectionViewCell.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 09.02.23.
//

import UIKit
import EasyPeasy

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "CategoryCollectionViewCell"
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
              layer.borderColor = UIColor.productPink.cgColor
               titleLabel.textColor = .productPink
            } else {
                layer.borderColor = UIColor.greyButtonColor.cgColor
                titleLabel.textColor = .greyButtonColor
            }
        }
    }
    
    lazy var  titleLabel : UILabel = {
       let label = UILabel()
        label.font = .appText
        label.textColor = .greyButtonColor
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellAppearance()
        constructHierarchy()
        addSubviewConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructHierarchy() {
        addSubview(titleLabel)
    }
    
    private func addSubviewConstraints() {
        titleLabel.easy.layout(
            Leading(16).to(self),
            Top(8).to(self),
            Trailing(16).to(self),
            Bottom(8).to(self)
        )
    }
    
    private func configureCellAppearance() {
        layer.borderColor = UIColor.greyButtonColor.cgColor
        layer.borderWidth = 1
    }
    
    
    
}
