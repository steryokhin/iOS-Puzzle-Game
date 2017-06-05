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

@interface PuzzleViewController ()

@property (nonatomic, strong) PuzzlePresenter *presenter;

@end

@implementation PuzzleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self loadSubviews];

    /// Should be in assembly
    self.presenter = [[PuzzlePresenter alloc] initWithView:self config:[GameManager.instance getNextGame]];
    [self.presenter viewIsLoaded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupWithModel:(PuzzleViewModel *)model {
    
}

- (void)updateWithModel:(PuzzleViewModel *)model {
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

        } break;

        case PuzzleGameStateFinished: {

        } break;

        default: {

        }
    }
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

@end
