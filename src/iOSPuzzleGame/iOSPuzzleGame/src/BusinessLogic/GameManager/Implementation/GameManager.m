//
//  GameManager.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "GameManager.h"
#import "GameManagerInput.h"
#import "Constants.h"
#import "GameConfig.h"


@implementation GameManager

+ (NSObject<GameManagerInput> *)instance {
    static GameManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (GameConfig *)getNextGame {
    return [[GameConfig alloc] initWithImagePath:kDownloadImagePath
                                               rowCount:3
                                            columnCount:4
                                       startGameCounter:3
                                         startGameDelay:2.0
                                           gameDuration:21];
}

@end
