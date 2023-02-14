//
//  FilterViewController.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 09.02.23.
//

import UIKit
import EasyPeasy
import RxSwift



enum FilterSection : Int,Hashable, CaseIterable {
    case category
    case sortMethod
    
}

class FilterViewController: UIViewController {
    
    
    lazy var topLine : UIView = {
        let line = UIView()
        line.backgroundColor = .filterTopLine
        line.layer.cornerRadius = 2.5
        return line
    }()
    
    lazy var containerView : UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.backgroundColor = .systemBackground
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        containerView.addGestureRecognizer(swipeGestureRecognizer)
        swipeGestureRecognizer.direction = .down
        return containerView
    }()
    
    @objc func swipe(_ gesture : UISwipeGestureRecognizer) {
            self.dismiss(animated: true)
        
    }
    
    lazy var buttonStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resetButton, titleLabel, doneButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var resetButton : UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.titleBlue, for: .normal)
        button.titleLabel?.font = .appHeadline
        button.addTarget(self, action: #selector(resetSelections), for: .touchUpInside)
        return button
    }()
    
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.textColor = .titleBlue
        label.font = .appHeadline
        return label
    }()
    
    
    lazy var doneButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.productPink, for: .normal)
        button.titleLabel?.font = .appHeadline
        button.addTarget(self, action: #selector(dismissFilter), for: .touchUpInside)
        return button
    }()
    
    
    lazy var headerBottomLine : UIView = {
        let line = UIView()
        line.backgroundColor = .greyButtonColor
        return line
    }()
    
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: composeCollectionViewLayout())
        
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reusableIdentifier)
        collectionView.register(SortMethodCollectionViewCell.self, forCellWithReuseIdentifier: SortMethodCollectionViewCell.reusableIdentifier)
        collectionView.register(FilterReusableView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: FilterReusableView.identifier)
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    
    let viewModel : ProductViewModel
    private let disposeBag = DisposeBag()
    private var dataSource : UICollectionViewDiffableDataSource<FilterSection,AnyHashable>!
    private var snapShot : NSDiffableDataSourceSnapshot<FilterSection,AnyHashable>!
    
    
    init(viewModel : ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
        constructHierarchy()
        addConstraints()
        setupDataSource()
        applySnapShot()
        subscribe()
        
    }
    
    
    private func subscribe() {
        
        Observable.combineLatest( viewModel.selectedCategory, viewModel.selectedSortMethod)
            .subscribe {[weak self] category,sortMethod in
                self?.updateSelection( with: category, sortMethod: sortMethod)
                
            }.disposed(by: disposeBag)
        
    }
    
    
    private func applySnapShot() {
        
        
        
        snapShot = NSDiffableDataSourceSnapshot<FilterSection,AnyHashable>()
        snapShot.appendSections([.category, .sortMethod])
        snapShot.appendItems(viewModel.categories, toSection: .category)
        snapShot.appendItems(SortMethod.allCases, toSection: .sortMethod)
        dataSource.apply(snapShot)
    }
    
    private func setupDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<FilterSection,AnyHashable>(collectionView: collectionView, cellProvider: { collectionView, indexPath, title in
            switch indexPath.section {
            case 0 :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reusableIdentifier, for: indexPath) as! CategoryCollectionViewCell
                cell.titleLabel.text = title as? String ?? ""
                return cell
            case 1 :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortMethodCollectionViewCell.reusableIdentifier, for: indexPath) as! SortMethodCollectionViewCell
                cell.titleLabel.text = (title as? SortMethod ?? .highToLow).rawValue
                return cell
            default :
                return UICollectionViewCell()
            }
        })
        
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterReusableView.identifier, for: indexPath) as! FilterReusableView
            switch indexPath.section {
            case 0 :
                header.titleLabel.text = "CATEGORIES"
            case 1 :
                header.titleLabel.text = "SORT BY"
            default :
                break
            }
            return header
        }
        
        
    }
    
    
    private func customize() {
        view.backgroundColor = .filterBackground.withAlphaComponent(0.7)
    }
    
  
    
    private func constructHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(topLine)
        containerView.addSubview(buttonStackView)
        containerView.addSubview(headerBottomLine)
        containerView.addSubview(collectionView)
    }
    
    
    
    
    private func addConstraints() {
        containerView.easy.layout(
            Leading().to(view),
            Bottom().to(view),
            Trailing().to(view),
            Height(*0.6).like(view)
        )
        
        topLine.easy.layout(
            Top(16).to(containerView),
            CenterX().to(containerView),
            Height(5),
            Width(60)
        )
        
        buttonStackView.easy.layout(
            Leading(16).to(containerView),
            Top(16).to(topLine),
            Trailing(16).to(containerView)
        )
        
        headerBottomLine.easy.layout(
            Leading().to(containerView),
            Top(16).to(buttonStackView,.bottom),
            Trailing().to(containerView),
            Height(0.5)
        )
        
        collectionView.easy.layout(
            Leading().to(containerView),
            Top().to(headerBottomLine,.bottom),
            Trailing().to(containerView),
            Bottom().to(containerView)
        )
 
    }
    
    
  
    
    func composeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {(section : Int, environment : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch section {
            case 0 :
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(20), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(31))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(8)
                group.contentInsets.leading = 16
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48))
                let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
                section.boundarySupplementaryItems = [supplementaryItem]
                section.interGroupSpacing = 8
                return section
            case 1 :
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(32))
                let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
                
                var config =  UICollectionLayoutListConfiguration(appearance: .plain)
                config.showsSeparators = true
                var sepConfiguration = UIListSeparatorConfiguration(listAppearance: .plain)
                sepConfiguration.topSeparatorVisibility = .hidden
                sepConfiguration.bottomSeparatorInsets.leading = -16
                
                config.separatorConfiguration = sepConfiguration
                config.headerMode = .supplementary
                let section =  NSCollectionLayoutSection.list(using: config, layoutEnvironment: environment)
                section.boundarySupplementaryItems = [supplementaryItem]
                section.contentInsets.leading = 16
                return section
            default :
                return nil
            }
            
        }

        return layout
        
    }
    
    
    @objc func resetSelections() {
        viewModel.selectedCategory.onNext("")
        viewModel.selectedSortMethod.onNext(.nearest)
    }
    
    
    
    @objc func dismissFilter() {
        viewModel.showFilter.onNext(false)
    }
    
    
    
    private func updateSelection( with category : String, sortMethod : SortMethod) {
        
        let categories = viewModel.categories
        
        if let categoryIndex = categories.firstIndex(of: category) {
            for index in categories.indices {
                let indexPath = IndexPath(row: index, section: 0)
                collectionView.deselectItem(at: indexPath, animated: false)
            }
            
            collectionView.selectItem(at: IndexPath(row: categoryIndex, section: 0), animated: true, scrollPosition: .top)
        } else {
            for index in categories.indices {
                let indexPath = IndexPath(row: index, section: 0)
                collectionView.deselectItem(at: indexPath, animated: false)
            }
        }
        if let sortIndex = SortMethod.allCases.firstIndex(of: sortMethod) {
            
            for index in SortMethod.allCases.indices {
                let indexPath = IndexPath(row: index, section: 1)
                collectionView.deselectItem(at: indexPath, animated: false)
            }
            collectionView.selectItem(at: IndexPath(row: sortIndex, section: 1), animated: true, scrollPosition: .top)
        }
    }
    
    
    
}

extension FilterViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell  {
            if let category = dataSource.itemIdentifier(for: indexPath) as? String {
                viewModel.selectedCategory.onNext(category)
            }
            
        }
        
        if let _ = collectionView.cellForItem(at: indexPath) as? SortMethodCollectionViewCell  {
            
            if let sortMethod = dataSource.itemIdentifier(for: indexPath) as? SortMethod {
                viewModel.selectedSortMethod.onNext(sortMethod)
            }
        }
    }
}


