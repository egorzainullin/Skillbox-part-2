//
//  PricePrediction.swift
//  Task12
//
//  Created by Егор Зайнуллин on 27.01.2023.
//

import Foundation

import CoreML


struct FlatWithFeaturesToPredict {
    let square: Double
    let undergroundStation: String
}

class ModelPredictor {
    private var model: FlatPredictionRegressor
    
    init() {
        do {
            model = try FlatPredictionRegressor(configuration: MLModelConfiguration())
        }
        catch {
            fatalError("model was not loaded")
        }
    }
    
    func predictPrice(flat: FlatWithFeaturesToPredict) -> Double {
        if let prediction = try? model.prediction(undergroundStation: flat.undergroundStation, square: flat.square) {
            return prediction.price
        }
        else {
            fatalError("Can'r predict")
        }
        
    }
}

