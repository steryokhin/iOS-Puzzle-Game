//
//  GameManager.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameManagerInput;

@interface GameManager : NSObject<GameManagerInput>

+ (NSObject<GameManagerInput> *)instance;

@end
