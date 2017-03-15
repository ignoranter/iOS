//
//  AppDelegate.h
//  MZNetWorking
//
//  Created by LiXiangming on 2017/3/15.
//  Copyright © 2017年 LiXiangming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

