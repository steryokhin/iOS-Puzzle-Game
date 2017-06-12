//
//  PuzzlePresenterOutput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 13/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PuzzlePresenterOutput <NSObject>

@required
/*
 * notify parent module about successfull puzzle solution
 */
- (void)puzzleDoneSuccessfully;
    
/*
 * Notify parent module that puzzle does not complete
 */
- (void)puzzleDoesNotComplete;
    
@end

NS_ASSUME_NONNULL_END
