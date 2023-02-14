//
//  ProductDetailView.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 10.02.23.
//

import UIKit
import EasyPeasy

class ProductDetailView: UIView {

    lazy var titleLabel : UILabel = {
       let label = UILabel()
        label.text = product.title
        label.font = .appLargeTitle
        label.textColor = .titleBlue
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel : UILabel = {
       let label = UILabel()
        label.text = product.description
        label.font = .appText
        label.textColor = .appTextColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.33, height: 200)
        layout.scrollDirection = .horizontal
      
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductImageCollectionViewCell.self, forCellWithReuseIdentifier: ProductImageCollectionViewCell.reusableIdentifier)
        collectionView.contentInset.left = 32
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var imagesTitleLabel : UILabel = {
       let label = UILabel()
        label.text = "Variants"
        label.textColor = .titleBlue
        label.font = .appLargeTitle.withSize(24)
       return label
    }()
    
    lazy var detailsTitleLabel : UILabel = {
       let label = UILabel()
        label.text = "Details"
        label.textColor = .titleBlue
        label.font = .appLargeTitle.withSize(24)
       return label
    }()
    
    lazy var detailLabel : UILabel = {
        let label = UILabel()
         label.text = "No detail provided"
        label.textColor = .appTextColor
         label.font = .appText
        return label
    }()
    

    
    let product : Product
    
    
    init(product : Product) {
        self.product = product
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: -2)
        constructHierarchy()
        addSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(imagesTitleLabel)
        addSubview(collectionView)
        addSubview(detailsTitleLabel)
        addSubview(detailLabel)
    }
    
    private func addSubviewConstraints() {
        titleLabel.easy.layout(
            Leading(16).to(self),
            Top(16).to(self),
            Trailing(16).to(self)
        )
        descriptionLabel.easy.layout(
            Leading(16).to(self),
            Top(16).to(titleLabel),
            Trailing(16).to(self)
        )
        imagesTitleLabel.easy.layout(
            Leading(16).to(self),
            Top(16).to(descriptionLabel)
        )
        collectionView.easy.layout(
            Leading().to(self),
            Top().to(imagesTitleLabel),
            Trailing().to(self),
            Height(212)
        )
        
        detailsTitleLabel.easy.layout(
            Leading(16).to(self),
            Top(16).to(collectionView)
        )
        
        detailLabel.easy.layout(
            Leading(16).to(self),
            Top(8).to(detailsTitleLabel)
        )
        
    }

}


extension ProductDetailView : UICollectionViewDelegate,UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCollectionViewCell.reusableIdentifier, for: indexPath) as! ProductImageCollectionViewCell
        
        cell.productImageView.kf.setImage(with: URL(string: product.image))
        
        return cell
    }
    
    
}
