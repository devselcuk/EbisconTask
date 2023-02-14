//
//  SortMethodCollectionViewCell.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 09.02.23.
//

import UIKit
import EasyPeasy

class SortMethodCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkMarkImageView.isHidden = false
               titleLabel.textColor = .productPink
            } else {
                titleLabel.textColor = .titleBlue
                checkMarkImageView.isHidden = true
            }
        }
    }
    
    static let reusableIdentifier = "SortMethodCollectionViewCell"
    
    lazy var  titleLabel : UILabel = {
        let label = UILabel()
        label.font = .appHeadline
        label.textColor = .titleBlue
        return label
    }()
    
    lazy var checkMarkImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.tintColor = .productPink
        imageView.isHidden = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constructHierarchy()
        addSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructHierarchy() {
        addSubview(titleLabel)
        addSubview(checkMarkImageView)
    }
    
    private func addSubviewConstraints() {
        titleLabel.easy.layout(
            Leading().to(self),
            CenterY().to(self)
        )
        
        checkMarkImageView.easy.layout(
            Trailing(16).to(self),
            CenterY().to(self)
        )
    }
    
    
}
