//
//  Sticker.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import Foundation

class Sticker {
    var title: String
    var image: UIImage
    var found: Bool
    
    init(title: String, image: UIImage, found: Bool = false) {
        self.title = title
        self.image = image
        self.found = found
    }
}
