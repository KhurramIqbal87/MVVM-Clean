//
//  Validation.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/10/2021.
//

import Foundation

final class Filing: NSObject{
    
    static let sharedInstance = Filing.init()
    private override init(){
        super.init()
    }
    func saveFile(data: Data, fileName: String, fileExtension: String){
        
        self.save(data: data, toDirectory: self.documentDirectory(), withFileName: "images/" + fileName + fileExtension)
    }
    
    
     func getFile(fileName: String)->Data?{
        
         let filePath = "images/" + fileName
         return self.read(fromDocumentsWithFileName: filePath)
      
    }
    private func read(fromDocumentsWithFileName fileName: String) -> Data? {
       
        guard let filePath = self.append(toPath: self.documentDirectory(), withPathComponent: fileName), let url = URL(string: filePath) else {return nil}
        
        do {
            let data = try Data(contentsOf: url)
            
            return data
        } catch {
            print("Error reading saved file")
            return nil
           
        }
    }
    
   private  func save(data: Data ,
                      toDirectory directory: String,
                      withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory,
                                         withPathComponent: fileName), let url = URL(string: filePath) else {
            return
        }
        
        do {
            try data.write(to: url, options: .atomic)
        } catch {
            print("Error", error)
            return
        }
        
        print("Save successful")
    }
    private func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            
            return pathURL.absoluteString
        }
        
        return nil
    }
    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
            .userDomainMask,true)
        
        return documentDirectory[0]
    }
}


