//
//  ProductImageCollectionViewCell.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 10.02.23.
//

import UIKit
import EasyPeasy

class ProductImageCollectionViewCell: UICollectionViewCell {

    
    static let reusableIdentifier = "ProductImageCollectionViewCell"
    
 
    
    lazy var productImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = .zero
        constructHierarchy()
        addSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructHierarchy() {
        addSubview(productImageView)
    }
    
    private func addSubviewConstraints() {
        productImageView.easy.layout(
            Leading().to(self),
            Top().to(self),
            Trailing().to(self),
            Bottom().to(self)
            
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }
    
    
    
}
