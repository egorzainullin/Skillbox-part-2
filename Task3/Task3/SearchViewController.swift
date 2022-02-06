//
//  SearchViewController.swift
//  Task3
//
//  Created by Егор Зайнуллин on 28.01.2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.reactive.text
            .ignoreNils()
            .throttle(for: 0.5).map{
            text in
                if text == "" {
                    return ""
                }
                else
                {
                    return "Send request for \(text)"
                }
        }.bind(to: searchLabel.reactive.text)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
