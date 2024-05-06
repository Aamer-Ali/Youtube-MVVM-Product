//
//  ApiManager.swift
//  Youtube MVVM Product
//
//  Created by aamer sayyed on 05/05/24.
//

import Foundation

enum DataError : Error{
    case invlaidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

//typealias Handler = (Result<[Product],DataError>) -> Void
typealias Handler<T> = (Result<T,DataError>) -> Void

final class ApiManager{
    static let shared = ApiManager()
    private init(){}
    
    func request<T : Codable>(methodType : T.Type,
                    type : EndpointType,
                    handler : @escaping Handler<T>){
            //Create a URL from the String
            guard let url = URL(string: Constants.API.productUrl) else {
                handler(.failure(.invalidURL))
                return
            }
    
            //Create Url session for API call
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data, error == nil else {
                    handler(.failure(.invalidData))
                    return
                } //If data == null then return
    
                //Check if the response status code lies between 200 to 299
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    handler(.failure(.invlaidResponse))
                    return
                }
    
                //Decode json data
                do{
                    let decodedResponse = try JSONDecoder().decode(methodType, from: data)
                    handler(.success(decodedResponse))
                }catch{
                    handler(.failure(.invlaidResponse))
                }
            }.resume()
        }
    
//    func fetchProduct(handler : @escaping Handler){
//        //Create a URL from the String
//        guard let url = URL(string: Constants.API.productUrl) else {
//            handler(.failure(.invalidURL))
//            return
//        }
//        
//        //Create Url session for API call
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data, error == nil else {
//                handler(.failure(.invalidData))
//                return
//            } //If data == null then return
//            
//            //Check if the response status code lies between 200 to 299
//            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
//                handler(.failure(.invlaidResponse))
//                return
//            }
//            
//            //Decode json data
//            do{
//                let products = try JSONDecoder().decode([Product].self, from: data)
//                handler(.success(products))
//            }catch{
//                handler(.failure(.invlaidResponse))
//            }
//        }.resume()
//    }
}
