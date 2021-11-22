//
//  ViewController.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 27/10/2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    private var loginViewModel: LoginViewModelProtocol?
    
    init(loginViewModel: LoginViewModelProtocol){
        
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
    }
    
    private func setup(){
    
        let success:Success = {  (success) in
            print("success: \(success)")
        }
        let failure:Failure = { (error) in
            print("failure: \(error)")
        }
        self.loginViewModel?.setLoginCompletion(loginCompletion: (success, failure))
    }
    

    
    @IBAction func login(_ sender: Any){
        self.loginViewModel?.login(userName: self.userName.text ?? "", password: self.password.text ?? "")
        
    }

}

extension LoginViewController: ViewControllerProtocol{
    func injectDependency(_ resolver: Resolver) {
        do {
        self.loginViewModel = try resolver.resolve(type: LoginViewModelProtocol.self)
            
        } catch let error{
            print(error)
        }
    }
}

extension LoginViewController: StoryboardInstantiate{}
//class a calls class b func
//
//class b will update class A on completion
//
//class a will pass function reference in class B func
//
//after finishing job class b will call class a refered function to update


