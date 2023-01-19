//
//  main.swift
//  ApartmentCostPrediction
//
//  Created by Егор Зайнуллин on 19.01.2023.
//

import CreateML
import Foundation

if let filePath = Bundle.main.path(forResource: "Apartments", ofType: "csv")
{
    let trainingFile = URL(fileURLWithPath: filePath)
    let apartmentsData = try? MLDataTable(contentsOf: trainingFile)
    if let apartmentsData = apartmentsData {
        print("CSV data was loaded")
    }
    else {
        print("CSV data failed to load")
    }
}
else {
    print("path was not created")
}
