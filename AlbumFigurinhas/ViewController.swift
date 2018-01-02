//
//  ViewController.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StickerResearcher {
    
    @IBOutlet weak var imgView: UIImageView!
    
    var camera: StickerCamera!
    var currentSticker: Sticker!
    var currentPage: StickerPageViewController!
    
    @IBAction func tapCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.camera = StickerCamera(
            controller: self,
            andImageView: self.imgView,
            andStickerImage: self.currentSticker.image
        )
    }

    // Start it when it appears
    override func viewDidAppear(_ animated: Bool) {
        self.camera.start()
    }
    
    // Stop it when it disappears
    override func viewWillDisappear(_ animated: Bool) {
        self.camera.stop()
    }
}

extension ViewController: StickerCameraDelegate {
    func matchedItem() {
        self.dismiss(animated: true) {
            self.currentPage.found(sticker: self.currentSticker)
        }
    }
}

