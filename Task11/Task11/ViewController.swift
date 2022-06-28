//
//  ViewController.swift
//  Task11
//
//  Created by Егор Зайнуллин on 28.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelWindow: UILabel!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func onSendButtonTouchUpInside(_ sender: Any) {
    }
    
    func isNotEmpty(text1: String?, text2: String?) -> Bool{
        if let text1 = text1, let text2 = text2 {
            return text1.count > 0 && text2.count > 0
        }
        return false
    }
    
    @IBAction func onLoginEditingDidEnd(_ sender: Any) {
        if isNotEmpty(text1: loginTextField.text, text2: passwordTextField.text) {
            sendButton.isEnabled = true
        }
        else {
            sendButton.isEnabled = false
        }
    }
    
    @IBAction func onPasswordEditingEnd(_ sender: Any) {
        if isNotEmpty(text1: loginTextField.text, text2: passwordTextField.text) {
            sendButton.isEnabled = true
        }
        else {
            sendButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sendButton.isEnabled = false
    }


}

