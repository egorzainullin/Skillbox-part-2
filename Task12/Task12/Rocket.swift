//
//  Rocket.swift
//  Task12
//
//  Created by Егор Зайнуллин on 01.01.2023.
//

import Foundation
import UIKit

class Rocket {
    private var rocketImageView: UIImageView
    
    init(parentView: UIView) {
        let rocketImage =
        Rocket.resizeImage(image: UIImage(named: "spaceship")!, targetSize: CGSize(width: 50, height: 50))!
        rocketImageView = UIImageView(image: rocketImage)
        parentView.addSubview(rocketImageView)
    }
    
    func animateShoot(toPoint: CGPoint) {
        UIView.animate(withDuration: 1.0, animations: { [self] in
            rocketImageView.center = toPoint
        })
    }
    
    func animateBoom() {
        // TODO
    }
    
    
    
    private static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
