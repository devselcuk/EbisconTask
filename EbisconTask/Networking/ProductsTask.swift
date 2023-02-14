//
//  ProductsTask.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 08.02.23.
//

import Foundation
import Alamofire
import RxSwift



struct ProductsTask : NetworkTask {
    
    
    typealias ResponseModel = [Product]
    
    var endpoint: Endpoint = .products
    
    var httpMethod: Alamofire.HTTPMethod = .get
    
    
}

