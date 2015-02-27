//
//  BootController.m
//  UIDesign
//
//  Created by 刘俊 on 14-8-5.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "BootController.h"
#import "AppDelegate.h"

@interface BootController ()
{
    UIImageView *processView;
    UIImageView *rotateView;
    UIImageView *rotateView_new;
    float angleValue;
    NSTimer *processTimer;
    
    UIImageView *labelImage;
    
    UIImageView *view1;
    UIImageView *view2;
    UIImageView *view3;
    UIImageView *view4;
    
    BOOL start;
    BOOL finish;
}

@end

@implementation BootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    start = NO;
    finish = NO;
    
    [self startAniomation];
}

-(void)start
{
    NSLog(@"start");
    
    if (start)
    {
        for (UIView *view in self.view.subviews)
        {
            if (view.tag!=1000)
            {
                [view removeFromSuperview];
            }
        }
    }
    else
    {
        [self startAniomation];
    }
    
    start =! start;
}

-(void)startAniomation
{
    NSLog(@"startAniomation");
    
    //Title
    float height = 360 ;
    UIImage *image = [UIImage imageNamed:@"text"];
    labelImage = [[UIImageView alloc]initWithImage:image];
    labelImage.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    labelImage.center = CGPointMake( self.view.frame.size.width/2 , height);
    labelImage.alpha=0;
    [self.view addSubview:labelImage];
    
    //Logo
    UIImage *image1 = [UIImage imageNamed:@"p1"];
    UIImage *image2 = [UIImage imageNamed:@"p2"];
    UIImage *image3 = [UIImage imageNamed:@"p3"];
    UIImage *image4 = [UIImage imageNamed:@"p4"];
    UIImage *image5 = [UIImage imageNamed:@"p5"];
    UIImage *image6 = [UIImage imageNamed:@"p6"];
    UIImage *image7 = [UIImage imageNamed:@"p7"];
    
    CGPoint center = CGPointMake(160, 200);
    view1 = [[UIImageView alloc]initWithImage:image1];
    view1.frame = CGRectMake(0, 0, image1.size.width, image1.size.height);
    view1.center = center;
    view1.alpha=0;
    view1.transform = CGAffineTransformMakeScale(.2, .2);
    
    view2 = [[UIImageView alloc]initWithImage:image2];
    view2.frame = CGRectMake(0, 0, image2.size.width, image2.size.height);
    view2.center = center;
    view2.alpha=0;
    view2.transform = CGAffineTransformMakeScale(.4, .4);
    
    view3 = [[UIImageView alloc]initWithImage:image3];
    view3.frame = CGRectMake(0, 0, image3.size.width, image3.size.height);
    view3.center = center;
    view3.alpha=0;
    view3.transform = CGAffineTransformMakeScale(.5, .5);
    
    view4 = [[UIImageView alloc]initWithImage:image4];
    view4.frame = CGRectMake(0, 0, image4.size.width, image4.size.height);
    view4.center = center;
    view4.alpha=0;
    view4.transform = CGAffineTransformMakeScale(.6, .6);
    
    //processView
    [self addProcessView:image5 withCenter:center];
    
    rotateView = [[UIImageView alloc]initWithImage:image6];
    rotateView.frame = CGRectMake(0, 0, image6.size.width, image6.size.height);
    rotateView.center = center;
    rotateView.alpha=0;
    rotateView.transform = CGAffineTransformMakeRotation(- M_PI_2);
    
    rotateView_new = [[UIImageView alloc]initWithImage:image7];
    rotateView_new.frame = CGRectMake(0, 0, image7.size.width, image7.size.height);
    rotateView_new.center = center;
    rotateView_new.alpha=0;
    
    [self.view addSubview:rotateView_new];
    [self.view addSubview:rotateView];
    [self.view addSubview:view4];
    [self.view addSubview:view3];
    [self.view addSubview:processView];
    [self.view addSubview:view2];
    [self.view addSubview:view1];
    
    [self animationProcess];
    
    return ;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        view1.alpha=1;
        view1.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            view2.alpha=1;
            view2.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                view3.alpha=1;
                view3.transform = CGAffineTransformMakeScale(1, 1);
                
                processView.alpha=1;
                [self startProcess];
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    view4.alpha=1;
                    view4.transform = CGAffineTransformMakeScale(1, 1);
                    
                } completion:^(BOOL finished) {
                    
                    
                    
                    [self labelAppear];
                }];
                
            }];
            
        }];
        
    }];
}

-(void)animationDidFinish
{
    NSLog(@"animationDidFinish");
    
    [App controllerSwitch:self.view withAnimated:YES];
}

-(void)animationProcess
{
    NSLog(@"animationProcess");
    
    if (finish)
    {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        view1.alpha=1;
        view1.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
        if (finish)
        {
            return;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            view2.alpha=1;
            view2.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            if (finish)
            {
                return;
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                
                view3.alpha=1;
                view3.transform = CGAffineTransformMakeScale(1, 1);
                
                processView.alpha=1;
                [self startProcess];
                
            } completion:^(BOOL finished) {
                
                if (finish)
                {
                    return;
                }
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    view4.alpha=1;
                    view4.transform = CGAffineTransformMakeScale(1, 1);
                    
                } completion:^(BOOL finished) {
                    
                    if (finish)
                    {
                        return;
                    }
                    
                    [self labelAppear];
                }];
                
            }];
            
        }];
        
    }];
}

-(void)loadFinishCondition
{
    NSLog(@"loadFinishCondition");
    
    view1.alpha=1;
    view1.transform = CGAffineTransformMakeScale(1, 1);
    view2.alpha=1;
    view2.transform = CGAffineTransformMakeScale(1, 1);
    view3.alpha=1;
    view3.transform = CGAffineTransformMakeScale(1, 1);
    view4.alpha=1;
    view4.transform = CGAffineTransformMakeScale(1, 1);
    
    //上方圆点
    rotateView.transform = CGAffineTransformMakeRotation(0);
    rotateView.alpha=0;
    [rotateView removeFromSuperview];
    rotateView_new.alpha=1;
    
    //圆环
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(90, 90)
                                                         radius:55
                                                     startAngle:(M_PI * 270)/180
                                                       endAngle: - M_PI_2
                                                      clockwise:NO];
    
    aPath.lineCapStyle = kCGLineCapSquare;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapSquare; //终点处理
    maskLayer.path = aPath.CGPath;
    maskLayer.fillColor = nil;
    maskLayer.strokeColor =[UIColor greenColor].CGColor;
    maskLayer.lineCap = kCALineCapButt;
    maskLayer.lineWidth = 15;
    processView.layer.mask = nil;
    processView.layer.mask = maskLayer;
    
    //下方标签
    labelImage.alpha = 1;
}

#pragma mark processView

-(void)addProcessView:(UIImage *)image withCenter:(CGPoint)center
{
    NSLog(@"addProcessView");
    
    angleValue = 0 ;
    
    processView = [[UIImageView alloc]initWithImage:image];
    processView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    processView.center = center;
    processView.alpha=0;
    
    [self stokeLine];
}

-(void)startProcess
{
    NSLog(@"startProcess");
    
    processTimer = [NSTimer scheduledTimerWithTimeInterval:(float)1/80
                                     target:self
                                   selector:@selector(stokeLine)
                                   userInfo:nil repeats:YES];
}

-(void)stokeLine
{
    if (angleValue > 360||finish)
    {
        [processTimer invalidate];
        
        [self rotateView];
        
        return ;
    }
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(90, 90)
                                                         radius:55
                                                     startAngle:(M_PI * 270)/180
                                                       endAngle:(M_PI * 270)/180 - (M_PI * angleValue)/180
                                                      clockwise:NO];
    
    aPath.lineCapStyle = kCGLineCapSquare;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapSquare; //终点处理
    maskLayer.path = aPath.CGPath;
    maskLayer.fillColor = nil;
    maskLayer.strokeColor =[UIColor greenColor].CGColor;
    maskLayer.lineCap = kCALineCapButt;
    maskLayer.lineWidth = 15;
    processView.layer.mask = nil;
    processView.layer.mask = maskLayer;
    
    angleValue+=5;
}

#pragma mark RotateView

-(void)rotateView
{
    NSLog(@"rotateView");
    
    if (finish)
    {
        return;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        
        rotateView.alpha=1;
        rotateView.transform = CGAffineTransformMakeRotation(0);
        
    } completion:^(BOOL finished) {
        
        if (finish)
        {
            return;
        }
        [UIView animateWithDuration:0.4 animations:^{
            
            rotateView.alpha=0;
            rotateView_new.alpha=1;
            
        } completion:^(BOOL finished) {
            
            if (finish)
            {
                return;
            }
            [rotateView removeFromSuperview];
        
            finish = YES;
            [self performSelector:@selector(animationDidFinish) withObject:nil afterDelay:1];
        }];
        
    }];
}

-(void)labelAppear
{
    NSLog(@"rotateView");
    
    [UIView animateWithDuration:1.5 animations:^{
        
        labelImage.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //freshAnimation
    NSLog(@"touchesEnded");
    
    if (!finish)
    {
        NSLog(@"finish");
        finish = YES;
        [self loadFinishCondition];
        [self performSelector:@selector(animationDidFinish) withObject:nil afterDelay:0.2];
    }
    
    /*出错序列
     startAniomation
     addProcessView
     animationProcess
     startProcess
     rotateView
     rotateView
     animationDidFinish
     touchesEnded
     finish
     loadFinishCondition
     animationDidFinish
     */
    
    /*
     startAniomation
     addProcessView
     animationProcess
     startProcess
     rotateView
     rotateView
     animationDidFinish
    */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
