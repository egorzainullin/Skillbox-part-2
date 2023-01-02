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
    
    private var boomImageView: UIImageView
    
    var isShooting = false
    
    init(parentView: UIView) {
        let rocketImage =
        Rocket.resizeImage(image: UIImage(named: "spaceship")!, targetSize: CGSize(width: 50, height: 50))!
        rocketImageView = UIImageView(image: rocketImage)
        rocketImageView.alpha = 0
        parentView.addSubview(rocketImageView)
        let boomImage = Rocket.resizeImage(image: UIImage(named: "boom")!, targetSize: CGSize(width: 50, height: 50))!
        boomImageView = UIImageView(image: boomImage)
        boomImageView.alpha = 0
        parentView.addSubview(boomImageView)
    }
    
    func animateShoot(toPoint: CGPoint) {
        isShooting = true
        rocketImageView.alpha = 1
        let centerOfRocket = rocketImageView.center
        let vector = CGPoint(x: centerOfRocket.x - toPoint.x, y: centerOfRocket.y-toPoint.y)
        let distance = sqrt(vector.x * vector.x + vector.y * vector.y)
        if distance < 50 {
            animateBoom(pointWhereBoom: toPoint)
        }
        UIView.animate(withDuration: 1.0, animations: { [self] in
            rocketImageView.center = toPoint
        })
    }
    
    private func animateBoom(pointWhereBoom: CGPoint) {
        rocketImageView.alpha = 0
        boomImageView.center = pointWhereBoom
        UIView.animate(withDuration: 0.5, animations: {
            self.rocketImageView.alpha = 1
        })
        reset()
    }
    
    private func reset() {
        isShooting = false
        rocketImageView.alpha = 0
        rocketImageView.center = CGPoint(x: 0, y: 0)
        boomImageView.alpha = 0
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
