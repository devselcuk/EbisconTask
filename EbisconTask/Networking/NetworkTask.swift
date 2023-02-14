//
//  NetworkTask.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 08.02.23.
//

import Foundation
import Alamofire
import RxSwift


protocol NetworkTask   {
    
    associatedtype ResponseModel : Codable
    
    var endpoint : Endpoint {get}
    var httpMethod : HTTPMethod { get set }
    
    var url : URL? { get }
    
    
}


extension NetworkTask {
    
    
    var url : URL? {
        get {
            var components = URLComponents()
            components.scheme = "https"
            components.host = APIEnvironment.currentEnvironment.baseURLString
            components.path = "/\(endpoint.rawValue)"
            guard  let url = components.url else { return nil}
            print(url)
            return url
        }
    }
    
}
