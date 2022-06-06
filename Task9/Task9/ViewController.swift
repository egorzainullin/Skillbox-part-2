//
//  ViewController.swift
//  Task9
//
//  Created by Егор Зайнуллин on 06.06.2022.
//

import UIKit
import VK_ios_sdk

class ViewController: UIViewController {
    let dialog = VKShareDialogController()
    let VK_APP_ID = "8186851"
    
    @IBAction func authorize(_ sender: Any) {
        VKSdk.authorize(["email"])
        let sdkInstance = VKSdk.initialize(withAppId: VK_APP_ID)
        sdkInstance?.register(self)
        if VKSdk.isLoggedIn()
        {
            label.text = "Logged in"
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dialog.dismissAutomatically = true
    }


    @IBAction func presentShare(_ sender: Any) {
        self.present(dialog, animated: true, completion: {
            
        })
    }
}

extension ViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(result.token ?? "===========")
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    
}

