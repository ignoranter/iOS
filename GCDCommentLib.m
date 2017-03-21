//
//  GCDCommentLib.m
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/16.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import "GCDCommentLib.h"
#import "pthread.h"

@implementation GCDCommentLib

static dispatch_queue_t _GlobalQueue;
static dispatch_group_t _Group;
static void* const GlobalQueueIdentityKey = (void *)&GlobalQueueIdentityKey;
static dispatch_semaphore_t _QueueSemaphore;
static NSInteger _NumProcessors;

#define LOG_MAX_QUEUE_SIZE 1000

+ (void)initialize {
    static dispatch_once_t gcdOnceToken;
    dispatch_once(&gcdOnceToken, ^{
        _GlobalQueue = dispatch_queue_create("GCDCommentLib", NULL);
        _Group = dispatch_group_create();
        void *nonNullValue = GlobalQueueIdentityKey; // Whatever, just not null
        
        dispatch_queue_set_specific(_GlobalQueue, GlobalQueueIdentityKey, nonNullValue, NULL);
        _QueueSemaphore = dispatch_semaphore_create(LOG_MAX_QUEUE_SIZE);
        // Figure out how many processors are available.
        _NumProcessors = MAX([NSProcessInfo processInfo].processorCount, 1);
    });
}

static inline dispatch_queue_t globalQueue(){
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)asyncGlobalQueueWithBlock:(dispatch_block_t)block{
    dispatch_async(_GlobalQueue, block);
}

- (void)syncGlobalQueueWithBlock:(dispatch_block_t)block{
    dispatch_sync(_GlobalQueue, block);
}

- (void)asyncGroupQueueWithBlock:(dispatch_block_t)block{
    dispatch_group_async(_Group, globalQueue(),block);
}

- (void)dispatchNotifyWithBlock:(dispatch_block_t)block{
    dispatch_group_notify(_Group, globalQueue(), block);
}

- (void)asyncOnMainQueue:(dispatch_block_t)block{
    if (pthread_main_np()) {
        block();
    }
    dispatch_async(dispatch_get_main_queue(), block);
}
@end
