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
#import "StyleKit.h"
#import "LXReorderableCollectionViewFlowLayout.h"
#import "AppDelegate.h"

static const CGFloat kLineSpacing = 1.0;
static const CGFloat kCounterAnimationDuration = 1.0;

@interface PuzzleViewController ()

@property (nonatomic, strong) PuzzlePresenter *presenter;
@property (nonatomic, copy) PuzzleViewModel *viewModel;

@end

@implementation PuzzleViewController

- (void)setupCollectionView {
    /// Should be in assembly
    self.presenter = [[PuzzlePresenter alloc] initWithView:self config:[GameManager.instance getNextGame]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PuzzleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PuzzleCell"];
    
    self.collectionView.dataSource = self.presenter;
    LXReorderableCollectionViewFlowLayout *collectionViewLayout = [LXReorderableCollectionViewFlowLayout castObject:self.collectionView.collectionViewLayout];
    if (collectionViewLayout) {
        collectionViewLayout.longPressGestureRecognizer.minimumPressDuration = 0.2;
    }
}

- (void)setupGradientView {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"gradient" withExtension:@"html"];
    [self.gradientView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self loadSubviews];
    [self setupCollectionView];
    [self setupGradientView];
    
    
    [self.presenter viewIsLoaded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Appear/Disappear 
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = [AppDelegate castObject:[UIApplication sharedApplication].delegate];
    if (appDelegate) {
        [appDelegate setShouldRotate:YES]; // or NO to disable rotation
    }
}

- (void)setupWithModel:(PuzzleViewModel *)model {
    self.frameView.backgroundColor = [UIColor clearColor];
    CGFloat borderWidth = 1.0f;
    
    self.frameView.frame = CGRectInset(self.frameView.frame, -borderWidth, -borderWidth);
    self.frameView.layer.borderColor = [StyleKit progressColor].CGColor;
    self.frameView.layer.borderWidth = borderWidth;
    
    self.progressHolderView.backgroundColor = [UIColor clearColor];
    
    self.progressView.backgroundColor = [StyleKit progressColor];
    
    [self updateProgressWithModel:model];
}

- (void)updateWithModel:(PuzzleViewModel *)model {
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

        if (self.viewModel.gameState == PuzzleGameStateGameInProgress) {
            [self updateProgressWithModel:copyModel];
        }
        

        self.viewModel = copyModel;
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
                
                UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout castObject:self.collectionView.collectionViewLayout];
                if (layout) {
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
            [self displayEndGameMessage];
        } break;

        default: {

        }
    }
}

- (void)updateStartGameCounterWithModel:(PuzzleViewModel *)model {
    self.startGameView.counterLabel.text = [@(model.startGameCounter) stringValue];
    self.startGameView.counterLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.startGameView.counterLabel.alpha = 1.0;
    [UIView animateWithDuration:kCounterAnimationDuration animations:^{
        self.startGameView.counterLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        self.startGameView.counterLabel.alpha = 0.2;
    } completion:^(BOOL finished) {
        [self.presenter startGameCounterUpdated];
    }];
}

- (void)updateProgressWithModel:(PuzzleViewModel *)model {
    [self.view layoutIfNeeded];
    
    self.progressHeightConstraint.constant = (1.0 - model.puzzleProgress)*self.progressHolderView.frame.size.height;
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)updateWithBoardPuzzleModel:(BoardPuzzleModel *)boardModel {

}

#pragma mark - Rotation Support
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft; // or Right of course
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
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

#pragma mark - 
- (void)displayEndGameMessage {
    //TODO:
}

@end
