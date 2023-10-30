//
//  LoginPageController.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import UIKit

class LoginPageController: UIViewController {


    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let loginEmail = "ziyad@gmail.com"
    let loginPassword = "12345"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layerConfig()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        checkLogin()
    }
}


//MARK: Functions(LayerConfig, Alert, setting UserDefault, LoginCheck)
extension LoginPageController {
    
    func layerConfig() {
        emailTextField.layer.cornerRadius = 32
        passwordTextField.layer.cornerRadius = 32
        button.layer.cornerRadius = 32
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.masksToBounds = true
        button.layer.masksToBounds = true
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(true, forKey: "loggedIN") // setting the flag
            sceneDelegate.homePage(windowScene: scene)
        }
    }
    
    func checkLogin() {
        if let email = emailTextField.text,
           let password = passwordTextField.text,
           !email.isEmpty,
           !password.isEmpty {
            if (email == loginEmail) && (password == loginPassword) {
                setRoot()
                let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                navigationController?.show(controller, sender: nil)
            } else {
                showAlert(title: "Xəta", message: "Email və ya şifrə düzgün daxil edilməyib")
            }
        } else {
            showAlert(title: "Xəta", message: "Düzgün məlumatı daxil edin.")
        }
    }
}
