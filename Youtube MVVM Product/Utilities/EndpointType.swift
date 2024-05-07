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
    var body : Encodable? { get }
    var header : [String : String]? { get }
}
