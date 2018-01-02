//
//  StickerResearcher.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 02/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import Foundation

protocol StickerResearcher {
    var currentSticker: Sticker! { get set }
    var currentPage: StickerPageViewController! { get set }
}
