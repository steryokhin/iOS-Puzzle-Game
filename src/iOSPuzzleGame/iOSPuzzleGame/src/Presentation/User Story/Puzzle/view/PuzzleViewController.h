//
//  PuzzleViewController.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 03/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuzzleViewInput.h"

#import "LoadingView.h"

@interface PuzzleViewController : UIViewController<PuzzleViewInput>

/*
 * View with label Loading to indicate to user that game resources loading in the progress
 */
@property (nonatomic, weak) IBOutlet LoadingView *loadingView;

/*
 * Start game counter view
 */
@property (nonatomic, weak) IBOutlet UIView *startGameView;

@end

