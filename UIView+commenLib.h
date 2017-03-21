//
//  UIView+commenLib.h
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/17.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (commenLib)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat b_x;
@property (nonatomic) CGFloat b_y;

- (NSData *)snapshotOfPDF;
- (UIImage*)snapshotImageAfterScreenUpdates:(BOOL)afterScreenUpdates;
- (__kindof UIViewController*)viewController;
- (__kindof UIView*)superviewOfClass:(__kindof UIView*)view;
@end
