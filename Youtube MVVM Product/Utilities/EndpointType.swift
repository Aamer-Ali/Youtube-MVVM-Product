//
//  EndpointType.swift
//  Youtube MVVM Product
//
//  Created by aamer sayyed on 06/05/24.
//

import Foundation

//MARK: - Mthods related to API call
enum HttpMethod : String{
    case get = "GET"
    case post = "POST"
}

protocol EndpointType{
    var path : String { get }
    var baseUrl : String { get }
    var url : URL? { get }
    var method : HttpMethod { get }
}

//MARK: - This enum will have all the module
// At this point we have only one module i.e Product
enum EndpointItmes{
    case products
    //case Module 2
    //case Module 3
    //case Module 4
}


extension EndpointItmes : EndpointType{
    var path: String {
        switch self{
        case .products:
            return "products"
        }
    }
    
    var baseUrl: String {
        return "https://fakestoreapi.com/"
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HttpMethod {
        switch self{
        case .products:
            return .get
        }
    }
}
