//
//  DownloadManagerOutput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 * Output protocol for downloadi manager class.
 */
@protocol DownloadManagerOutput <NSObject>

/*
 * Called when download finished successfull
 */
- (void)imageDownloaded:(UIImage *)image;

/*
 * Called when download failed
 */
- (void)imageDownloadFailed:(NSError *)error;

@end
