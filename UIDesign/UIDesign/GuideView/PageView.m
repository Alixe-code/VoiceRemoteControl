//
//  PageView.m
//  UIDesign
//
//  Created by 刘俊 on 14-8-5.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define isiPhone5 [UIScreen mainScreen].bounds.size.height>480

#import "PageView.h"

@implementation PageView

-(id)initWithSuperView:(UIView *)view
{
    if (self = [super init])
    {
        superView = view;
        
        pageArray = [[NSMutableArray alloc]init];
        
        [self addPageView];
        
        //默认
        currentPage = -1;
        [self setSelected:0];
    }
    return self;
}

-(void)addPageView
{
    UIImage *image = [UIImage imageNamed:@"page_n"];
    float space = 20;
    float wholeLen = image.size.width*3 + space*2;
    
    for (int i = 0 ; i<3; i++)
    {
        UIImageView *view = [[UIImageView alloc]initWithImage:image];
        
        if (isiPhone5)
        {
            view.frame = CGRectMake((superView.frame.size.width - wholeLen)/2 + image.size.width*i + space*i,
                                    superView.frame.size.height - 30 - image.size.height,
                                    image.size.width,
                                    image.size.height);
        }
        else
        {
            view.frame = CGRectMake((superView.frame.size.width - wholeLen)/2 + image.size.width*i + space*i,
                                    superView.frame.size.height - 30 - image.size.height,
                                    image.size.width,
                                    image.size.height);
        }

        [superView addSubview:view];
        
        [pageArray addObject:view];
    }
}

-(void)setSelected:(NSInteger)page
{
    if (page>pageArray.count)
    {
        return ;
    }
    
    if (currentPage == page)
    {
        return ;
    }
    
    for (UIImageView *temp in pageArray)
    {
        [temp setImage:[UIImage imageNamed:@"page_n"]];
    }
    
    UIImageView *view = pageArray[page];
    [view setImage:[UIImage imageNamed:@"page_h"]];
    currentPage = page ;
}

@end
