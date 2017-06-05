//
//  PuzzlePresenter.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "DownloadManagerOutput.h"
#import "PuzzlePresenter.h"
#import "GameConfig.h"
#import "GameManagerInput.h"
#import "GameManager.h"
#import "PuzzleViewModel.h"
#import "PuzzleViewInput.h"

@interface PuzzlePresenter()

@property (nonatomic, weak) NSObject<PuzzleViewInput> *view;

@end

@implementation PuzzlePresenter

#pragma makr - PuzzlePresenterInput
- (instancetype)initWithView:(NSObject<PuzzleViewInput> *)view config:(GameConfig *)config {
    self = [super init];

    if (self) {
        self.view = view;

        self.viewModel = [[PuzzleViewModel alloc] initWithConfig:config];
    }

    return self;
}

#pragma mark - PuzzleViewOutput protocol implementation
- (void)viewIsLoaded {
    //TODO: make request to the download manager

    [self.view updateWithModel:self.viewModel];
}

#pragma mark - DownloadManagerOutput protocol implementation
- (void)imageDownloaded:(UIImage *)image {

}

- (void)imageDownloadFailed:(NSError *)error {

}

@end
