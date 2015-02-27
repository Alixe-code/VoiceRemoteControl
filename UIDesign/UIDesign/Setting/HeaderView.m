//
//  HeaderView.m
//  UIDesign
//
//  Created by 刘俊 on 14-7-31.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)addWidgtWithImage:(NSString *)imageName withTitle:(NSString *)text
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(20,
                                 (self.frame.size.height - image.size.height)/2,
                                 image.size.width,
                                 image.size.height);
    [self addSubview:imageView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20+image.size.width+10,
                                                              (HeaderHeight - 30)/2,
                                                              150, 30)];
    title.textAlignment = 0;
    title.textColor = [UIColor colorWithRed:(CGFloat)0 green:(CGFloat)168/255 blue:(CGFloat)255/255 alpha:1];
    title.text = text;
    [self addSubview:title];
    
    UIImage *lineImage = [UIImage imageNamed:@"title_sep"];
    UIImageView *line = [[UIImageView alloc]initWithImage:lineImage];
    line.frame = CGRectMake( 0, self.frame.size.height-2, self.frame.size.width, 2);
    [self addSubview:line];
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
