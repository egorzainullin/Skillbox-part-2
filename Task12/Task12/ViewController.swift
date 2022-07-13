//
//  ViewController.swift
//  Task12
//
//  Created by Егор Зайнуллин on 12.07.2022.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var imagePicker: ImagePicker!
    
    private var modelML: VNCoreMLModel!
    
    private func makeImageClassifierModel() -> VNCoreMLModel? {
        return try? VNCoreMLModel(for: Task12ImageClassifier_1(configuration: MLModelConfiguration()).model)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        if let model = makeImageClassifierModel()
        {
            self.modelML = model
        }
        else {
            fatalError("Can't create ML model")
        }
    }
    
    private func makeClassifierRequest(for model: VNCoreMLModel, ciImage: CIImage) {
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            self?.handleClassifierResults(request.results)
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInteractive).async {
          do {
            try handler.perform([request])
          } catch {
            self.onDidUpdateState(.requestFailed)
          }
        }
      }
    @IBOutlet weak var confidenceLabel: UILabel!
    
    private func handleClassifierResults(_ results: [Any]?) {
        guard let results = results as? [VNClassificationObservation],
          let firstResult = results.first else {
          onDidUpdateState(.requestFailed)
          return
        }
        DispatchQueue.main.async { [weak self] in
          let confidence = (firstResult.confidence * 100).rounded()
          let resultModel = ClassifierResultModel(identifier: firstResult.identifier, confidence: Int(confidence))
          self?.onDidUpdateState(.receiveResult(resultModel: resultModel))
        }
      }

    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    private func onDidUpdateState(_ result: Result){
        switch result {
        case .requestFailed:
            confidenceLabel.text = "Request failed"
        case .receiveResult(let resultModel):
            confidenceLabel.text = "\(resultModel.identifier) with \(resultModel.confidence) %"
        }
    }
}

extension ViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
        if let image = image, let ciImage = image.ciImage {
            makeClassifierRequest(for: modelML, ciImage: ciImage)
        }
    }
}

struct ClassifierResultModel {
  let identifier: String
  let confidence: Int
  
  var description: String {
    return "This is \(identifier) with \(confidence)% confidence"
  }
}

enum Result {
    case requestFailed
    
    case receiveResult(resultModel: ClassifierResultModel)
}
