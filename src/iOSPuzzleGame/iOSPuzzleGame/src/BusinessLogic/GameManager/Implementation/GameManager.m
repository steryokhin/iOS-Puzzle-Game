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

- (NSString *)getNextImagePath {
    return kDownloadImagePath;
}

@end
