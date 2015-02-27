//
//  MicButton.h
//  ButtonTest
//
//  Created by 刘俊 on 14-8-20.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

typedef NS_ENUM(NSInteger, TalkingConditionType)
{
    TalkingStart = 0,
    TalkingLoading,
    TalkingCancle,
    TalkingWillCancle,
    TalkingEnd,
};

#import <UIKit/UIKit.h>

@interface MicButton : UIButton
{
    TalkingConditionType currentType;
}

@property (nonatomic)id delegate;

@end

@protocol MicButtonDelegate <NSObject>

-(void)micBtnTouchStart;
-(void)micBtnToucnEnd;
-(void)micBtnTouchWillCancle;
-(void)micBtnTouchLoading;
-(void)micBtnTouchCancle;

@end
