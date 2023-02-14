//
//  ProductLocalStore.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 10.02.23.
//

import Foundation
import RealmSwift
import RxSwift


class ProductRealmStore {
    private let realm: Realm
    private let disposeBag = DisposeBag()
    
    let productViewModel = ProductViewModel()
    
    init() {
        realm = try! Realm()
        print(fetchProducts())
    }
    
    func saveProducts(products: [Product]) {
        do {
            try realm.write {
                realm.add(products.map { ProductRealm(fromProduct: $0) }, update: .modified)
            }
        } catch {
            print("Error saving products to Realm: \(error)")
        }
    }
    
    func fetchProducts() -> [Product] {
        let products = realm.objects(ProductRealm.self)
        return products.map { Product(fromRealmProduct: $0) }
    }
}

extension Product {
    init(fromRealmProduct productRealm: ProductRealm) {
        id = productRealm.id
        title = productRealm.title
        price = productRealm.price
        description = productRealm.productDescription
        category = productRealm.category
        image = productRealm.image
        rating = Rating(rate: productRealm.rating, count: 0)
    }
}

extension ProductRealm {
    convenience init(fromProduct product: Product) {
        self.init()
        id = product.id
        title = product.title
        price = product.price
        productDescription = product.description
        category = product.category
        image = product.image
        rating = product.rating.rate
    }
}

class ProductRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var productDescription: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var rating: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
