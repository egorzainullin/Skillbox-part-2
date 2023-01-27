//
//  FlatViewController.swift
//  Task12
//
//  Created by Егор Зайнуллин on 27.01.2023.
//

import UIKit

class FlatViewController: UIViewController {

    private let model = ModelPredictor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var undergroundStationTextField: UITextField!
    
    @IBOutlet weak var squareTextField: UITextField!
    
    @IBAction func onTouchUpPredictButton(_ sender: Any) {
        if let station = undergroundStationTextField.text, let squareText = squareTextField.text, let square = Double(squareText)
        {
            let flatFeatures = FlatWithFeaturesToPredict(square: square, undergroundStation: station)
            let price = model.predictPrice(flat: flatFeatures)
            priceLabel.text = "Price \(price)"
        }
        else{
            priceLabel.text = "Data is incorrect"
        }
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
