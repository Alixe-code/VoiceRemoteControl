//
//  AppDelegate.h
//  UIDesign
//
//  Created by 刘俊 on 14-7-16.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define App ((AppDelegate *)[UIApplication sharedApplication].delegate)

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MMDrawerController *drawerController;
}

@property (strong, nonatomic) UIWindow *window;

-(void)loadRightView;
-(void)gestureEnable;
-(void)gestureDisable;
-(void)controllerSwitch:(UIView *)view withAnimated:(BOOL)animate;

@end
