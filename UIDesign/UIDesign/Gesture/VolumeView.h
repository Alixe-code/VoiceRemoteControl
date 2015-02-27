//
//  VolumeView.h
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-15.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define Volume_width  40
#define Volume_height 271

#import <UIKit/UIKit.h>

@interface VolumeView : UIView
{
    CGPoint startPoint;
    UIImageView *process;
    UIView *maskView;
    BOOL finish;
    BOOL up;
}

@end
