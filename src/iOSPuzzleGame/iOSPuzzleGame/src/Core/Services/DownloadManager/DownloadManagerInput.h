//
//  DownloadManagerInput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Interface to manage downloading of the image
 */
@protocol DownloadManagerOutput;

@protocol DownloadManagerInput <NSObject>

/*
 * Initialiser for the downloader
 */
- (instancetype)initWithPath:(NSString *)path delegate:(NSObject<DownloadManagerOutput> *)delegate;

/*
 * start downloading of the image for configured downloader
 */
- (void)startDownloading;

/*
 * Cancel downloading if downloading is in the progress
 */
- (void)cancel;

@end
