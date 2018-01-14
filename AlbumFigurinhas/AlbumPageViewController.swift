//
//  StickersViewController.swift
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

import UIKit

class AlbumPageViewController: UIPageViewController {
    fileprivate lazy var pages: [UIViewController] = {
        return StickerDataProvider.shared.packs.map { pack in
            self.getViewController(for: pack)
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        if let firstVC = pages.first {
            self.setViewControllers(
                [firstVC],
                direction: .forward,
                animated: true
            )
        }
    }
    
    private func getViewController(for pack: StickerPack)
        -> UIViewController {
            let storyBoard = UIStoryboard(
                name: "Main",
                bundle: nil
            )
            
            guard let stickerPage = storyBoard.instantiateViewController(
                withIdentifier: "StickersPageVC"
                ) as? StickerPageViewController else {
                    fatalError("Expected StickerPageViewController")
            }
            
            stickerPage.stickerPack = pack
            
            return stickerPage
    }
}

extension AlbumPageViewController: UIPageViewControllerDelegate {
    
}

extension AlbumPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController)
        -> UIViewController? {
            
            
            guard let viewControllerIndex = pages.index(of: viewController)
                else {
                    return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            // prevent loop
            guard previousIndex >= 0 else { return nil }
            
            guard pages.count > previousIndex else { return nil }
            
            return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController)
        -> UIViewController? {
            
            guard let viewControllerIndex = pages.index(of: viewController)
                else {
                    return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            
            // prevet loop
            guard nextIndex < pages.count else { return nil }
            
            guard pages.count > nextIndex else { return nil }
            
            return pages[nextIndex]
    }
}
