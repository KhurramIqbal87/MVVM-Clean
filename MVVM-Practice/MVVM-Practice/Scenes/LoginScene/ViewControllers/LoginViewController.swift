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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.loginViewModel?.viewWillDisAppear()
    }
    
    private func setup(){
    
        let success:Success = {[weak self]  (success) in
            self?.loginViewModel?.viewWillDisAppear()
            
        }
        let failure:Failure = { (error) in
            print("failure: \(error)")
        }
        self.loginViewModel?.setLoginCompletion(loginCompletion: (success, failure))
    }
    

    
    @IBAction func login(_ sender: Any){
        self.loginViewModel?.login(userName: self.userName.text ?? "", password: self.password.text ?? "")
    }
    deinit {
        print("LoginViewController Dismiss")
    }
}

extension LoginViewController: ViewControllerProtocol{
    func injectDependency(_ resolver: Resolver) {
        do {
        self.loginViewModel = try resolver.resolve(type: LoginViewModelProtocol.self)
            if let model = self.loginViewModel as? DefaultLoginViewModel{
                model.setCoordinator(coordinator: try! resolver.resolve(type: Coordinator.self))
            }
            
        } catch let error{
            print(error)
        }
    }
   
}

extension LoginViewController: StoryboardInstantiate{}



