//
//  PrimesViewController.swift
//  Task5
//
//  Created by Егор Зайнуллин on 06.02.2022.
//

import UIKit

class PrimesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isPrime(_ i: Int) -> Bool {
        var isFlagPrime = true
        var divider = 2
        while isFlagPrime && (Double)(divider) <= sqrt(Double(i)) {
            if i % divider == 0 {
                isFlagPrime = false
            }
            divider += 1
        }
        return isFlagPrime
    }
    
    @IBAction func calculatePrimes(_ sender: Any) {
        if let textFieldText = textField.text,
           let n = Int(textFieldText) {
            for i in 2...n {
                DispatchQueue.global().async {
                    let start = DispatchTime.now()
                    let isPrime = self.isPrime(i)
                    let end = DispatchTime.now()
                    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                    let timeInterval = Double(nanoTime) / 1_000_000_000
                    if isPrime {
                        print(i, timeInterval)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
