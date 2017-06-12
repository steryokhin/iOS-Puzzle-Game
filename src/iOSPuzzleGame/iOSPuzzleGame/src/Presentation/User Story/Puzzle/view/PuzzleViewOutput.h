//
//  PuzzleViewOutput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PuzzleViewOutput <NSObject>

/*
 * call on presenter to nitify presenter that view is loaded
 */
- (void)viewIsLoaded;

/*
 * Notify presenter about start game step event. We have animated counter and on end of every animation we
 * notify presenter about that event.
 */
- (void)startGameCounterUpdated;

@end
