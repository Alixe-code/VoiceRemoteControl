//
//  VolumeView.m
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-15.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define SINGLE_LENGTH (self.frame.size.height/15)

#define tag_up 11
#define tag_down 12

#import "VolumeView.h"

@implementation VolumeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init
{
    if (self==[super init])
    {
        UIImage *image = [UIImage imageNamed:@"volume.png"];
        UIImageView *bacImage = [[UIImageView alloc]initWithImage:image];
        bacImage.frame = CGRectMake((Volume_width - image.size.width)/2,
                                    (Volume_height - image.size.height)/2,
                                    image.size.width, image.size.height);
        [self addSubview:bacImage];
        
        //拖动
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        [self addMaksView];
        [self addProcess];

    }
    return self;
}

-(void)addMaksView
{
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, Volume_height)];
    maskView.backgroundColor = [UIColor clearColor];
    [self addSubview:maskView];

    CAShapeLayer *processBacLayer=[CAShapeLayer layer];
    CGRect frame=CGRectMake(0, 39, 30, Volume_height - 71);
    UIBezierPath *processPath=[UIBezierPath
                               bezierPathWithRect:frame];
    processBacLayer.path = processPath.CGPath;
    maskView.layer.mask = processBacLayer;
}

-(void)addProcess
{
    UIImage *image = [UIImage imageNamed:@"volume_down.png"];
    process = [[UIImageView alloc]initWithFrame:CGRectMake((Volume_width/2 - 1),
                                                           400,
                                                           image.size.width,
                                                           image.size.height)];
    process.image = image;
    [maskView addSubview:process];
    
    finish = YES;
}

-(void)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint pt = [sender locationInView:self];
    
    //NSLog(@"%@",NSStringFromCGPoint(pt));
    
    if (pt.y>self.frame.size.height
        ||pt.y<0)
    {
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        startPoint = pt;
        
        [self locatProcess:pt];

    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        [self getOffset:pt];
        
        [self directionJudgement:pt];
        
        [self locatProcess:pt];
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self getOffset:pt];
        
        [self finishAnimation:pt];
        
        //NSLog(@"End");
    }
    else if (sender.state == UIGestureRecognizerStateCancelled)
    {
        //NSLog(@"Cancell");
    }
    else if (sender.state == UIGestureRecognizerStateFailed)
    {
        //NSLog(@"Failed");
    }
}

-(void)getOffset:(CGPoint)endPt
{
    //只接受纵向输入且偏移量要大于最大长度的十五分之一
    if (abs(startPoint.x - endPt.x)>abs(startPoint.y - endPt.y)
        ||abs(startPoint.y - endPt.y)<SINGLE_LENGTH)
    {
        return ;
    }
    
    int offset = abs(startPoint.y - endPt.y)/SINGLE_LENGTH;
    
    //向上
    if ((startPoint.y - endPt.y) < 0)
    {
        NSLog(@"减小:%d",offset);
    }
    
    //向下
    if ((startPoint.y - endPt.y) > 0)
    {
        NSLog(@"增大:%d",offset);
    }
    
    startPoint = endPt;
}

-(void)finishAnimation:(CGPoint)endPt
{
    if (!finish)
    {
        return ;
    }
    else
    {
        finish = !finish;
    }
    
//    up = NO;
//    
//    //判断方向(向上或向下)
//    if ((startPoint.y - endPt.y)>0)
//    {
//        up = YES;
//    }
//    else
//    {
//        up = NO;
//    }
    
    if (up)
    {
        NSTimeInterval time = process.frame.origin.y/250;
        
        [UIView animateWithDuration:time animations:^{
            
            CGRect frame = process.frame;
            frame.origin.y = 0;
            [process setFrame:frame];
            
        } completion:^(BOOL finished) {
            
            process.alpha =0;
            finish = !finish;
        }];
    }
    else
    {
        NSTimeInterval time = (self.frame.size.height - process.frame.origin.y)/250;
        
        [UIView animateWithDuration:time animations:^{
            
            CGRect frame = process.frame;
            frame.origin.y = self.frame.size.height-2;
            [process setFrame:frame];
            
        } completion:^(BOOL finished) {
            
            process.alpha = 0;
            finish = !finish;
        }];
    }
}

-(void)directionJudgement:(CGPoint)endPt
{
    if (!finish)
    {
        return ;
    }
    
    //判断方向(向上或向下)
    if ((startPoint.y - endPt.y)>0)
    {
        up = YES;
        
        if (process.tag==tag_up)
        {
            return;
        }
        
        UIImage *image = [UIImage imageNamed:@"volume_up.png"];
        process.image = image;
        process.tag = tag_up;
    }
    else if ((startPoint.y - endPt.y)<0)
    {
        up = NO;
        
        if (process.tag==tag_down)
        {
            return;
        }
        
        UIImage *image = [UIImage imageNamed:@"volume_down.png"];
        process.image = image;
        process.tag = tag_down;
    }
}

-(void)locatProcess:(CGPoint)pt
{
    if (finish)
    {
        //显示光标
        process.alpha = 1;
        
        if (up)
        {
            //定位光标
            CGRect frame = process.frame;
            frame.origin.y = pt.y;
            [process setFrame:frame];
        }
        else
        {
            //定位光标
            CGRect frame = process.frame;
            frame.origin.y = pt.y - process.frame.size.height;
            [process setFrame:frame];
        }
    }
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
