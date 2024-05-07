//
//  ProductEndpoint.swift
//  Youtube MVVM Product
//
//  Created by aamer sayyed on 07/05/24.
//

import Foundation

//MARK: - This enum will have all the module
// At this point we have only one module i.e Product
enum ProductEndpoint{
    case products
    case addProduct(product : AddProduct)
}


extension ProductEndpoint : EndpointType{
    var path: String {
        switch self{
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseUrl: String {
        switch self{
            
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
        
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HttpMethod {
        switch self{
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
    var body: Encodable?{
        switch self{
        case .products:
            return nil
        case .addProduct(product: let product):
            return product
        }
    }
    
    var header: [String : String]?{
        switch self{
        case .products:
            return nil
        case .addProduct:
            return ApiManager.commonHeader
        }
    }
}
