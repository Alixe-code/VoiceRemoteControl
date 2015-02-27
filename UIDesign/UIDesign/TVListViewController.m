//
//  TVListViewController.m
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-14.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define isiPhone5 [UIScreen mainScreen].bounds.size.height>480

#import "TVListViewController.h"
#import "TVListCell.h"

@interface TVListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tvArray;
}

@end

@implementation TVListViewController

@synthesize appear;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景图片
    [self addBackImage];
    
    tvArray = [[NSMutableArray alloc]init];
    for (int i=0; i<8; i++)
    {
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:@"乐视TV", @"name", nil];
        [tvArray addObject:info];
    }
    self.appear=NO;
}

-(void)addBackImage
{
    CGRect frame;
    if (isiPhone5)
    {
        frame = CGRectMake(0, 0, 220, 183);
    }
    else
    {
        frame = CGRectMake(0, 0, 220, 143);
    }
    
    UIView *bacView = [[UIImageView alloc]initWithFrame:frame];
    bacView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listBac"]];
    [self.view insertSubview:bacView atIndex:0];
}

-(void)viewWillLayoutSubviews
{
    /*
    //设置TableView frame
    CGRect frame = tvListTable.frame;
    frame.origin.x= 3;
    frame.origin.y= 0;
    frame.size.width = self.view.frame.size.width - 3*2;
    height_hidden = self.view.frame.size.height - FRESH_BUTTON_SPACE - FRESH_BUTTON_HEIGHT/2 - TV_BUTTON_HEIGHT;
    
    frame.size.height = height_hidden;
    [tvListTable setFrame:frame];
    tvListTable.backgroundColor = [UIColor clearColor];
    tvListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置标题
    [self addHeaderView];
    
    //设置Button frame
    [self setAppearBtnFrame];
     */
     
     
     //设置TableView frame
     CGRect frame = tvListTable.frame;
     frame.origin.x= 20;
     frame.origin.y= 0;
     frame.size.width = self.view.frame.size.width - 20*2;
     height_hidden = self.view.frame.size.height - FRESH_BUTTON_SPACE - FRESH_BUTTON_HEIGHT/2 - TV_BUTTON_HEIGHT;
     
     frame.size.height = height_hidden;
     [tvListTable setFrame:frame];
     tvListTable.backgroundColor = [UIColor clearColor];
     tvListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
     
     //设置标题
     [self addHeaderView];
     
     //设置Button frame
     [self setAppearBtnFrame];
}

-(void)addHeaderView
{
    if (tvListTable.tableHeaderView == nil)
    {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tvListTable.frame.size.width, 30)];
        UILabel *headerLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, header.frame.size.width, 20)];
        headerLable.text=@"电视列表";
        headerLable.textColor = [UIColor colorWithRed:(CGFloat)0/255 green:(CGFloat)228/255 blue:(CGFloat)255/255 alpha:1];
        headerLable.textAlignment=1;
        [header addSubview:headerLable];
        
        UIImage *lineImage = [UIImage imageNamed:@"separatorLine1"];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        UIImageView *line = [[UIImageView alloc]initWithImage:[lineImage resizableImageWithCapInsets:insets]];
        line.frame = CGRectMake(0,
                                header.frame.size.height - line.frame.size.height,
                                header.frame.size.width,
                                line.frame.size.height);
        [header addSubview:line];
        
        tvListTable.tableHeaderView = header;
    }
}

/*
-(void)setAppearBtnFrame
{
    //刷新按钮和等待控件
    CGRect freshFrame = CGRectMake((self.view.frame.size.width - tvListTable.frame.size.width)/2,
                              tvListTable.frame.size.height,
                              tvListTable.frame.size.width,
                              FRESH_BUTTON_HEIGHT);
    freshBtn.frame = freshFrame;
    freshBtn.backgroundColor = [UIColor greenColor];

    //显示或消失的按钮
    CGRect frame = CGRectMake(0,
                              tvListTable.frame.size.height+FRESH_BUTTON_HEIGHT,
                              self.view.frame.size.width,
                              TV_BUTTON_HEIGHT);
    TVBtn.frame = frame;
    TVBtn.superview.backgroundColor = [UIColor clearColor];
}
*/

-(void)setAppearBtnFrame
{
    //刷新按钮和等待控件
    CGRect freshFrame = CGRectMake((self.view.frame.size.width - FRESH_BUTTON_WIDTH)/2,
                                   tvListTable.frame.size.height + FRESH_BUTTON_SPACE,
                                   FRESH_BUTTON_WIDTH,
                                   FRESH_BUTTON_HEIGHT);
    freshBtn.frame = freshFrame;
    [freshBtn setBackgroundImage:[UIImage imageNamed:@"greenBtn_n"] forState:UIControlStateNormal];
    [freshBtn setBackgroundImage:[UIImage imageNamed:@"greenBtn_h"] forState:UIControlStateHighlighted];
    [freshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    freshBtn.titleLabel.textAlignment =1;
    freshBtn.backgroundColor = [UIColor clearColor];
    
    
    //显示或消失的按钮
    CGRect frame = CGRectMake(0,
                              tvListTable.frame.size.height + FRESH_BUTTON_SPACE*2 + FRESH_BUTTON_HEIGHT/2,
                              self.view.frame.size.width,
                              TV_BUTTON_HEIGHT);
    TVBtn.frame = frame;
    TVBtn.superview.backgroundColor = [UIColor clearColor];
    TVBtn.adjustsImageWhenHighlighted = NO;
}

-(IBAction)appearOrDisAppear
{
    if (appear)
    {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0 - self.view.frame.size.height + TV_BUTTON_HEIGHT/2 - 4;
            [self.view setFrame:frame];
            
        } completion:^(BOOL finished)
        {
            [TVBtn setImage:[UIImage imageNamed:@"pull"] forState:UIControlStateNormal];
            appear=!appear;
            if ([self.delegate respondsToSelector:@selector(listDidApear:)])
            {
                [self.delegate listDidApear:appear];
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect frame = self.view.frame;
            //frame.origin.y = BASE_HEIGHT;
            frame.origin.y = 0;
            [self.view setFrame:frame];
            
        } completion:^(BOOL finished)
        {
            [TVBtn setImage:[UIImage imageNamed:@"drag"] forState:UIControlStateNormal];
            appear=!appear;
            if ([self.delegate respondsToSelector:@selector(listDidApear:)])
            {
                [self.delegate listDidApear:appear];
            }
        }];
    }
}

-(void)loadTvList:(BOOL)condition
{
    if (condition)
    {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = 0 - self.view.frame.size.height + TV_BUTTON_HEIGHT/2 - 4;
            [self.view setFrame:frame];
            
        } completion:^(BOOL finished)
         {
             [TVBtn setImage:[UIImage imageNamed:@"pull"] forState:UIControlStateNormal];
             appear = YES;
             
             if ([self.delegate respondsToSelector:@selector(listDidApear:)])
             {
                 [self.delegate listDidApear:appear];
             }
         }];
    }
    else
    {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect frame = self.view.frame;
            //frame.origin.y = BASE_HEIGHT;
            frame.origin.y = 0;
            [self.view setFrame:frame];
            
        } completion:^(BOOL finished)
         {
             [TVBtn setImage:[UIImage imageNamed:@"drag"] forState:UIControlStateNormal];
             appear = NO;
             if ([self.delegate respondsToSelector:@selector(listDidApear:)])
             {
                 [self.delegate listDidApear:appear];
             }
         }];
    }
}

-(IBAction)freshTvList
{
    NSLog(@"BBB");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tvArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVListCell *cell;
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TVListCell" owner:self options:nil][0];
        
        if (tvArray!=nil&&[tvArray count]!=0)
        {
            NSDictionary *info = tvArray[indexPath.row];
            [cell addTVInfo:info];
        }
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
