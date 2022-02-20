//
//  AppDI.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 07/11/2021.
//
import Foundation
protocol NetworkErrorProtocol{
    var type : NetworkError?{get}
    var message: String?{get}
}

protocol NetworkRequestProtocol {
    typealias Parameter = [String: Any]
     typealias Header = [String: String]
    
    func getData(_ params: Parameter?, _ headers: Header?, url: String, methodType: HTTPMethod, completion:  ((_ success: Bool, _ error: NetworkError?,  _ response: Parameter )->Void) )
    func downloadData(url: String, completion: @escaping ((_ data: Data?, _ error: Error?)->Void))
    
    func makeHTTPRequest< ResponseModel: Decodable>(httpMethod: HTTPMethod, endPoint: String, parameters: Encodable? , completionBlock completion: @escaping(Bool, NetworkError?, ResponseModel?)->())
}






