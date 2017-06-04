//
//  DownloadManagerInput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadManagerOutput;

@protocol DownloadManagerInput <NSObject>

- (instancetype)initWithPath:(NSString *)path delegate:(NSObject<DownloadManagerOutput> *)delegate;



@end
