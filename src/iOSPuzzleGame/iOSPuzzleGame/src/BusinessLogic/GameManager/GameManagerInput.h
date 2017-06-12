//
//  GameManagerInput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameConfig;

/*
 * Provide interface to the game settings
 */
@protocol GameManagerInput <NSObject>

- (GameConfig *)getNextGame;

@end
