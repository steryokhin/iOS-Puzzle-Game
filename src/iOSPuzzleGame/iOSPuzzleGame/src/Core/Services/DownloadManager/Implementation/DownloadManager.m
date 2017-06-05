//
//  DownloadManager.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "DownloadManager.h"
#import "DownloadManagerOutput.h"
#import <UIKit/UIKit.h>

@interface DownloadManager()

@property (nonatomic, strong) NSString *downloadPath;
@property (nonatomic, weak) NSObject<DownloadManagerOutput> *delegate;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadPhotoTask;

@end

@implementation DownloadManager

- (instancetype)initWithPath:(NSString *)path delegate:(NSObject<DownloadManagerOutput> *)delegate {
    self = [super init];

    if (self) {
        self.downloadPath  = path;
        self.delegate = delegate;
    }

    return self;
}

- (void)startDownloading {
    NSURL *url = [NSURL URLWithString:self.downloadPath];

    __weak DownloadManager *weakSelf = self;
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
            downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
            {
                DownloadManager *strongSelf = weakSelf;
                if (![strongSelf.delegate conformsToProtocol:@protocol(DownloadManagerOutput)]) {
                    return;
                }

                gcdDispatchAsyncOnMainQueue(^{
                    if (error) {
                        [strongSelf.delegate imageDownloadFailed:error];
                    }
                    
                    if (location) {
                        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                        
                        [strongSelf.delegate imageDownloaded:downloadedImage];
                    } else {
                        [strongSelf.delegate imageDownloadFailed:nil];
                    }
                });
            }];

    [downloadPhotoTask resume];

    self.downloadPhotoTask = downloadPhotoTask;
}

- (void)cancel {
    [self.downloadPhotoTask cancel];
}


@end
