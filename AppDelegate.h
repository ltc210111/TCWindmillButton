//
//  AppDelegate.h
//  TCWindmillButton
//
//  Created by lotic on 17/2/8.
//  Copyright © 2017年 lotic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

