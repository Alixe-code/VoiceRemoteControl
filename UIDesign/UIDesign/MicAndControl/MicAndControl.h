//
//  MicAndControl.h
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-15.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

typedef NS_ENUM(NSInteger,NoticeLabelAniType){
    NoticeLabelNormal = 0,
    NoticeLabelMusicCtl,
    NoticeLabelTouch
};

typedef NS_ENUM(NSInteger, MusicBtnType)
{
    MusicPlay = 0,
    MusicPause,
    MusicLast,
    MusicNext,
};

#import <UIKit/UIKit.h>
#import "GestureController.h"
#import "MicButton.h"

#define MICVIEW_LENGTH 139

@interface MicAndControl : UIView
{
    IBOutlet UIImageView *micBac;
    IBOutlet UIButton *switchBtn;
    IBOutlet UIButton *returnBtn;
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *infoBtn;
    IBOutlet UIButton *showBtn;
    IBOutlet MicButton *micBtn;
    
    UIButton *playBtn;
    UIImageView *btnIcon;
    UIButton *lastBtn;
    UIButton *nextBtn;
    
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    UIImageView *image4;
    
    BOOL show;
    BOOL pause;
    
    UIView *playerBac;
    
    UIView *talkingView;
    UILabel *talkingLabel;
    UIImageView *volumeView;
}

@property (nonatomic,assign)id delegate;

-(void)initWidget;

@end

@protocol MicAndControlDelegate <NSObject>

-(void)modeDidSwitch:(NoticeLabelAniType)type;
-(void)didTouchedMusicButton:(MusicBtnType)type;

@end
