//
//  Sticker.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import Foundation

class Sticker: NSObject, NSCoding {
    var title: String
    var image: UIImage
    var found: Bool
    
    init(title: String, image: UIImage, found: Bool = false) {
        self.title = title
        self.image = image
        self.found = found
    }

    // MARK: - Encoding
    enum EncodedPropety: String {
        case title
        case image
        case found
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(
            forKey: EncodedPropety.title.rawValue
        ) as! String
        
        self.found = aDecoder.decodeBool(
            forKey: EncodedPropety.found.rawValue
        )
        
        self.image = aDecoder.decodeObject(
            forKey: EncodedPropety.image.rawValue
        ) as! UIImage
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(
            self.title,
            forKey: EncodedPropety.title.rawValue
        )
        
        aCoder.encode(
            self.found,
            forKey: EncodedPropety.found.rawValue
        )
        
        aCoder.encode(
            self.image,
            forKey: EncodedPropety.image.rawValue
        )
    }
}
