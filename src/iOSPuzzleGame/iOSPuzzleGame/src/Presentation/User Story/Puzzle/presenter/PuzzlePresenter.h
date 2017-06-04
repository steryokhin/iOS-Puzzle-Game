//
//  PuzzlePresenter.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PuzzleViewModel;

@interface PuzzlePresenter : NSObject

@property (nonatomic, strong) PuzzleViewModel *viewModel;

@end
