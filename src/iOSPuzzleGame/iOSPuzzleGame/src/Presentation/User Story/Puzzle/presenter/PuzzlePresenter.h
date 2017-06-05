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

@class PuzzleViewModel;
@class BoardPuzzleModel;

@interface PuzzlePresenter : NSObject<PuzzlePresenterInput, PuzzleViewOutput, DownloadManagerOutput>

@property (nonatomic, strong) PuzzleViewModel *viewModel;

@end
