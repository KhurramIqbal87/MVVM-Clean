//
//  ViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/10/2021.
//

import UIKit

final class SplashViewController: UIViewController {
    
    
    private var splashViewModel: SplashViewModel?
    
   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setViewModel(splashViewModel: SplashViewModel){
        self.splashViewModel = splashViewModel
        self.title = SplashViewModel.title
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     
    }

    
    @IBAction func navigateToLogin(_ sender: Any){
        self.splashViewModel?.navigateToLoginController()
    }
    
    

}



extension SplashViewController: StoryboardInstantiate{}
//class a calls class b func
//
//class b will update class A on completion
//
//class a will pass function reference in class B func
//
//after finishing job class b will call class a refered function to update


