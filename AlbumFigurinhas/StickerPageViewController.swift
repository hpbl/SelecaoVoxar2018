//
//  StickerPageViewController.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import UIKit

class StickerPageViewController: UIViewController {
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet var stickersImageView: [UIImageView]!
    
    var stickerPack: StickerPack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentStickers()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "lookForSticker":
            guard var destination = segue.destination as? StickerResearcher
                else {
                    fatalError(
                        "Expected segue destination to be ViewController"
                    )
            }
            
            guard let sticker = sender as? Sticker else {
                fatalError("Expected sender to be Sticker")
            }
            
            destination.currentSticker = sticker
            destination.currentPage = self
            
        default:
            return
        }
    }
    
    //MARK: - UI Setup
    private func presentStickers() {
        self.pageTitleLabel.text = self.stickerPack.title
        
        self.setupRecognizers()
        self.updateStickerImages()
    }
    
    private func setupRecognizers() {
        self.stickersImageView.forEach { imageView in
            let tapRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(self.handleTap(_:))
            )
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    private func updateStickerImages() {
        for index in 0..<self.stickersImageView.count {
            var sticker = self.stickerPack.stickers[index]
            
            if let fetchedSticker = StickerDataProvider.shared.fetchSticker(
                    titled: sticker.title
                ) {
                sticker = fetchedSticker
            }
            
            let imageView = self.stickersImageView[index]
            imageView.image = sticker.found
                ? sticker.image
                : sticker.image.overlayed(with: #imageLiteral(resourceName: "emptySticker").alpha(0.9))
        }
    }
    
    
    // MARK: - Sticker interaction
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view as? UIImageView else {
            return
        }
        
        for index in 0..<self.stickersImageView.count {
            if tappedView == self.stickersImageView[index] {
                
                let sticker = self.stickerPack.stickers[index]
                self.look(for: sticker)
            }
        }
    }
    
    private func look(for sticker: Sticker) {
        guard !sticker.found else { return }
        
        print("Looking for sticker \(sticker.title)")
        
        self.performSegue(
            withIdentifier: "lookForSticker",
            sender: sticker
        )
    }
    
    func found(sticker: Sticker)  {
        for index in 0..<self.stickerPack.stickers.count {
            if self.stickerPack.stickers[index] === sticker {
                self.stickersImageView[index].image = sticker.image
                sticker.found = true
                
                StickerDataProvider.shared.save(sticker: sticker)
                
                return
            }
        }
    }
}
