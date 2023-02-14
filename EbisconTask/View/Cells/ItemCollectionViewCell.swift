//
//  ItemCollectionViewCell.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 07.02.23.
//

import UIKit
import EasyPeasy
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "ItemCollectionViewCell"
    
    
    lazy var itemImageView : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "mock")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    
    lazy var priceStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [deliveryLabel,priceLabel])
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    
    lazy var priceLabel  : UILabel = {
        let label = UILabel()
        label.text = "12.99$"
        label.textAlignment = .right
        return label
    }()
    
    lazy var deliveryLabel : UILabel = {
        let label = UILabel()
        label.text = "Free Delivery"
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        label.backgroundColor = .systemPink
        label.textAlignment = .center
        return label
    }()
    
    lazy var vStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,topSpacerLabel,categoryLabel,infoStackView,bottomSpacerLabel,priceStackView])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    lazy var infoStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [ratingStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var ratingStackView : UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [starImageView, rateLabel, ratingCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var starImageView : UIImageView = {
        let configuration = UIImage.SymbolConfiguration.init(font: .systemFont(ofSize: 9))
        let imageView = UIImageView(image: UIImage(systemName: "star.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
    
        return imageView
    }()
    
    lazy var rateLabel : UILabel = {
       let label = UILabel()
        label.text = "4.9"
        label.font = .appText
        
        return label
    }()
    
    lazy var  ratingCountLabel : UILabel = {
       let label = UILabel()
        label.text = "(120 ratings)"
        label.font = .appText
        label.textColor = .appSecondary
        return label
    }()
    
    lazy var  titleLabel : UILabel = {
       let label = UILabel()
        label.text = "Rahat Braserrire"
        label.font = .appHeadline
        label.textColor = .titleBlue
        label.numberOfLines = 2
        return label
    }()
    
    lazy var categoryLabel : UILabel = {
       let label = UILabel()
        label.text = "Besiktas 133"
        label.font = .appText
        label.textColor = .appSecondary
        return label
    }()
    
    var topSpacerLabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    var bottomSpacerLabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellAppearance()
        constructHierarchy()
        addSubviewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        deliveryLabel.layer.cornerRadius = deliveryLabel.frame.height / 2
    }
    
    
    private func configureCellAppearance() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = .init(width: 0, height: 2)
    }
    
    private func constructHierarchy() {
        addSubview(itemImageView)
        addSubview(vStackView)
    }
    
    private func addSubviewConstraints() {
        itemImageView.easy.layout(
            Top(16).to(self),
            Leading(16).to(self),
            Trailing(16).to(self),
            Height(*0.55).like(self))
        deliveryLabel.easy.layout(Width(78))
        vStackView.easy.layout(
            Leading(8).to(self),
            Top(8).to(itemImageView, .bottom),
            Trailing(8).to(self),
            Bottom(8).to(self)
        )
        
        bottomSpacerLabel.easy.layout(
            Height(*1).like(topSpacerLabel)
        )
    }
    
    
    func configureCell(with product : Product) {
        self.itemImageView.kf.setImage(with:URL(string:  product.image))
        titleLabel.text = product.title
        categoryLabel.text = product.category
        rateLabel.text = "\(product.rating.rate)"
        ratingCountLabel.text = "(\(product.rating.count) ratings)"
        priceLabel.text = "\(product.price)$"
    }
    
    
}




