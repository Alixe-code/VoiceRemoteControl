//
//  MainViewController.m
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-11.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define isiPhone5 [UIScreen mainScreen].bounds.size.height>480

#define NOTICE_LABEL_WIDTH  130
#define NOTICE_LABEL_HEIGHT 16

#define TV_BTN 100
#define TV_LIST_BAC 101
#define DETAIL_BTN 102
#define SEARCH_BTN 103

#import "MainViewController.h"
#import "TVListViewController.h"
#import "GestureController.h"
#import "MicAndControl.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface MainViewController ()
{
    TVListViewController *tvList;//电视列表
    MicAndControl *micCtrl;//麦克风相关按钮
    UIView *helpView;//帮助界面
    UIButton *tvBtn;
    UILabel *noticeLabel;
    UIView *netActionView;//没有网络的时候弹出的提示界面
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

-(id)init
{
    if (self = [super init])
    {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGesture];
    [self addTvList];
    [self addMicView];
    
    [self addNetWorkView:NO];
    
    [self addSettingItem];
    
    [self showNoticeLabel:NoticeLabelNormal withAnimate:YES];
    
    [self loadNet_actionView:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    UIImage *naviImage=[UIImage imageNamed:@"navi.png"];
    UIImage *newImage = [naviImage resizableImageWithCapInsets:UIEdgeInsetsMake(-20, 0, 0, 0)];
    [self.navigationController.navigationBar setBackgroundImage:newImage
                                                  forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillLayoutSubviews
{
    
}

-(void)addSettingItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showSetting)];
    item.tintColor = [UIColor colorWithRed:(CGFloat)193/255 green:(CGFloat)193/255 blue:(CGFloat)193/255 alpha:1];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)showSetting
{
    [App loadRightView];
}

-(void)addNetWorkView:(BOOL)connect
{
    UIBarButtonItem *netWorkItem;
    if (!connect)
    {
        UIImageView *netWorkImage = [[UIImageView alloc]init];
        [netWorkImage setImage:[UIImage imageNamed:@"DisConnect"]];
        
        netWorkImage.frame = CGRectMake(0, 10, 39, 39);
        netWorkItem = [[UIBarButtonItem alloc]initWithCustomView:netWorkImage];
    }
    else
    {
        UIImageView *netWorkImage = [[UIImageView alloc]init];
        [netWorkImage setImage:[UIImage imageNamed:@"Connect"]];
        
        netWorkImage.frame = CGRectMake(0, 10, 39, 39);
        netWorkItem = [[UIBarButtonItem alloc]initWithCustomView:netWorkImage];
    }
    
    self.navigationItem.leftBarButtonItem = netWorkItem;
}

-(void)addTvList
{
    //NaviButton
    tvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tvBtn.frame = CGRectMake(0, 2, 150, 40);
    //tvBtn.backgroundColor = [UIColor greenColor];
    tvBtn.tag = TV_BTN;
    [tvBtn setTitle:@"未连接到电视" forState:UIControlStateNormal];
    [tvBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = tvBtn;
    
    //TVListBac
    tvListBac = [UIButton buttonWithType:UIButtonTypeCustom];
    tvListBac.frame = CGRectMake(0, 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    tvListBac.tag = TV_LIST_BAC;
    [tvListBac addTarget:self
                  action:@selector(buttonPressed:)
        forControlEvents:UIControlEventTouchUpInside];
    
    //TVListController
    tvList = [[TVListViewController alloc]initWithNibName:@"TVListViewController" bundle:nil];
    if (isiPhone5)
    {
        [tvList.view setFrame:CGRectMake((self.view.frame.size.width-220)/2,
                                         BASE_HEIGHT - (self.view.frame.size.height/2+100)+ 116,
                                         220,
                                         self.view.frame.size.height/2 + 2)];
    }
    else
    {
        [tvList.view setFrame:CGRectMake((self.view.frame.size.width-220)/2,
                                         BASE_HEIGHT - (self.view.frame.size.height/2+100)+ 88 + 68,
                                         220,
                                         self.view.frame.size.height/2 + 50)];
    }
    tvList.delegate = self;
    [self.view addSubview:tvList.view];
}

-(void)addGesture
{
    GestureController *gesture = [[GestureController alloc]init];
    CGRect frame = gesture.view.frame;
    //frame.origin.y = BASE_HEIGHT;
    [gesture.view setFrame:frame];
    [self.view addSubview:gesture.view];
    [self addChildViewController:gesture];
}

-(void)addMicView
{
    micCtrl = [[NSBundle mainBundle]loadNibNamed:@"MicAndControl"
                                                          owner:self
                                                        options:nil][0];
    if (isiPhone5)
    {
        micCtrl.frame = CGRectMake(0,
                                   self.view.frame.size.height - MICVIEW_LENGTH - 100,
                                   self.view.frame.size.width,
                                   MICVIEW_LENGTH + 100);
    }
    else
    {
        micCtrl.frame = CGRectMake(0,
                                   self.view.frame.size.height - MICVIEW_LENGTH-188,
                                   self.view.frame.size.width,
                                   MICVIEW_LENGTH+188);
    }
    
    [micCtrl initWidget];
    micCtrl.delegate = self;
    
    [self.view addSubview:micCtrl];
}

-(void)addHelpView
{
    if (helpView == nil)
    {
        CGRect wholeFrame = self.view.window.frame;
        helpView = [[UIView alloc]initWithFrame:wholeFrame];
        helpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"help_bac"]];
        helpView.alpha = 1;
        
        UIImage *image1 = [UIImage imageNamed:@"help1"];
        UIImage *image2 = [UIImage imageNamed:@"help2"];
        UIImage *image3 = [UIImage imageNamed:@"help3"];
        UIImage *image4 = [UIImage imageNamed:@"help4"];
        
        float view1_height = 85;
        float view2_height = 140;
        float view3_height = 160;
        float view4_height = 320;
        if (isiPhone5)
        {
            view1_height += 20;
            view2_height += 25;
            view3_height += 35;
            view4_height += 80;
        }
        
        UIImageView *helpView1 = [[UIImageView alloc]initWithImage:image1];
        helpView1.frame =CGRectMake((self.view.frame.size.width - image1.size.width)/2, view1_height,
                                    image1.size.width,
                                    image1.size.height);
        
        UIImageView *helpView2 = [[UIImageView alloc]initWithImage:image2];
        helpView2.frame =CGRectMake(self.view.frame.size.width - image2.size.width - 14, view2_height,
                                    image2.size.width,
                                    image2.size.height);
        
        UIImageView *helpView3 = [[UIImageView alloc]initWithImage:image3];
        helpView3.frame =CGRectMake((self.view.frame.size.width - image3.size.width)/2, view3_height,
                                    image3.size.width,
                                    image3.size.height);
        
        UIImageView *helpView4 = [[UIImageView alloc]initWithImage:image4];
        helpView4.frame =CGRectMake((self.view.frame.size.width - image4.size.width)/2 + 40, view4_height,
                                    image4.size.width,
                                    image4.size.height);
        
        [helpView addSubview:helpView1];
        [helpView addSubview:helpView2];
        [helpView addSubview:helpView3];
        [helpView addSubview:helpView4];
        
        UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        helpButton.frame = wholeFrame;
        [helpButton addTarget:self action:@selector(helpHandle) forControlEvents:UIControlEventTouchUpInside];
        [helpView addSubview:helpButton];
    }
    
    [self.view.window addSubview:helpView];
}

-(void)showNoticeLabel:(NoticeLabelAniType)type withAnimate:(BOOL)animate
{
    if (noticeLabel==nil)
    {
        CGRect frame;
        if (isiPhone5)
        {
            frame = CGRectMake((self.view.frame.size.width - NOTICE_LABEL_WIDTH)/2,
                               310,
                               NOTICE_LABEL_WIDTH,
                               NOTICE_LABEL_HEIGHT);
        }
        else
        {
            frame = CGRectMake((self.view.frame.size.width - NOTICE_LABEL_WIDTH)/2,
                               226,
                               NOTICE_LABEL_WIDTH,
                               NOTICE_LABEL_HEIGHT);
        }
        noticeLabel = [[UILabel alloc]initWithFrame:frame];
        noticeLabel.backgroundColor =[UIColor clearColor];
        noticeLabel.font = [UIFont systemFontOfSize:12];
        noticeLabel.textAlignment = 1;
        noticeLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:noticeLabel];
    }
    
    NSString *newTilte ;
    if (type == NoticeLabelNormal)
    {
        newTilte = @"按住语音键说话";
    }
    else if (type == NoticeLabelMusicCtl)
    {
        newTilte = @"按下切换至音乐控制";
    }
    else
    {
        newTilte = @"按下切换至语音";
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        noticeLabel.transform = CGAffineTransformMakeScale(0.38, 0.38);
        noticeLabel.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            noticeLabel.transform = CGAffineTransformMakeScale(1, 1);
            noticeLabel.alpha = 1;
            noticeLabel.text = newTilte;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)loadNet_actionView:(BOOL)load
{
    if (load)
    {
        if (netActionView==nil)
        {
            netActionView = [[UIView alloc]initWithFrame:CGRectMake( 8, 0, self.view.frame.size.width - 8*2, self.view.frame.size.height)];
            netActionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"help_bac"]];
            
            float baseHeight;
            UIImage *detailImage_n = [UIImage imageNamed:@"detail_n"];
            UIImage *detailImage_h = [UIImage imageNamed:@"detail_h"];
            UIImage *searchImage_n = [UIImage imageNamed:@"search_n"];
            UIImage *searchImage_h = [UIImage imageNamed:@"search_h"];
            
            if (isiPhone5)
            {
                baseHeight  = 60;
            }
            else
            {
                baseHeight  = 20;
            }
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((netActionView.frame.size.width - searchImage_n.size.width)/2,
                                                                      baseHeight,
                                                                      searchImage_n.size.width,
                                                                      searchImage_n.size.height+10)];
            label.text=@"未成功连接设备，\n请查看详情或者尝试重新扫描。";
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            label.textAlignment =1 ;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            [netActionView addSubview:label];
            
            UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            detailBtn.frame = CGRectMake((netActionView.frame.size.width - detailImage_n.size.width)/2,
                                         baseHeight + detailImage_n.size.height*2,
                                         detailImage_n.size.width,
                                         detailImage_n.size.height);
            [detailBtn setBackgroundImage:detailImage_n forState:UIControlStateNormal];
            [detailBtn setBackgroundImage:detailImage_h forState:UIControlStateHighlighted];
            [detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            detailBtn.tag = DETAIL_BTN;
            [detailBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *detailIconImage = [UIImage imageNamed:@"detail_icon"];
            UIImageView *detailIcon = [[UIImageView alloc]initWithImage:detailIconImage];
            detailIcon.frame = CGRectMake(30, (searchImage_n.size.height - detailIconImage.size.height)/2,
                                             detailIconImage.size.width,
                                             detailIconImage.size.height);
            [detailBtn addSubview:detailIcon];
            
            UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            searchBtn.frame = CGRectMake((netActionView.frame.size.width - searchImage_n.size.width)/2,
                                         baseHeight + detailImage_n.size.height*2 + searchImage_n.size.height*2,
                                         searchImage_n.size.width,
                                         searchImage_n.size.height);
            [searchBtn setBackgroundImage:searchImage_n forState:UIControlStateNormal];
            [searchBtn setBackgroundImage:searchImage_h forState:UIControlStateHighlighted];
            [searchBtn setTitle:@"重新搜索" forState:UIControlStateNormal];
            searchBtn.tag = SEARCH_BTN;
            [searchBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *searchIconImage = [UIImage imageNamed:@"search_icon"];
            UIImageView *iconView = [[UIImageView alloc]initWithImage:searchIconImage];
            iconView.frame = CGRectMake(30, (searchImage_n.size.height - searchIconImage.size.height)/2,
                                        searchIconImage.size.width,
                                        searchIconImage.size.height);
            [searchBtn addSubview:iconView];
            
            [netActionView addSubview:detailBtn];
            [netActionView addSubview:searchBtn];
        }
        [self.view insertSubview:netActionView belowSubview:micCtrl];
        tvBtn.userInteractionEnabled = NO;
    }
    else
    {
        [netActionView removeFromSuperview];
        tvBtn.userInteractionEnabled = YES;
    }
}

-(void)loadDetailView
{
    DetailViewController *detailView = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    detailView.delegate = self;
    [self presentViewController:detailView animated:YES completion:^{
        
    }];
}

#pragma mark - DetailViewDelegate

-(void)needTofreshList
{
    [self loadNet_actionView:NO];
    
    [tvList appearOrDisAppear];
}

#pragma mark - MicAndControlDelegate

-(void)modeDidSwitch:(NoticeLabelAniType)type
{
    [self showNoticeLabel:type withAnimate:YES];
}

-(void)didTouchedMusicButton:(MusicBtnType)type
{
    switch (type)
    {
        case MusicPlay:
        {
            NSLog(@"Play");
        }
            break;
            
        case MusicPause:
        {
            NSLog(@"Pause");
        }
            break;
            
        case MusicLast:
        {
            NSLog(@"Last");
        }
            break;
            
        case MusicNext:
        {
            NSLog(@"Next");
        }
            break;
            
        default:
            break;
    }
}

#pragma mark EventHandle

-(void)helpHandle
{
    [helpView removeFromSuperview];
}

-(void)buttonPressed:(UIButton *)sender
{
    switch (sender.tag)
    {
        case TV_BTN:
        {
            [self showTvList];
        }
            break;
            
        case TV_LIST_BAC:
        {
            [self showTvList];
        }
            break;
            
        case DETAIL_BTN:
        {
            [self loadDetailView];
        }
            break;
            
        case SEARCH_BTN:
        {
            NSLog(@"重新搜索");
            
            [self loadNet_actionView:NO];
        }
            break;
            
        default:
            break;
    }
}

-(void)showTvList
{
    [tvList appearOrDisAppear];
}

-(void)removeBacView
{
    [tvListBac removeFromSuperview];
}

-(void)playBtnPressed:(UIButton *)sender
{
    NSLog(@"---%d",sender.tag);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TVListDelegate

-(void)listDidApear:(BOOL)condition
{
    if (condition)
    {
        [self.view insertSubview:tvListBac belowSubview:tvList.view];
    }
    else
    {
        [tvListBac removeFromSuperview];
    }
}

#pragma mark 

- (void)didGetScanResult:(NSDictionary*)servInfo
{
    //[tvSerachCtrl didGetScanResult:servInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kDidGetScanResult" object:servInfo];
}

- (void)didGetScanFailed:(NSError *)error
{
    NSLog(@"didGetScanFailed");
}

@end
