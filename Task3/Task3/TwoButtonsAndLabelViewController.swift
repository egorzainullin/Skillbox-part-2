//
//  TowButtonsAndLabelViewController.swift
//  Task3
//
//  Created by Егор Зайнуллин on 29.01.2022.
//

import UIKit
import Bond
import ReactiveKit

class TwoButtonsAndLabelViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    var isLaunched = Property(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLaunched
            .map {isLaunched in
                isLaunched ? "Rocket is launched" : ""}
            .bind(to: label.reactive.text)
        button1.reactive.tap
            .combineLatest(with: button2.reactive.tap)
            .observeNext {_ in
                self.isLaunched.value = true
            }
            .dispose(in: reactive.bag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reactive.bag.dispose()
    }

}
