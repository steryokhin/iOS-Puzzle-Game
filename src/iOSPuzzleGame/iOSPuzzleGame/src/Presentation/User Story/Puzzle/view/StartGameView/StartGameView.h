//
//  StartGameView.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 05/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Overlay view to display loaded image with start game counter
 */
@interface StartGameView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *imagePreviewView;

@property (nonatomic, weak) IBOutlet UILabel *counterLabel;

@end
