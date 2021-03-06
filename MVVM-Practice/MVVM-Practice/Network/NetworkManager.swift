//
//  NetworkManager.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/10/2021.
//

import Foundation


typealias NetworkProtocol = NetworkRequestProtocol & NetworkErrorProtocol

final class NetworkManager: NetworkProtocol{
    
    var type: NetworkError?
    var message: String?
    
    static let sharedInstance = NetworkManager.init()
    private static let timeoutSession:Double = 60
    
    private let session: URLSession = URLSession.shared
    private let semaphore = DispatchSemaphore(value: 5)
    private let group = DispatchGroup()
    private let queue = DispatchQueue.global(qos: .userInteractive)

    func getData(_ params: Parameter?, _ headers: Header?, url: String, methodType: HTTPMethod, completion:  ((_ success: Bool, _ error: NetworkError?,  _ response: Parameter )->Void)){
       
        if !Reachability.isConnectedToNetwork(){
            completion(false,NetworkError.noInternet, [:])
        }
        guard let urlRequest =  getURLRequest(path: url, headers: headers, paramaters: params)else{return}
        
        self.session.dataTask(with: urlRequest) {  data, response, error in
        }
    }
    
    private func getURLRequest(path: String, headers: Header?, paramaters: Parameter? )->URLRequest?{
        
       
        guard let url = URL(string: path) else{return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        
        if let paramData = paramaters, let data = try? JSONSerialization.data(withJSONObject: paramData , options: .fragmentsAllowed){
            urlRequest.httpBody = data
        }
        
        return urlRequest
        
    }
    
    func makeHTTPRequest< ResponseModel: Decodable>(httpMethod: HTTPMethod, endPoint: String, parameters: Encodable? = DummyRequestModel() , completionBlock completion: @escaping(Bool, NetworkError?, ResponseModel?)->()) {
        
        if !Reachability.isConnectedToNetwork(){
            completion(false,NetworkError.noInternet, nil)
        }
        
        let urlString: String = endPoint
        if let url = URL(string: urlString) {
            
            let request = NSMutableURLRequest(url: url)
            request.timeoutInterval = NetworkManager.timeoutSession
            self.session.dataTask(with: request as URLRequest) { data, response, error in
                
                guard error == nil else {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                  let errorCode =  HTTPStatusCode(rawValue: statusCode)
                    
                    let networkError = NetworkError.networkError(error: errorCode!)
                    print("API status code error = \(errorCode!.rawValue)")
                    completion(false, networkError, nil)
                    return 
                }
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON Response: ", jsonString)
                    }
                    do {
                        
                        let obj = try JSONDecoder().decode(ResponseModel.self, from: data)

                        completion(true, nil, obj)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(false, NetworkError.dataSerializationError(error: context.debugDescription), nil)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(false, NetworkError.dataSerializationError(error: context.debugDescription), nil)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        completion(false, NetworkError.dataSerializationError(error: context.debugDescription), nil)
                        
                    } catch {
                        print("error: ", error)
                        completion(false,NetworkError.error(error: error), nil)
                    }
                }
            }.resume()
        }
    }
   
    func downloadData(url: String, completion:@escaping ((_ data: Data?, _ error: Error?) -> Void)) {
        if let saveData = Filing.sharedInstance.getFile(fileName: url){
            completion(saveData,nil)
            return
        }
        guard let url = URL(string: url) else{return}
        group.enter()
        semaphore.wait()
        queue.async(group: group){
            let task = self.session.dataTask(with: url, completionHandler: { [weak self]data, urlResponse, error in
                guard let self = self else{return}
                 if let data = data{
                     Filing.sharedInstance.saveFile(data: data, fileName: url.lastPathComponent, fileExtension: ".jpeg")
                 }
                 completion(data,error)
                self.semaphore.signal()
                self.group.leave()
            })
            task.resume()
        }
     
        
    }
    
    
    public func setHeader(headers: Parameter){
        self.session.setValuesForKeys(headers)

    }
}






