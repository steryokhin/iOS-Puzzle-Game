//
//  PuzzlePresenter.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManagerInput.h"
#import "PuzzleViewOutput.h"
#import "PuzzlePresenterInput.h"
#import "DownloadManagerOutput.h"

@class PuzzleViewModel;
@class BoardPuzzleModel;

NS_ASSUME_NONNULL_BEGIN

/*
 * Presenter class for the Puzzle module. It handle all the logic of working with model, switching stated etc
 */
@interface PuzzlePresenter : NSObject<PuzzlePresenterInput, PuzzleViewOutput, DownloadManagerOutput, UICollectionViewDataSource>

@property (nonatomic, strong) PuzzleViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
