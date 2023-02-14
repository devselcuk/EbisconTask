//
//  SearchTitleView.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 07.02.23.
//

import UIKit


class SearchTitleView : UIView {
    
    lazy var searchBar : UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.borderStyle = .none
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.layer.borderColor = UIColor.systemGray2.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 21
        searchBar.setPositionAdjustment(UIOffset(horizontal: 20, vertical: 0), for: .search)
       return searchBar
    }()
    
    
    lazy var filterButton : UIButton = {
       let button = UIButton()
        button.tintColor = .greyButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 42)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill", withConfiguration: imageConfig), for: .normal)
        button.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    let viewModel : ProductViewModel
    
    
    init(viewModel : ProductViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubview(searchBar)
        addSubview(filterButton)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 42),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterButton.centerYAnchor.constraint(equalTo: centerYAnchor),
       
        ])
        addKeyboardToolBar()
        
        
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    
    @objc func filterTapped() {
        viewModel.showFilter.onNext(true)
    }
    
    private func addKeyboardToolBar() {
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(keyboardDoneTapped))
        bar.items = [done]
        bar.sizeToFit()
        searchBar.inputAccessoryView = bar
    }
    
     @objc private func keyboardDoneTapped() {
         self.endEditing(true)
    }
    
    
}



