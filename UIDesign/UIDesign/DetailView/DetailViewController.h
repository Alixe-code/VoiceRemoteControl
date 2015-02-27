//
//  DetailViewController.h
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-8-14.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic,assign)id delegate;

@end

@protocol DetailViewDelegate <NSObject>

-(void)needTofreshList;

@end
