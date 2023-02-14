//
//  DiscoveryViewController.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 07.02.23.
//

import UIKit
import EasyPeasy
import RxCocoa
import RxSwift

class DiscoveryViewController: UIViewController {
    
    
    lazy var searchTitleView : SearchTitleView = {
        let searchTitleView = SearchTitleView(viewModel: viewModel)
        searchTitleView.translatesAutoresizingMaskIntoConstraints = false
        return searchTitleView
    }()
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.text = "Hello Baby"
        return label
    }()
    
    
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: composeCollectionViewLayout())
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.reusableIdentifier)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: CollectionViewHeader.identifier)
        collectionView.contentInset.top = 32
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.delegate = self
        return collectionView
    }()
    
    
    var refreshControl = UIRefreshControl()
    
    
    let viewModel = ProductViewModel()
    private let disposeBag = DisposeBag()
    
    var dataSource : UICollectionViewDiffableDataSource<Int,Product>!
    var snapShot : NSDiffableDataSourceSnapshot<Int,Product>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.titleView = searchTitleView
        navigationItem.backButtonTitle = " "
        constructHierarchy()
        addConstraints()
        subscribe()
        setUpDataSource()
        
        
    }
    
    private func subscribe() {
        
        Observable.combineLatest(viewModel.products ?? .just([]), viewModel.selectedCategory, viewModel.selectedSortMethod)
            .map({ (products, category, sortMethod) in
                products.filter({ category.isEmpty || $0.category == category}).sorted { lhs, rhs in
                    switch sortMethod {
                    case .highToLow :
                        return lhs.price > rhs.price
                    case .lowToHigh :
                        return lhs.price < rhs.price
                    case .nearest :
                        return lhs.title < rhs.title
                    case .topRated :
                        return lhs.rating.rate > rhs.rating.rate
                    }
                }
            })
            .retry(3)
            .subscribe {[weak self] products in
                self?.applySnapShot(with: products)
                
            }.disposed(by: disposeBag)
        
        viewModel.showFilter
            .subscribe { [weak self] show in
                if show {
                    self?.presentFilter()
                } else {
                    self?.presentedViewController?.dismiss(animated: true)
                }
                
            }.disposed(by: disposeBag)
        
    }
    
    
    private func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int,Product>(collectionView: collectionView, cellProvider: { collectionView, indexPath, product in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reusableIdentifier, for: indexPath) as! ItemCollectionViewCell
            cell.configureCell(with: product)
            return cell
        })
        
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return  collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath)
        }
    }
    
    private func applySnapShot(with products : [Product]) {
        snapShot = NSDiffableDataSourceSnapshot<Int,Product>()
        snapShot.appendSections([0])
        snapShot.appendItems(products)
        dataSource.apply(snapShot)
        refreshControl.endRefreshing()
        storeLocally(products: products)
        if viewModel.categories.isEmpty {
            viewModel.categories = Array(NSOrderedSet(array: products.map({$0.category}))) as! [String]
        }
       

    }
    
    private func storeLocally(products : [Product]) {
        let store = ProductRealmStore()
        store.saveProducts(products: products)
    }
    
    private func constructHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        searchTitleView.easy.layout(
            Width(UIScreen.main.bounds.width),
            Height(500)
        )
        
        collectionView.easy.layout(
            Top().to(view.safeAreaLayoutGuide,.top),
            Leading().to(view),
            Trailing().to(view),
            Bottom().to(view)
        )
    }
    
    
    private func composeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.55), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems:  [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets.leading = 20
        section.contentInsets.top = 16
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func presentFilter() {
        
        
        let vc = FilterViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
        
    }
    
    @objc func  refreshData() {
        viewModel.refresh()
        subscribe()
        
    }
    
}

extension DiscoveryViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = dataSource.itemIdentifier(for: indexPath) else { return }
        let productVC = ProductDetailViewController(product: product)
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}








