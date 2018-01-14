//
//  StickerPageViewController.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import UIKit
import SimpleImageViewer
import Cheers

class StickerPageViewController: UIViewController {
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet var stickersImageView: [UIImageView]!
    
    var stickerPack: StickerPack!
    
    lazy var cheerView: CheerView = {
        let cheerView = CheerView()
        self.view.addSubview(cheerView)
        return cheerView
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentStickers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cheerView.frame = view.bounds
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
            let sticker = self.stickerPack.stickers[index]
            
            let imageView = self.stickersImageView[index]
            
            DispatchQueue.main.async {
                imageView.image = sticker.found
                    ? sticker.image
                    : sticker.image.overlayed(with: #imageLiteral(resourceName: "emptySticker").alpha(0.9))
            }
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
                
                if sticker.found {
                    let configuration = ImageViewerConfiguration {
                        config in
                        config.imageView = tappedView
                    }
                    
                    let imageViewerController = ImageViewerController(
                        configuration: configuration
                    )
                    
                    self.present(
                        imageViewerController,
                        animated: true
                    )
                } else {
                    self.look(for: sticker)
                }
            }
        }
    }
    
    private func look(for sticker: Sticker) {        
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
                
                self.celebrate()
                
                return
            }
        }
    }
    
    private func celebrate() {
        self.cheerView.start()
        
        DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + 2) {
            self.cheerView.stop()
        }
    }
    
    
    // MARK: - Reset
    @IBAction func tapResetButton(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Reset Progress?",
            message: "Are you sure you want to reset your progress?",
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "No",
                style: .default,
                handler: nil
            )
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Yes",
                style: .destructive,
                handler: { _ in
                    StickerDataProvider.shared.resetSavedStickers() {
                        self.updateStickerImages()
                    }
            })
        )
        
        self.present(alertController, animated: true)
    }
}
