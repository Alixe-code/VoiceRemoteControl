//
//  GestureController.m
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-15.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define isiPhone5 [UIScreen mainScreen].bounds.size.height>480

#import "GestureController.h"
#import "VolumeView.h"
#import "TouchPad.h"
#import "TouchPadBlock.h"

@interface GestureController ()
{
    TouchPadBlock *touchPad;
    //TouchPad *touchPad;
    VolumeView *volumeView;
    UIImageView *directionView;
    UIImageView *backImageView;
    
    NSString *testValue;
}

@end

@implementation GestureController

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
}

-(void)viewWillLayoutSubviews
{
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TouchPad.png"]];
//    CGRect frame = self.view.frame;
//    frame.size.height = self.view.window.bounds.size.height;
//    self.view.frame = frame;
//    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -3, 320, frame.size.height-220)];
//    imageView.image = [UIImage imageNamed:@"frame"];
//    [self.view addSubview:imageView];
    [self setBacImage];
    [self addDirectionAndInfo];
    [self addTouchPad];
    [self addVoiceView];
}

-(void)addGesture
{
    //左
    UISwipeGestureRecognizer *swipe_left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipe_left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe_left];
    
    //右
    UISwipeGestureRecognizer *swipe_right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipe_right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe_right];
    
    //上
    UISwipeGestureRecognizer *swipe_up = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipe_up.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipe_up];
    
    //下
    UISwipeGestureRecognizer *swipe_down = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipe_down.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe_down];
    
    //短按
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
    //长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 1.5;
    longPress.allowableMovement = 0;
    [self.view addGestureRecognizer:longPress];
}

-(void)swipe:(UISwipeGestureRecognizer *)sender
{
    switch (sender.direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            NSLog(@"左");
        }
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
        {
            NSLog(@"右");
        }
            break;
            
        case UISwipeGestureRecognizerDirectionUp:
        {
            NSLog(@"上");
        }
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
        {
            NSLog(@"下");
        }
            break;
            
        default:
            break;
    }
}

-(void)tap:(UITapGestureRecognizer *)sender
{
    NSLog(@"短按");
}

-(void)longPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"长按");
    }
}

#pragma mark SetView

-(void)setBacImage
{
    if (backImageView==nil)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TouchPad.png"]];
        CGRect frame = self.view.frame;
        frame.size.height = self.view.window.bounds.size.height;
        self.view.frame = frame;
        
        backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -3, 320, frame.size.height-220)];
        backImageView.image = [UIImage imageNamed:@"frame"];
        [self.view addSubview:backImageView];
    }
}

-(void)addDirectionAndInfo
{
    if (directionView==nil)
    {
        UIImage *image = [UIImage imageNamed:@"direction.png"];
        directionView = [[UIImageView alloc]initWithImage:image];
        if (isiPhone5)
        {
            directionView.frame = CGRectMake((self.view.frame.size.width - image.size.width)/2,
                                             108, image.size.width, image.size.height);
        }
        else
        {
            directionView.frame = CGRectMake((self.view.frame.size.width - image.size.width)/2,
                                             67, image.size.width, image.size.height);
        }
        
        [self.view addSubview:directionView];
        
        float width = 160;
        float height = 50;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 50)];
        if (isiPhone5)
        {
            label.frame = CGRectMake((self.view.frame.size.width - width)/2,
                                     37, width, height);
        }
        else
        {
            label.frame = CGRectMake((self.view.frame.size.width - width)/2,
                                     15, width, height);
        }
        label.textAlignment = 1;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.text = @"滑动控制方向及音量\n点击确认";
        label.textColor = [UIColor colorWithRed:(CGFloat)93/255 green:(CGFloat)103/255 blue:(CGFloat)113/255 alpha:1];
        [self.view addSubview:label];
    }
}

/*
-(void)addTouchPad
{
    if (touchPad==nil)
    {
        touchPad = [[TouchPad alloc]initWithFrame:CGRectMake(0, 0,
                                                             self.view.frame.size.width, self.view.frame.size.height)];
        touchPad.backgroundColor = [UIColor clearColor];
        touchPad.delegate = self;
        [self.view addSubview:touchPad];
    }
}
 */

-(void)addTouchPad
{
    if (touchPad==nil)
    {
        touchPad = [[TouchPadBlock alloc]initWithFrame:CGRectMake(0, 0,
                                                             self.view.frame.size.width,
                                                            self.view.frame.size.height)];
        touchPad.backgroundColor = [UIColor clearColor];
        
        GestureWithType getType = ^(GestureType type)
        {
            switch (type)
            {
                case Swipe_Left:
                {
                    NSLog(@"左");
                    
                    //testValue = @"Hello";
                }
                    break;
                    
                case Swipe_Right:
                {
                    NSLog(@"右");
                    
                    //NSLog(@"%@",testValue);
                }
                    break;
                    
                case Swipe_Up:
                {
                    NSLog(@"上");
                }
                    break;
                    
                case Swipe_Down:
                {
                    NSLog(@"下");
                }
                    break;
                    
                case Tap_Single:
                {
                    NSLog(@"单击");
                }
                    break;
                    
                case Long_Press:
                {
                    NSLog(@"长按");
                }
                    break;
                    
                case Long_Press_Will_Cancle:
                {
                    NSLog(@"上滑取消");
                }
                    break;
                    
                case Long_Press_Cancle:
                {
                    NSLog(@"取消");
                }
                    break;
                    
                case Long_Press_Continue:
                {
                    NSLog(@"继续录入");
                }
                    break;
                    
                case Long_Press_End:
                {
                    NSLog(@"长按结束");
                }
                    break;
                    
                default:
                    break;
            }
            
            //[self didRecognizeGestureWithType:type];
        };
        
        [touchPad loadCallBack:getType];
        
        
        [self.view addSubview:touchPad];
    }
}

-(void)addVoiceView
{
    if (volumeView==nil)
    {
        volumeView = [[VolumeView alloc]init];
        if (isiPhone5)
        {
            volumeView.frame = CGRectMake(self.view.frame.size.width-50,
                                          (self.view.frame.size.height-271)/2 - 100,
                                          Volume_width, Volume_height);
        }
        else
        {
            volumeView.frame = CGRectMake(self.view.frame.size.width-50,
                                          (self.view.frame.size.height-271)/2 - 80,
                                          Volume_width, Volume_height);
        }
        volumeView.alpha=1;
        [self.view addSubview:volumeView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TouchPadDelegate

-(void)didRecognizeGestureWithType:(GestureType)type
{
    switch (type)
    {
        case Swipe_Left:
        {
            NSLog(@"左");
        }
            break;
            
        case Swipe_Right:
        {
            NSLog(@"右");
        }
            break;
            
        case Swipe_Up:
        {
            NSLog(@"上");
        }
            break;
            
        case Swipe_Down:
        {
            NSLog(@"下");
        }
            break;
            
        case Tap_Single:
        {
            NSLog(@"单击");
        }
            break;
            
        case Long_Press:
        {
            NSLog(@"长按");
        }
            break;
            
        case Long_Press_Will_Cancle:
        {
            NSLog(@"上滑取消");
        }
            break;
            
        case Long_Press_Cancle:
        {
            NSLog(@"取消");
        }
            break;
            
        case Long_Press_Continue:
        {
            NSLog(@"继续录入");
        }
            break;
            
        case Long_Press_End:
        {
            NSLog(@"长按结束");
        }
            break;
            
        default:
            break;
    }
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
