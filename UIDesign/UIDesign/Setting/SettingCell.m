//
//  SettingCell.m
//  UIDesign
//
//  Created by 刘俊 on 14-7-31.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)addWidgtWithImage:(NSString *)imageName withTitle:(NSString *)text
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 6, 32, 32)];
    cellImage.image = image ;
    [self.contentView addSubview:cellImage];

    title.textAlignment = 0;
    title.textColor = [UIColor colorWithRed:(CGFloat)0 green:(CGFloat)168/255 blue:(CGFloat)255/255 alpha:1];
    title.text = text;
    //title.backgroundColor = [UIColor grayColor];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
}

-(void)addSwitch
{
    UISwitch *mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(150, (44-31)/2, 100, 31)];
    [self.contentView addSubview:mySwitch];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
