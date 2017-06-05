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
#import "PuzzleViewModel.h"
#import "PuzzleViewInput.h"
#import "DownloadManager.h"
#import "BoardPuzzleModel.h"

@interface PuzzlePresenter()

@property (nonatomic, weak) NSObject<PuzzleViewInput> *view;

@property (nonatomic, strong) NSObject<DownloadManagerInput> *downloader;

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

- (void)dealloc {
    if (self.downloader) {
        [self.downloader cancel];
        self.downloader  = nil;
    }
}


#pragma mark - PuzzleViewOutput protocol implementation
- (void)viewIsLoaded {
    [self.view updateWithModel:self.viewModel];

    [self requestPhoto];
    
}

- (void)startGameCounterUpdated {
    if (self.viewModel.startGameCounter > 1) {
        self.viewModel.startGameCounter -= 1;

        gcdDispatchAsyncOnMainQueueAfter(2.0, ^{
            [self.view updateWithModel:self.viewModel];
        });
    } else {
        gcdDispatchAsyncOnMainQueueAfter(2.0, ^{
            self.viewModel.startGameCounter = 0;

            self.viewModel.gameState = PuzzleGameStateGameInProgress;
            [self.view updateWithModel:self.viewModel];
        });
    }
}


#pragma mark - DownloadManagerOutput protocol implementation
- (void)imageDownloaded:(UIImage *)image {
    NSLog(@"Image downloaded successfully");

    self.viewModel.model.originalImage = image;
    self.viewModel.gameState = PuzzleGameStateStarting;
    self.viewModel.startGameCounter = self.viewModel.config.startGameCounter;

    [self.view updateWithModel:self.viewModel];
}

- (void)imageDownloadFailed:(NSError *)error {
    NSLog(@"Image download failed with error: %@", error);

    gcdDispatchAsyncOnMainQueueAfter(5.0, ^{
        [self requestPhoto];
    });
}


#pragma mark - Utility
- (void)requestPhoto {
    if (self.downloader) {
        [self.downloader cancel];
        self.downloader  = nil;
    }

    self.downloader = [[DownloadManager alloc] initWithPath:self.viewModel.config.imagePath delegate:self];
    [self.downloader startDownloading];
}

@end
