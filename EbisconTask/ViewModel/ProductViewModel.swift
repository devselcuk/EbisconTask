//
//  ProductViewModel.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 08.02.23.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire




class ProductViewModel {

    var products : Observable<[Product]>?
    var isFetching = PublishSubject<Bool>()
    var showFilter = PublishSubject<Bool>()
    var selectedCategory = BehaviorSubject<String>(value: "")
    var selectedSortMethod = BehaviorSubject<SortMethod>(value: .nearest)
    var categories = [String]()
    
    init() {
    
      fetchProducts()
        
    }
    
    func fetchProducts() {
        
        do {
            let task = ProductsTask()
            products = try APIClient.execute(task: task)
            
        } catch {
            print(error)
            products =  nil
            
        }
    }
    
    func refresh() {
        products = Observable.empty()
        fetchProducts()
    }

}





enum APIEnvironment {
    case prod
    case test
    
    var baseURLString : String {
        switch self {
        case .prod:
            return "fakestoreapi.com"
        case .test:
            return "some test url"
        }
    }
    
    static var currentEnvironment : APIEnvironment {
       .prod
    }
}
