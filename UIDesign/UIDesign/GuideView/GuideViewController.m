//
//  GuideViewController.m
//  UIDesign
//
//  Created by 刘俊 on 14-8-5.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define isiPhone5 [UIScreen mainScreen].bounds.size.height>480

#import "GuideViewController.h"
#import "PageView.h"
#import "AppDelegate.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *guideScroll;
    PageView *pageView;
}

@end

@implementation GuideViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    [self addGuidePictures];
    
}

-(void)addGuidePictures
{
    CGRect guideFrame = CGRectZero;
    guideFrame.size.width = 320;
    if (isiPhone5)
    {
        guideFrame.size.height = 568;
    }
    else
    {
        guideFrame.size.height = 480;
    }
    
    guideScroll = [[UIScrollView alloc]initWithFrame:guideFrame];
    guideScroll.contentSize = CGSizeMake(guideFrame.size.width*3, guideFrame.size.height);
    guideScroll.pagingEnabled                   = YES;
    guideScroll.showsHorizontalScrollIndicator  = NO;
    guideScroll.showsVerticalScrollIndicator    = NO;
    guideScroll.delegate = self;
    [self.view addSubview:guideScroll];
    
    [self addGuideView1:guideFrame];
    [self addGuideView2:guideFrame];
    [self addGuideView3:guideFrame];
    
    [self addPageView];
}

-(void)addGuideView1:(CGRect)frame
{
    NSString *name;
    float height;
    float height1;
    float height2;
    if (isiPhone5)
    {
        name = @"bg1_l";
        
        height = 38;
        height1 = 61;
        height2 = 120;
    }
    else
    {
        name = @"bg1_l";
        
        height = 22;
        height1 = 51;
        height2 = 115;
    }
    UIImage *image = [UIImage imageNamed:name];
    
    if (image.size.height > frame.size.height)
    {
        CGRect newRect = CGRectMake(0, 0, frame.size.width*2, frame.size.height*2);
        image = [self getSubImage:newRect withImage:image];
    }
    
    UIImageView *view = [[UIImageView alloc]initWithImage:image];
    view.frame = CGRectMake(0, 0,
                            frame.size.width,
                            frame.size.height);
    [guideScroll addSubview:view];
    
    UIImage *title1 = [UIImage imageNamed:@"text1"];
    UIImageView *view1 = [[UIImageView alloc]initWithImage:title1];
    view1.frame = CGRectMake((self.view.frame.size.width - title1.size.width)/2,
                             height,
                             title1.size.width,
                             title1.size.height);
    [self.view addSubview:view1];
    
    UIImage *icon = [UIImage imageNamed:@"icon"];
    UIImageView *view2 = [[UIImageView alloc]initWithImage:icon];
    view2.frame = CGRectMake((self.view.frame.size.width - icon.size.width)/2,
                             view1.frame.origin.y + view1.frame.size.height + height1,
                             icon.size.width,
                             icon.size.height);
    [guideScroll addSubview:view2];
    
    UIImage *title2 = [UIImage imageNamed:@"text2"];
    UIImageView *view3 = [[UIImageView alloc]initWithImage:title2];
    view3.frame = CGRectMake((self.view.frame.size.width - title2.size.width)/2,
                             view2.frame.origin.y + view2.frame.size.height + height2,
                             title2.size.width,
                             title2.size.height);
    [guideScroll addSubview:view3];
}

-(void)addGuideView2:(CGRect)frame
{
    NSString *name;
    
    float height;
    float height1;
    float height2;
    if (isiPhone5)
    {
        name = @"bg2_l";
        
        height  = 38;
        height1 = 20;
        height2 = 40;
    }
    else
    {
        name = @"bg2_l";
        
        height  = 15;
        height1 = 10;
        height2 = 12;
    }
    
    UIImage *image = [UIImage imageNamed:name];
    
    if (image.size.height > frame.size.height)
    {
        CGRect newRect = CGRectMake(0, 30*2, frame.size.width*2, frame.size.height*2);
        image = [self getSubImage:newRect withImage:image];
    }
    
    UIImageView *view = [[UIImageView alloc]initWithImage:image];
    view.frame = CGRectMake(320, 0,
                            frame.size.width, frame.size.height);
    [guideScroll addSubview:view];
    
    UIImage *title1 = [UIImage imageNamed:@"text1"];
    UIImageView *view1 = [[UIImageView alloc]initWithImage:title1];
    view1.frame = CGRectMake((self.view.frame.size.width - title1.size.width)/2 + self.view.frame.size.width,
                             height,
                             title1.size.width,
                             title1.size.height);
    //[guideScroll addSubview:view1];
    
    UIImage *content = [UIImage imageNamed:@"guide_ct"];
    UIImageView *view2 = [[UIImageView alloc]initWithImage:content];
    view2.frame = CGRectMake((self.view.frame.size.width - content.size.width)/2 + self.view.frame.size.width,
                             view1.frame.origin.y + view1.frame.size.height + height1,
                             content.size.width,
                             content.size.height);
    [guideScroll addSubview:view2];
    
    UIImage *title2 = [UIImage imageNamed:@"text3"];
    UIImageView *view3 = [[UIImageView alloc]initWithImage:title2];
    view3.frame = CGRectMake((self.view.frame.size.width - title2.size.width)/2 + self.view.frame.size.width,
                             view2.frame.origin.y + view2.frame.size.height + height2,
                             title2.size.width,
                             title2.size.height);
    [guideScroll addSubview:view3];
}

-(void)addGuideView3:(CGRect)frame
{
    NSString *name;
    
    float height;
    float height1;
    float height2;
    if (isiPhone5)
    {
        name = @"bg3_l";
        
        height  = 38;
        height1 = 124;
        height2 = 180;
    }
    else
    {
        name = @"bg3_l";
        
        height  = 22;
        height1 = 124;
        height2 = 150;
    }
    UIImage *image = [UIImage imageNamed:name];
    
    if (image.size.height > frame.size.height)
    {
        CGRect newRect = CGRectMake(0, 0, frame.size.width*2, frame.size.height*2);
        image = [self getSubImage:newRect withImage:image];
    }
    
    UIImageView *view = [[UIImageView alloc]initWithImage:image];
    view.frame = CGRectMake(320*2, 0,
                            frame.size.width, frame.size.height);
    [guideScroll addSubview:view];
    
    UIImage *title1 = [UIImage imageNamed:@"text1"];
    UIImageView *view1 = [[UIImageView alloc]initWithImage:title1];
    view1.frame = CGRectMake((self.view.frame.size.width - title1.size.width)/2 + self.view.frame.size.width*2,
                             height,
                             title1.size.width,
                             title1.size.height);
    //[guideScroll addSubview:view1];
    
    UIImage *icon_n = [UIImage imageNamed:@"ex_n"];
    UIImage *icon_h = [UIImage imageNamed:@"ex_h"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon_n forState:UIControlStateNormal];
    [button setImage:icon_h forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake((self.view.frame.size.width - icon_n.size.width)/2 + self.view.frame.size.width*2,
                             view1.frame.origin.y + view1.frame.size.height + height1,
                             icon_n.size.width,
                             icon_n.size.height);
    [guideScroll addSubview:button];
    
    UIImage *title2 = [UIImage imageNamed:@"text4"];
    UIImageView *view3 = [[UIImageView alloc]initWithImage:title2];
    view3.frame = CGRectMake((self.view.frame.size.width - title2.size.width)/2 + self.view.frame.size.width*2,
                             button.frame.origin.y + button.frame.size.height + height2,
                             title2.size.width,
                             title2.size.height);
    [guideScroll addSubview:view3];
}

-(void)addPageView
{
    pageView = [[PageView alloc]initWithSuperView:self.view];
    [pageView setSelected:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)finish
{
    //标记应用为非第一次加载
    [self markGuideView];
    
    [App controllerSwitch:self.view withAnimated:YES];
}

-(UIImage*)getSubImage:(CGRect)rect withImage:(UIImage *)image
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / 320;
    
    [pageView setSelected:page];
}

#pragma mark -
#pragma mark 判断是否加载引导界面

//判断是否加载引导界面
+ (BOOL)firstLoadGuideView
{
    NSString *title=@"Condition";
    NSString *homePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *loadPath=[NSString stringWithFormat:@"%@/%@.plist",homePath,title];
    NSArray *array=[NSArray arrayWithContentsOfFile:loadPath];
    if (array!=nil&&[array count]!=0)
    {
        if ([[array objectAtIndex:0]isEqualToString:@"Loaded"])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

-(void)markGuideView
{
    NSArray *array=[[NSArray alloc]initWithObjects:@"Loaded", nil];
    NSString *title=@"Condition";
    NSString *homePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *landedInfoPath=[NSString stringWithFormat:@"%@/%@.plist",homePath,title];
    [array writeToFile:landedInfoPath atomically:YES];
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
