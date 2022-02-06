//
//  ViewController.swift
//  Task5
//
//  Created by Егор Зайнуллин on 05.02.2022.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var blurredImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://bugaga.ru/uploads/posts/2017-03/1489052030_kotik-hosiko-12.jpg"
        let url = URL(string: urlString)!
        DispatchQueue.global(qos: .utility).async {[weak self] in
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)!
            DispatchQueue.main.async {[weak self] in
                self?.imageView.image = image
            }
        }
        DispatchQueue.global(qos: .utility).async {[weak self] in
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)!
            let context = CIContext(options: nil)
            let currentFilter = CIFilter(name: "CIGaussianBlur")
            let beginImage = CIImage(image: image)
            currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
            let cropFilter = CIFilter(name: "CICrop")
            cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
            cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
            let output = cropFilter!.outputImage
            let cgimg = context.createCGImage(output!, from: output!.extent)
            let processedImage = UIImage(cgImage: cgimg!)
            DispatchQueue.main.async {[weak self] in
                self?.blurredImageView.image = processedImage
            }
        }
        // Do any additional setup after loading the view.
    }
}

