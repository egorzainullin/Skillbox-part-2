//
//  ViewController.swift
//  Task3
//
//  Created by Егор Зайнуллин on 28.01.2022.
//

import UIKit
import ReactiveKit
import Bond
import simd

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let signal = combineLatest(emailTextField.reactive.text, passwordTextField.reactive.text)
        let signalToLabel = signal.map {
            email, password -> String in
            guard let email = email, let password = password
            else {
                return "Email or password is not valid"
            }
            if !self.isValidEmail(email) {
                return "Email is not valid"
            }
            else if password.count < 6 {
                return "Password length < 6"
            }
            else {
                return ""
            }
        }
        signalToLabel.bind(to: answerLabel.reactive.text).dispose(in: reactive.bag)
        let signalToButton = signal.map { email, password -> Bool in
            guard let email = email, let password = password
            else {
                return false
            }
            return self.isValidEmail(email) && password.count >= 6
        }
        signalToButton.bind(to: sendButton.reactive.isEnabled).dispose(in: reactive.bag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reactive.bag.dispose()
    }
}

