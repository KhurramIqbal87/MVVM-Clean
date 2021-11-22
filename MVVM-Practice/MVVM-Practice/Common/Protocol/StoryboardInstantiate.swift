//
//  AppDI.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 07/11/2021.
//


// class name storyboardName login login
import UIKit

protocol StoryboardInstantiate {
    
    associatedtype T
    static var defaultStoryboardName:String { get }
    static func instantiate(_ bundle: Bundle?, resolver: Resolver?)->T
   
}

extension StoryboardInstantiate where Self: UIViewController{
    static var defaultStoryboardName: String  {
        
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
        
    }
    static func instantiate(_ bundle: Bundle?, resolver: Resolver?)->Self{
       
        let sb = UIStoryboard.init(name: defaultStoryboardName, bundle: bundle)
        guard let vc = sb.instantiateInitialViewController() as? Self  else{
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(defaultStoryboardName)")
            
        }
        if let pr = vc as? ViewControllerProtocol, let resolver = resolver{
            pr.injectDependency(resolver)
        }
        
       
        return vc
    }
    
}







