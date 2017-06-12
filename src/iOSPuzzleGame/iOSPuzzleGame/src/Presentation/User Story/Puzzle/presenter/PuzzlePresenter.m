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
#import "NSMutableArray+Shuffle.h"

static const float_t kDelayBeforeNextTry = 5.0;
static const float_t kStartGameCounterDelay = 2.0;

@interface PuzzlePresenter()

@property (nonatomic, weak) NSObject<PuzzleViewInput> *view;

@property (nonatomic, strong) NSObject<DownloadManagerInput> *downloader;

@property (nonatomic, strong) NSTimer *startGameTimer;
@property (nonatomic, strong) NSTimer *puzzleProgressTimer;

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

- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)fromIndexPath
    didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"move %@ to %@", fromIndexPath, toIndexPath);
    
    NSMutableArray *parts = [self.viewModel.model.parts mutableCopy];
    [parts exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    self.viewModel.model.parts = parts;

    if (self.viewModel.isSolved) {
        [self.puzzleProgressTimer invalidate];
        self.puzzleProgressTimer = nil;
        
        self.viewModel.gameState = PuzzleGameStateFinished;
        self.viewModel.doesPuzzleSolved = YES;
        
        [self.view updateWithModel:self.viewModel];
    }
}

#pragma mark - PuzzleViewOutput protocol implementation
- (void)viewIsLoaded {
    [self.view setupWithModel:self.viewModel];
    [self.view updateWithModel:self.viewModel];

    [self requestPhoto];
    
}

- (void)startGameCounterUpdated {
    self.viewModel.startGameCounter -= 1;

    if (self.viewModel.startGameCounter != 0) {
        [self.view updateWithModel:self.viewModel];
    } else {
        self.viewModel.startGameCounter = 0;
        
        self.viewModel.gameState = PuzzleGameStateGameInProgress;
        [self.view updateWithModel:self.viewModel];
        
        self.startGameTimer = [NSTimer scheduledTimerWithTimeInterval:kStartGameCounterDelay target:self selector:@selector(delayTimerFired:) userInfo:nil repeats:NO];
   }
}

- (void)delayTimerFired:(NSTimer *)delayTimer {
    
    self.startGameTimer = nil;
    self.viewModel.startProgressDate = [NSDate date];
    
    if (self.puzzleProgressTimer) {
        [self.puzzleProgressTimer invalidate];
        self.puzzleProgressTimer = nil;
    }
    self.puzzleProgressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerProgress:) userInfo:nil repeats:YES];
}

- (void)timerProgress:(NSTimer *)progressTimer {
    NSTimeInterval timeInterval = -[self.viewModel.startProgressDate timeIntervalSinceNow];

    if (timeInterval > self.viewModel.config.gameDuration) {
        [self.puzzleProgressTimer invalidate];
        self.puzzleProgressTimer = nil;
        
        self.viewModel.gameState = PuzzleGameStateFinished;
        self.viewModel.doesPuzzleSolved = YES;
        
        [self.view updateWithModel:self.viewModel];

    }
    
    [self.view updateWithModel:self.viewModel];
}

#pragma mark - DownloadManagerOutput protocol implementation
- (void)imageDownloaded:(UIImage *)image {
    BoardPuzzleModel *puzzleModel = [[BoardPuzzleModel alloc] initWithOriginalImage:image];
    self.viewModel.model = puzzleModel;
    self.viewModel.gameState = PuzzleGameStateStarting;
    self.viewModel.startGameCounter = self.viewModel.config.startGameCounter;

    [self.view updateWithModel:self.viewModel];

    gcdDispatchAsyncOnBackgroundQueue(^{
        NSArray *images = [image splitWithNumberOfRows:self.viewModel.config.rowCount columns:self.viewModel.config.columnCount];
        NSMutableArray *shuffleImages = [images mutableCopy];
        [shuffleImages shuffle];

        BoardPuzzleModel *puzzleModel = [[BoardPuzzleModel alloc] initWithOriginalImage:image originalParts:images parts:shuffleImages];

        self.viewModel.model = puzzleModel;

        /// We don't send event here and we are sure split work fast
    });
}

- (void)imageDownloadFailed:(NSError *)error {
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
