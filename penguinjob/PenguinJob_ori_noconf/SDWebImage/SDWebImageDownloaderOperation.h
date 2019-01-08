#import <Foundation/Foundation.h>
#import "SDWebImageDownloader.h"
#import "SDWebImageOperation.h"
@interface SDWebImageDownloaderOperation : NSOperation <SDWebImageOperation>
@property (strong, nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, assign) BOOL shouldUseCredentialStorage;
@property (nonatomic, strong) NSURLCredential *credential;
@property (assign, nonatomic, readonly) SDWebImageDownloaderOptions options;
- (id)initWithRequest:(NSURLRequest *)request
              options:(SDWebImageDownloaderOptions)options
             progress:(SDWebImageDownloaderProgressBlock)progressBlock
            completed:(SDWebImageDownloaderCompletedBlock)completedBlock
            cancelled:(SDWebImageNoParamsBlock)cancelBlock;
@end
