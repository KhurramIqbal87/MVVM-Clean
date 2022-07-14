//
//  MockMovieListRepository.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 24/01/2022.
//

import Foundation
class MockMovieListRepository: MovieListImageRepositoryType{
    
   
    private let networkManager: NetworkProtocol
    init (networkManager: NetworkProtocol){
        self.networkManager = networkManager
    }
    
    
    func getMovies(forIndex: Int = 0, completion: @escaping (MoviePage?, NetworkError?) -> Void) {
        if let json = self.getMockData(pageNo: forIndex){
            if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted){
                
                do {
                    
                    let obj = try JSONDecoder().decode(MoviePage.self, from: data)

                    completion(obj, nil)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil, NetworkError.dataSerializationError(error: context.debugDescription))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil, NetworkError.dataSerializationError(error: context.debugDescription))
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil, NetworkError.dataSerializationError(error: context.debugDescription))
                    
                } catch {
                    print("error: ", error)
                    completion(nil,NetworkError.error(error: error))
                }
                
            }
        } else{
            let error = NSError.init(domain: "Unable to load data", code: 200, userInfo: nil)
            
            completion(nil, NetworkError.error(error: error))
        }
        
        
        
        
    }
    
    private func getMockData(pageNo: Int)->[String: Any]?{
        if let path = Bundle.main.path(forResource: "MovieList", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? [[String: Any]] {
                      if jsonResult.count  < pageNo || pageNo < 0{
                          return nil
                      }
                      for json in jsonResult{
                          if let page = json["page"] as? Int,  page == pageNo{
                              return json
                          }
                                
                      }
                  }
              } catch {
                   // handle errorO
              }
        }
        return nil
    }
    
}
