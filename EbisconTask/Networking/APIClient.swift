//
//  APIClient.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 08.02.23.
//


import RxAlamofire
import RxSwift
import Alamofire
import ProgressHUD

enum CustomError : Error {
    case urlError
}


struct APIClient{
    
    static var isFirstFetch = true
     
    static func execute<T : NetworkTask>(task : T) throws -> Observable<T.ResponseModel> {
        
         
         guard let url = task.url else { throw  CustomError.urlError}
        if isFirstFetch {
            DispatchQueue.main.async {
                ProgressHUD.show()
            }
            isFirstFetch = false
        }
        
       let result =   RxAlamofire.requestData(.get, url)
           .debug()
           .map { response , data in
               let products = try JSONDecoder().decode(T.ResponseModel.self, from: data)
               DispatchQueue.main.async {
                   ProgressHUD.dismiss()
               }
               return products
           }
           .catch { error in
               DispatchQueue.main.async {
                   ProgressHUD.dismiss()
               }
               throw error
           }
           
         
        return  result
    }
    
}
