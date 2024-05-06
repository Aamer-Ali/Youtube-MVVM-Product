//
//  ProductViewModel.swift
//  Youtube MVVM Product
//
//  Created by aamer sayyed on 05/05/24.
//

import Foundation

final class ProductViewModel{
    
    var products:[Product] = []
    var eventHandler : ((_ event: Event) -> Void)?
    
    func fetchProducts(){
        self.eventHandler?(.loading)
        ApiManager.shared.request(methodType: [Product].self,
                                  type: EndpointItmes.products) { response in
            self.eventHandler?(.stopLoading)
            switch response{
            case .success(let products):
                for p in products{
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                }
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
//    func fetchProducts(){
//        self.eventHandler?(.loading)
//        ApiManager.shared.fetchProduct { response in
//            self.eventHandler?(.stopLoading)
//            switch response{
//            case .success(let products):
//                for p in products{
//                    self.products = products
//                    self.eventHandler?(.dataLoaded)
//                }
//            case .failure(let error):
//                self.eventHandler?(.error(error))
//            }
//        }
//    }
}

extension ProductViewModel{
    enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
    }
}
