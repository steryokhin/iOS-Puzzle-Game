//
//  DownloadManagerOutput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DownloadManagerOutput <NSObject>

- (void)imageDownloaded:(UIImage *)image;
- (void)imageDownloadFailed:(NSError *)error;

@end
