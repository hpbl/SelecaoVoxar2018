//
//  StickerPackManager.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import Foundation

class StickerDataProvider {
    var packs: [StickerPack]!

    // MARK: - Singleton
    static let shared = StickerDataProvider()
    
    private init() {
        self.assemblePacks()
    }
    

    // MARK: - Assembling packs
    private func assemblePacks() {
        let packNames = [
            "Apps",
            "Radiohead",
            "Doctor Who?",
            "Flag",
            "Justice League"
        ]
        
        self.packs = packNames.map { name in
            self.assemblePack(named: name)
        }
    }
    
    private func assemblePack(named: String) -> StickerPack {
        var stickers = [Sticker]()
        
        for index in 1...5 {
            let sticker = Sticker(
                title: "\(named)-\(index)",
                image: UIImage(named: "\(named)-\(index)")!
            )
            stickers.append(sticker)
        }
        
        return StickerPack(
            title: named,
            stickers: stickers
        )
    }
}
