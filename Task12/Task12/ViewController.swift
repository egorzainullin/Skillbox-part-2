//
//  ViewController.swift
//  Task12
//
//  Created by Егор Зайнуллин on 12.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }

    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}

extension ViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}

