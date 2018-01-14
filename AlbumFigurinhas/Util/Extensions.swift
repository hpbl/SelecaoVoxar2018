//
//  Extensions.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 02/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import Foundation

extension UIImage {
    func overlayed(with overlay: UIImage) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        overlay.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        }
        
        return nil
    }
    
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        self.draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
