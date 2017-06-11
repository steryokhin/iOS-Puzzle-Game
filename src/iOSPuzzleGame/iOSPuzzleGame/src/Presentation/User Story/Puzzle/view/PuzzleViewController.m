//
//  PuzzleViewController.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 03/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "PuzzleViewController.h"
#import "BoardPuzzleModel.h"
#import "PuzzleViewModel.h"
#import "PuzzlePresenter.h"
#import "GameManager.h"
#import "StartGameView.h"
#import "GameConfig.h"

static const CGFloat kLineSpacing = 5.0;

@interface PuzzleViewController ()

@property (nonatomic, strong) PuzzlePresenter *presenter;
@property (nonatomic, copy) PuzzleViewModel *viewModel;

@end

@implementation PuzzleViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self loadSubviews];

    /// Should be in assembly
    self.presenter = [[PuzzlePresenter alloc] initWithView:self config:[GameManager.instance getNextGame]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PuzzleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PuzzleCell"];

    //self.collectionView.collectionViewLayout.dele
    self.collectionView.dataSource = self.presenter;
    
    [self.presenter viewIsLoaded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 
- (void)setupWithModel:(PuzzleViewModel *)model {
    
}

- (void)updateWithModel:(PuzzleViewModel *)model {
    NSLog(@"updateWithModel: %@", model);
    
    PuzzleViewModel *copyModel = [model copy];
    
    if (self.viewModel != copyModel) {
        if (self.viewModel.gameState != copyModel.gameState) {
            [self updateGameStateWithModel:copyModel];
        }

        if (self.viewModel.model.originalImage != copyModel.model.originalImage) {
            self.startGameView.imagePreviewView.image = copyModel.model.originalImage;
        }

        if (self.viewModel.startGameCounter != copyModel.startGameCounter) {
            [self updateStartGameCounterWithModel:copyModel];
        }

        self.viewModel = [copyModel copy];
    }
}


- (void)updateGameStateWithModel:(PuzzleViewModel *)model {
    switch (model.gameState) {
        case PuzzleGameStateNoImage: {
            [self hideStartGameView];
            [self showLoadingView];
        } break;

        case PuzzleGameStateStarting: {
            [self showStartGameView];
            [self hideLoadingView];
        } break;

        case PuzzleGameStateGameInProgress: {
            [self hideStartGameView];
            
            if (self.viewModel.config) {
                CGFloat width = self.collectionView.bounds.size.width;
                CGFloat height = self.collectionView.bounds.size.height;
                
                width -= kLineSpacing * (self.viewModel.config.columnCount - 1);
                height -= kLineSpacing * (self.viewModel.config.rowCount - 1);
                
                CGFloat cellWidth = width/self.viewModel.config.columnCount;
                CGFloat cellHeight = height/self.viewModel.config.rowCount;
                
                UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;//[[UICollectionViewFlowLayout alloc] init];
                if (layout) {
                    //layout.estimatedItemSize = CGSizeMake(cellWidth, cellHeight);
                    layout.itemSize = CGSizeMake(cellWidth, cellHeight);
                    layout.minimumInteritemSpacing = kLineSpacing;
                    layout.minimumLineSpacing = kLineSpacing;
                    
                    [layout invalidateLayout];
                }
                
                self.collectionView.collectionViewLayout = layout;
            }
            
            [self.collectionView reloadData];
        } break;

        case PuzzleGameStateFinished: {

        } break;

        default: {

        }
    }
}

- (void)updateStartGameCounterWithModel:(PuzzleViewModel *)model {
    NSLog(@"updateStartGameCounterWithModel: %@", model);

    self.startGameView.counterLabel.text = [@(model.startGameCounter) stringValue];

    [self.presenter startGameCounterUpdated];
}

- (void)updateWithBoardPuzzleModel:(BoardPuzzleModel *)boardModel {

}


#pragma mark - Subviews managements
- (void)loadSubviews {
    [self loadLoadingView];
    [self loadStartGameView];
}

- (void)loadLoadingView {
    [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil];
    [self.loadingView setHidden:YES];
    self.loadingView.frame = self.view.bounds;
    [self.view addSubview:self.loadingView];
    self.loadingView.backgroundColor = [UIColor cyanColor];

    NSMutableArray *allConstraints = [NSMutableArray new];
    NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"view":self.loadingView}];
    [allConstraints addObjectsFromArray:widthConstraints];
    NSArray *heightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:@{@"view":self.loadingView}];
    [allConstraints addObjectsFromArray:heightConstraints];

    [self.view addConstraints:allConstraints];
}

- (void)loadStartGameView {
    [[NSBundle mainBundle] loadNibNamed:@"StartGameView" owner:self options:nil];
    [self.startGameView setHidden:YES];
    self.startGameView.frame = self.view.bounds;
    self.startGameView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.startGameView];
    
    NSMutableArray *allConstraints = [NSMutableArray new];
    NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"view":self.startGameView}];
    [allConstraints addObjectsFromArray:widthConstraints];
    
    NSArray *heightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:@{@"view":self.startGameView}];
    [allConstraints addObjectsFromArray:heightConstraints];

    [self.view addConstraints:allConstraints];
}

- (void)showLoadingView {
    [self.loadingView setHidden:NO];
}

- (void)hideLoadingView {
    [self.loadingView setHidden:YES];
}

- (void)showStartGameView {
    [self.startGameView setHidden:NO];
}

- (void)hideStartGameView {
    [self.startGameView setHidden:YES];
}

#pragma mark - Utility
- (CGSize)calculateCellSize {
    CGSize size = CGSizeMake(100, 100);
    
    if (self.viewModel.config) {
        CGFloat width = self.collectionView.bounds.size.width;
        CGFloat height = self.collectionView.bounds.size.height;
        
        width -= kLineSpacing * (self.viewModel.config.columnCount - 1);
        height -= kLineSpacing * (self.viewModel.config.rowCount - 1);
        
        CGFloat cellWidth = width/self.viewModel.config.columnCount;
        CGFloat cellHeight = height/self.viewModel.config.rowCount;
        
        size.width = cellWidth;
        size.height = cellHeight;
    }
    
    return size;
}

#pragma mark - 

@end
