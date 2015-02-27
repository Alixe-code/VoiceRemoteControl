//
//  TouchPad.m
//  MethodTest
//
//  Created by 刘俊 on 14-8-6.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define Single_Tap_Interval             0.16
#define Long_Press_Interval             0.8
#define Tap_distance                    30
#define TouchViewSize                   20
#define Long_Press_Timer                1/20

#import "TouchPad.h"

@implementation TouchPad

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //[self addBorderTest];
    }
    return self;
}

-(void)addBorderTest
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TouchViewSize+5, TouchViewSize+5)];
    view.center = CGPointMake(150, 150);
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderWidth = 5;
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.cornerRadius = (TouchViewSize+5)/2;
    view.alpha = 0.5;
    //[self addSubview:view];
    
    UIView *view1  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TouchViewSize, TouchViewSize)];
    view1.center = CGPointMake(150, 150);
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = TouchViewSize/2;
    view1.alpha = 0.5;
    [self addSubview:view1];
    view1.layer.borderWidth = 2;
    view1.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startPoi = currentPoint = [touch locationInView:self];
    startTime = touch.timestamp;
    isLongPress = NO;
    touchStart = YES;
    [self startTimer];
    
    [self show:startPoi];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self distance:touches];
    [self hide];
    [self stopTimer];
    
    touchStart = NO;
    
    //长按结束
    if (isLongPress)
    {
        if (currentType == Long_Press_Will_Cancle)
        {
            if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
            {
                [self.delegate didRecognizeGestureWithType:Long_Press_Cancle];
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
            {
                [self.delegate didRecognizeGestureWithType:Long_Press_End];
            }
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchStart = NO;
    [self stopTimer];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint endPoi = [[touches anyObject]locationInView:self];
    currentPoint = endPoi;
    
    [self move:endPoi];
    
    [self freshTimer];
    
    if (isLongPress)
    {
        if (longPressHeight>endPoi.y)
        {
            if (currentType != Long_Press_Will_Cancle)
            {
                currentType = Long_Press_Will_Cancle;
                if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
                {
                    [self.delegate didRecognizeGestureWithType:Long_Press_Will_Cancle];
                }
            }
        }
        else
        {
            if (currentType != Long_Press_Continue)
            {
                currentType = Long_Press_Continue;
                if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
                {
                    [self.delegate didRecognizeGestureWithType:Long_Press_Continue];
                }
            }
        }
    }
}

-(void)distance:(NSSet *)touches
{
    if (isLongPress)
    {
        return ;
    }
    
    CGPoint endPoi = [[touches anyObject]locationInView:self];
    UITouch *touch = [touches anyObject];


//    float x_value = endPoi.x - startPoi.x;
//    float y_value = endPoi.y - startPoi.y;
//    NSLog(@"%f --- %f --- %f",touch.timestamp - startTime,fabs(x_value),fabs(y_value));
    
    //return ;

    NSTimeInterval realInterval = touch.timestamp - startTime;
    [self gestureJudge:endPoi withInteval:realInterval];
}

-(void)gestureJudge:(CGPoint)endPoi withInteval:(NSTimeInterval)realInterval
{
    float x_value = endPoi.x - startPoi.x;
    float y_value = endPoi.y - startPoi.y;
    
    //滑动手势满足的条件：X或Y轴偏移量大于Tap_distance
    if (fabs(x_value) > Tap_distance || fabs(y_value) > Tap_distance)
    {
        if(fabs(x_value)>fabs(y_value))
        {
            if (x_value < 0)
            {
                //NSLog(@"左");
                
                if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
                {
                    [self.delegate didRecognizeGestureWithType:Swipe_Left];
                }
            }
            else
            {
                //NSLog(@"右");
                
                if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
                {
                    [self.delegate didRecognizeGestureWithType:Swipe_Right];
                }
            }
        }
        else
        {
            if (y_value < 0)
            {
                //NSLog(@"上");
                
                if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
                {
                    [self.delegate didRecognizeGestureWithType:Swipe_Up];
                }
            }
            else
            {
                //NSLog(@"下");
                
                if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
                {
                    [self.delegate didRecognizeGestureWithType:Swipe_Down];
                }
            }
        }
    }
    else if (fabs(x_value) < Tap_distance && fabs(y_value) < Tap_distance)
    {
        if (realInterval < Single_Tap_Interval)
        {
            //NSLog(@"单击");
            
            if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
            {
                [self.delegate didRecognizeGestureWithType:Tap_Single];
            }
        }
        
        //长按
        //[self longPress:endPoi withInteval:realInterval];
    }
}

-(void)longPress:(CGPoint)currentPoi withInteval:(NSTimeInterval)realInterval
{
    if (isLongPress)
    {
        return ;
    }
    
    float x_value = currentPoi.x - startPoi.x;
    float y_value = currentPoi.y - startPoi.y;
    
    if (fabs(x_value) < Tap_distance
        && fabs(y_value) < Tap_distance
        &&realInterval > Long_Press_Interval)
    {
        NSLog(@"长按 - %f",realInterval);
        
        isLongPress = YES;
    }
}

#pragma mark TouchTimer(LongPress)

-(void)startTimer
{
    //记录开始时间戳
    startTime_timer = 0;
    startTime_timer = [[NSDate date]timeIntervalSince1970];
    
    touchTimer = [NSTimer scheduledTimerWithTimeInterval:Long_Press_Timer
                                                  target:self
                                                selector:@selector(LongPressedCheck)
                                                userInfo:nil
                                                 repeats:YES];
    [touchTimer fire];
}

-(void)LongPressedCheck
{
    if (touchStart&&!isLongPress)
    {
        NSTimeInterval realInterval = [[NSDate date]timeIntervalSince1970] - startTime_timer;
        //NSLog(@"%f",realInterval);
        
        if (realInterval > Long_Press_Interval)
        {
            [self stopTimer];
            
            //NSLog(@"长按");
            if ([self.delegate respondsToSelector:@selector(didRecognizeGestureWithType:)])
            {
                [self.delegate didRecognizeGestureWithType:Long_Press];
            }
            
            isLongPress = YES;
            longPressHeight = currentPoint.y;
            currentType = Long_Press;
        }
    }
}

-(void)freshTimer
{
    startTime_timer = 0;
    startTime_timer = [[NSDate date]timeIntervalSince1970];
}

-(void)stopTimer
{
    [touchTimer invalidate];
}

#pragma mark TouchPoint

-(void)show:(CGPoint)center
{
    if (touchView==nil)
    {
        UIColor *borderColor = [UIColor colorWithRed:(CGFloat)2/255 green:(CGFloat)161/255 blue:(CGFloat)244/255 alpha:1];

        touchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TouchViewSize, TouchViewSize)];
        touchView.backgroundColor = borderColor;
        touchView.alpha = 0;
        touchView.layer.cornerRadius = TouchViewSize/2;

        
        borderView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, TouchViewSize*2, TouchViewSize*2)];
        borderView.backgroundColor = [UIColor clearColor];
        borderView.alpha = 0;
        borderView.layer.cornerRadius = TouchViewSize;
        borderView.layer.borderWidth = 4;
        borderView.layer.borderColor = borderColor.CGColor;
    }
    
    touchView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    touchView.center = center;
    borderView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    borderView.center = center;
    
    [self addSubview:borderView];
    [self addSubview:touchView];

    
//    [UIView animateWithDuration:0.25
//                     animations:^{
//                         touchView.transform = CGAffineTransformMakeScale(1, 1);
//                         touchView.alpha = 0.5;
//                         borderView.transform = CGAffineTransformMakeScale(1, 1);
//                         borderView.alpha = 0.5;
//                     }];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        touchView.transform = CGAffineTransformMakeScale(1, 1);
        touchView.alpha = 0.5;
        borderView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        borderView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             borderView.transform = CGAffineTransformMakeScale(2, 2);
                             borderView.alpha = 0;
                         }];
        
    }];
}

-(void)move:(CGPoint)center
{
    touchView.center = center;
    borderView.center = center;
}

-(void)hide
{
    [UIView animateWithDuration:0.4
                     animations:^{
                         touchView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                         touchView.alpha = 0;
                     }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
