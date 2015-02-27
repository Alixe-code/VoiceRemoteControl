//
//  DetailViewController.m
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-8-14.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define isiPhone5 [UIScreen mainScreen].bounds.size.height>480

#import "DetailViewController.h"

@interface DetailViewController ()
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *searchBtn;
    IBOutlet UIImageView *searIconView;
}

@end

@implementation DetailViewController

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
    titleLabel.textColor = [UIColor colorWithRed:(CGFloat)103/255 green:(CGFloat)182/255 blue:(CGFloat)96/255 alpha:1];
    
    CGRect btnFrame = searchBtn.frame;
    CGRect iconFrame = searIconView.frame;
    if (isiPhone5)
    {
        btnFrame.origin.y = 400;
        iconFrame.origin.y = 407;
    }
    else
    {
        btnFrame.origin.y = 360;
        iconFrame.origin.y = 367;
    }
    searchBtn.frame = btnFrame;
    searIconView.frame = iconFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)disAppear
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(IBAction)reSearch:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(needTofreshList)])
    {
        [self.delegate needTofreshList];
    }
    
    [self disAppear];
}

@end
