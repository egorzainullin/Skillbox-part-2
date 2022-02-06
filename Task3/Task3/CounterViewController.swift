//
//  CounterViewController.swift
//  Task3
//
//  Created by Егор Зайнуллин on 29.01.2022.
//

import UIKit
import Bond
import ReactiveKit

class CounterViewController: UIViewController {

    var counter = Property(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter
            .map({"\($0)"})
            .bind(to: counterLabel.reactive.text)
        button.reactive.tap.observeNext {
            self.counter.value += 1
        }
        .dispose(in: reactive.bag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reactive.bag.dispose()
    }

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var counterLabel: UILabel!
}
