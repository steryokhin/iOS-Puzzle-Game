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

@class StartGameView;

NS_ASSUME_NONNULL_BEGIN

@interface PuzzleViewController : UIViewController<PuzzleViewInput>

/*
 * View with label Loading to indicate to user that game resources loading in the progress
 */
@property (nonatomic, weak) IBOutlet LoadingView *loadingView;

/*
 * Start game counter view
 */
@property (nonatomic, weak) IBOutlet StartGameView *startGameView;

/*
 * Collection view to display image parts and manage their location
 */
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

/*
 * View to display frame. It is fill with clear color and have 1 pixel frame
 */
@property (nonatomic, weak) IBOutlet UIView *frameView;

/*
 * View which hold the progress view. It have basic height which we are using to draw progress
 */
@property (nonatomic, weak) IBOutlet UIView *progressHolderView;

/*
 * Progress view which drawing the progress user have
 */
@property (nonatomic, weak) IBOutlet UIView *progressView;

/*
 * Constraint to manage progress view. With constraint changing we change visual representation of the progress
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *progressHeightConstraint;

/*
 * Background gradient view
 */
@property (nonatomic, weak) IBOutlet UIWebView *gradientView;

@end

NS_ASSUME_NONNULL_END
