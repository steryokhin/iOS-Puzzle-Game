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
#import "UIImage+Splitter.h"
#import "PuzzleCollectionViewCell.h"

static const float_t kDelayBeforeNextTry = 5.0;
static const float_t kStartGameCounterDelay = 2.0;

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

#pragma mark - Collection View DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.model.parts.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PuzzleCell";
    NSArray *parts = self.viewModel.model.parts;

    UICollectionViewCell *rawCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    PuzzleCollectionViewCell *cell = [PuzzleCollectionViewCell castObject:rawCell];

    if (cell && indexPath.row < parts.count) {
        cell.imageView.image = parts[indexPath.row];
    }

    return cell;
}


#pragma mark - PuzzleViewOutput protocol implementation
- (void)viewIsLoaded {
    [self.view updateWithModel:self.viewModel];

    [self requestPhoto];
    
}

- (void)startGameCounterUpdated {
    if (self.viewModel.startGameCounter > 1) {
        self.viewModel.startGameCounter -= 1;

        gcdDispatchAsyncOnMainQueueAfter(kStartGameCounterDelay, ^{
            [self.view updateWithModel:self.viewModel];
        });
    } else {
        gcdDispatchAsyncOnMainQueueAfter(kStartGameCounterDelay, ^{
            self.viewModel.startGameCounter = 0;

            self.viewModel.gameState = PuzzleGameStateGameInProgress;
            [self.view updateWithModel:self.viewModel];
        });
    }
}


#pragma mark - DownloadManagerOutput protocol implementation
- (void)imageDownloaded:(UIImage *)image {
    NSLog(@"Image downloaded successfully");

    BoardPuzzleModel *puzzleModel = [[BoardPuzzleModel alloc] initWithOriginalImage:image parts:nil];
    self.viewModel.model = puzzleModel;
    self.viewModel.gameState = PuzzleGameStateStarting;
    self.viewModel.startGameCounter = self.viewModel.config.startGameCounter;

    [self.view updateWithModel:self.viewModel];

    gcdDispatchAsyncOnBackgroundQueue(^{
        NSArray *images = [image splitWithNumberOfRows:self.viewModel.config.rowCount columns:self.viewModel.config.columnCount];

        BoardPuzzleModel *puzzleModel = [[BoardPuzzleModel alloc] initWithOriginalImage:image parts:images];
        self.viewModel.model = puzzleModel;

        /// We don't send event here and we are sure split work fast
    });
}

- (void)imageDownloadFailed:(NSError *)error {
    NSLog(@"Image download failed with error: %@", error);

    gcdDispatchAsyncOnMainQueueAfter(kDelayBeforeNextTry, ^{
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
