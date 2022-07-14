//
//  UIViewController+Extension.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 06/06/2022.
//

import Foundation
import UIKit
extension UIViewController{
    
    func showLoader(){
        var activityIndicatorView: UIActivityIndicatorView!
        if let activityIndicator = self.findActivityIndicator(){
            activityIndicatorView = activityIndicator
            activityIndicator.isHidden = false
        }else{
            activityIndicatorView = UIActivityIndicatorView.init(frame: self.view.frame)
        }
        
        activityIndicatorView.style = .large
        activityIndicatorView.color = .white
        activityIndicatorView.center =  view.center
        DispatchQueue.main.async { [weak self] in
         
            self?.view.addSubview(activityIndicatorView)
       
            activityIndicatorView.startAnimating()
        }
    }
    
    func hideLoader(){
        DispatchQueue.main.async {
            
            if let acitivityIndicator = self.findActivityIndicator(){
                
                acitivityIndicator.stopAnimating()
                acitivityIndicator.isHidden = true
                
            }
            
        }
    }
  private  func findActivityIndicator()->UIActivityIndicatorView?{
        for subview in self.view.subviews{
            if let acitvityIndicator = subview as? UIActivityIndicatorView{
                
                return acitvityIndicator
            }
        }
        return nil
    }
    
    func showError(title: String, message: String?){
        DispatchQueue.main.async { [weak self] in
            
            let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default) {  action in
                DispatchQueue.main.async {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(okAction)
            
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
