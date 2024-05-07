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
                                  type: ProductEndpoint.products) { response in
            self.eventHandler?(.stopLoading)
            switch response{
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func addProducts(parameter: AddProduct){
        ApiManager.shared.request(methodType: AddProduct.self,
                                  type: ProductEndpoint.addProduct(product: parameter)) { response in
            switch response{
            case .success(let newProduct):
                self.eventHandler?(.newProductAdded(addProduct: newProduct))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel{
    enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
        case newProductAdded(addProduct :AddProduct)
    }
}
