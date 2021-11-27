//
//  AppDI.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 07/11/2021.
//

protocol NetworkErrorProtocol{
    var type : NetworkError?{get}
    var message: String?{get}
}

protocol NetworkRequestProtocol {
    typealias Parameter = [String:Any]
    typealias Header = [String:String]
    
    func getData(_ params: Parameter?, _ headers: Header?, url: String, methodType: HTTPMethod, completion:  ((_ success: Bool, _ error: NetworkError?,  _ response: Parameter )->Void) )
}





