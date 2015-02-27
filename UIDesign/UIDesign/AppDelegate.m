//
//  AppDelegate.m
//  UIDesign
//
//  Created by 刘俊 on 14-7-16.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SettingViewController.h"
#import "GuideViewController.h"
#import "BootController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BootController *bootView = [[BootController alloc]init];
    self.window.rootViewController = bootView;
    
//    MainViewController *mainView = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//    UINavigationController *centerNavi = [[UINavigationController alloc]initWithRootViewController:mainView];
//    self.window.rootViewController = centerNavi;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)controllerSwitch:(UIView *)view withAnimated:(BOOL)animate
{
    if ([GuideViewController firstLoadGuideView])
    {
        GuideViewController *guide = [[GuideViewController alloc]init];
        self.window.rootViewController = guide;
    }
    else
    {
        [self disappear:view withAnimated:animate];
    }
}

-(void)disappear:(UIView *)view withAnimated:(BOOL)animate
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIWindow *window;
    window = [UIApplication sharedApplication].keyWindow;
    window.backgroundColor=[UIColor blackColor];
    
    UIViewController *controller=[self loadMainView];
    
    if (animate)
    {
        CGRect frame=window.rootViewController.view.frame;
        controller.view.backgroundColor=[UIColor whiteColor];
        controller.view.frame=frame;
        controller.view.alpha=0;
        controller.view.transform=CGAffineTransformMakeScale(0.9, 0.9);
        [window addSubview:controller.view];
        
        [UIView animateWithDuration:.8
                              delay:0.0
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:
         ^{
             window.rootViewController.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
             controller.view.alpha=1;
             controller.view.transform = CGAffineTransformMakeScale(1, 1);
         }
                         completion:^(BOOL finished)
         {
             window.rootViewController=controller;
             [view removeFromSuperview];
         }];
    }
    else
    {
        window.rootViewController=controller;
        [view removeFromSuperview];
    }
}

-(void)loadGuideView
{
    GuideViewController *guide = [[GuideViewController alloc]init];
    self.window.rootViewController = guide;
}

-(UIViewController *)loadMainView
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    MainViewController *centerViewController = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *centerNavi = [[UINavigationController alloc]initWithRootViewController:centerViewController];
    
    SettingViewController * rightSideDrawerViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    
    drawerController = [[MMDrawerController alloc]
                        initWithCenterViewController:centerNavi
                        rightDrawerViewController:rightSideDrawerViewController];
    [drawerController setMaximumRightDrawerWidth:220.0];
    [self gestureDisable];
    
    return drawerController;
}

-(void)loadRightView
{
    [drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

-(void)gestureEnable
{
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

-(void)gestureDisable
{
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
