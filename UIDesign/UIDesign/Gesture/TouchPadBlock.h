//
//  TouchPadBlock.h
//  UIDesign
//
//  Created by 刘俊 on 14-8-26.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

//typedef NS_ENUM(NSInteger, GestureType)
//{
//    Swipe_Left,
//    Swipe_Right,
//    Swipe_Up,
//    Swipe_Down,
//    Tap_Single,
//    Long_Press,
//    Long_Press_Will_Cancle,
//    Long_Press_Continue,
//    Long_Press_End,
//    Long_Press_Cancle,
//};
#import "TouchPad.h"

typedef void(^ GestureWithType)(GestureType type);

#import <UIKit/UIKit.h>

@interface TouchPadBlock : UIView
{
    UIView *touchView;
    UIView *borderView;
    
    CGPoint startPoi;
    NSTimeInterval startTime;
    NSTimeInterval startTime_timer;
    NSTimer *touchTimer;
    
    BOOL isLongPress;
    
    BOOL touchStart;
    
    float longPressHeight;
    CGPoint currentPoint;
    GestureType currentType;
}

@property (nonatomic,assign)GestureWithType gestureType;

-(void)loadCallBack:(GestureWithType)type;

@end
