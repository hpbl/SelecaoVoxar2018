//
//  StickerPack.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import Foundation

class StickerPack {
    var title: String
    var stickers: [Sticker]
    
    init(title: String, stickers: [Sticker]) {
        self.title = title
        self.stickers = stickers
    }
}
