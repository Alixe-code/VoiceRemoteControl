//
//  TVListViewController.h
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-14.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BASE_HEIGHT 20+44
#define TV_BUTTON_HEIGHT 44
#define FRESH_BUTTON_HEIGHT 38
#define FRESH_BUTTON_WIDTH 193
#define FRESH_BUTTON_SPACE 5

@interface TVListViewController : UIViewController
{
    IBOutlet UITableView *tvListTable;
    IBOutlet UIButton *TVBtn;
    IBOutlet UIButton *freshBtn;
    BOOL appear;
    
    //列表隐藏时的纵坐标
    float height_hidden;
}

@property (nonatomic,assign)BOOL appear;
@property id delegate;

-(IBAction)appearOrDisAppear;
-(void)loadTvList:(BOOL)condition;

@end

@protocol TVListDelegate

-(void)listDidApear:(BOOL)condition;

@end
