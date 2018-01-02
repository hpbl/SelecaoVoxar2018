//
//  StickerCamera.h
//  AlbumFigurinhas
//
//  Created by Hilton Pintor Bezerra Leite on 01/01/2018.
//  Copyright © 2018 hpbl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Protocol for callback action
@protocol StickerCameraDelegate <NSObject>

- (void)matchedItem;

@end

// Public interface for camera. ViewController only needs to init, start and stop.
@interface StickerCamera : NSObject

-(id) initWithController: (UIViewController<StickerCameraDelegate>*)c andImageView: (UIImageView*)iv andStickerImage: (UIImage*)si;
-(void)start;
-(void)stop;

@end
