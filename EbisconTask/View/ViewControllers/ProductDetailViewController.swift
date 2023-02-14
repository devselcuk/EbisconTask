//
//  ProductDetailViewController.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 10.02.23.
//

import UIKit
import EasyPeasy

class ProductDetailViewController: UIViewController {
    
    lazy var imageView : UIImageView = {
       let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: product.image))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var productDetailView : ProductDetailView = {
       let productDetailView = ProductDetailView(product: product)
        productDetailView.layer.cornerRadius = 32
        productDetailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        productDetailView.addGestureRecognizer(panGesture)
        return productDetailView
    }()
    
    let product : Product
    
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        constructHierarchy()
        addConstraints()

        // Do any additional setup after loading the view.
    }
    
    
    private func constructHierarchy() {
        view.addSubview(imageView)
        view.addSubview(productDetailView)
    }
    
    private func addConstraints() {
        imageView.easy.layout(
            Top().to(view.safeAreaLayoutGuide,.top),
            Leading(32).to(view),
            Trailing(32).to(view),
            Height(*0.5).like(view)
        )
        
        productDetailView.easy.layout(
            Leading().to(view),
            Bottom(0).to(view),
            Trailing().to(view),
            Height(*0.55).like(view)
        )
    }
    
    
    @objc func panned(_ pan : UIPanGestureRecognizer) {
        let translation = pan.translation(in: view)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9) {
            if translation.y < -1 {
                self.productDetailView.easy.layout(
                    Height(*0.88).like(self.view)
                )
            } else if translation.y > 1 {
                self.productDetailView.easy.layout(
                    Height(*0.55).like(self.view)
                )
            }
            self.view.layoutIfNeeded()
        }
        
        
    }

  

}
