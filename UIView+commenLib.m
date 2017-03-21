//
//  UIView+commenLib.m
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/17.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import "UIView+commenLib.h"

@implementation UIView (commenLib)

- (CGFloat)left   {return self.frame.origin.x;}
- (CGFloat)top    {return self.frame.origin.y;}
- (CGFloat)right  {return CGRectGetMaxX(self.frame);}
- (CGFloat)bottom {return CGRectGetMaxY(self.frame);}
- (CGFloat)width  {return CGRectGetWidth(self.frame);}
- (CGFloat)height {return CGRectGetHeight(self.frame);}
- (CGFloat)b_x    {return self.bounds.origin.x;}
- (CGFloat)b_y    {return self.bounds.origin.y;}
- (CGFloat)centerX{return self.center.x;}
- (CGFloat)centerY{return self.center.y;}


#define UPDATE_CGRect(path, ...) {CGRect frame = path; __VA_ARGS__;  path = frame; }

- (void)setLeft:(CGFloat)left       {UPDATE_CGRect(self.frame,frame.origin.x = left);}
- (void)setTop:(CGFloat)top         {UPDATE_CGRect(self.frame,frame.origin.y = top);}
- (void)setRight:(CGFloat)right     {UPDATE_CGRect(self.frame,frame.origin.x = right-self.width)}
- (void)setBottom:(CGFloat)bottom   {UPDATE_CGRect(self.frame,frame.origin.y = bottom-self.height);}
- (void)setCenterX:(CGFloat)centerX {UPDATE_CGRect(self.frame,frame.origin.x = centerX-self.width/2);}
- (void)setWidth:(CGFloat)width     {UPDATE_CGRect(self.frame,frame.size.width = width);}
- (void)setHeight:(CGFloat)height   {UPDATE_CGRect(self.frame,frame.size.height = height);}
- (void)setB_x:(CGFloat)b_x         {UPDATE_CGRect(self.bounds,frame.origin.x = b_x);}
- (void)setB_y:(CGFloat)b_y         {UPDATE_CGRect(self.bounds,frame.origin.y = b_y);}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (__kindof UIViewController*)viewController{
    UIResponder*next = self;
    while ((next = [next nextResponder])) {
        if ([next isKindOfClass:[UIViewController class]]) return (id)next;
    }
    return nil;
}

- (__kindof UIView*)superviewOfClass:(__kindof UIView*)view{
    UIView *v = view.superview;
    while (v && ![v isKindOfClass:[UIView class]]) {
        v = v.superview;
    }
    return v;
}

- (UIImage*)snapshotImageAfterScreenUpdates:(BOOL)afterScreenUpdates {
    CGRect bounds = self.bounds;
    UIGraphicsBeginImageContextWithOptions( bounds.size, self.layer.opaque, 0 );
    CGPoint const origin = bounds.origin;
    CGContextRef const ctx = UIGraphicsGetCurrentContext();
    if (!CGPointEqualToPoint(origin, CGPointZero)) {
        CGContextTranslateCTM(ctx, -origin.x, -origin.y);
    }
    // NOTE: webView presentationLayer renderInContext crash by 0 pointer.
    // use drawViewHierarchyInRect instead
    if ([UIDevice currentDevice].systemVersion.floatValue >=7.0
        && self.window) {
        // NOTE: drawViewHierarchyInRect only draw view rendered on screen
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterScreenUpdates];
    } else {
        CALayer *const layer = self.layer;
        [layer renderInContext:ctx];
    }
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSData *)snapshotOfPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];

    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context)
        return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

@end
