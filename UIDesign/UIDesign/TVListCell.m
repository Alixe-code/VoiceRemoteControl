//
//  TVListCell.m
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-14.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "TVListCell.h"

@implementation TVListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected)
    {
        [self setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [self setAccessoryType:UITableViewCellAccessoryNone];
    }
}

-(void)addTVInfo:(NSDictionary *)info
{
    TVName.text = info[@"NAME"];
    self.backgroundColor = [UIColor clearColor];
}

@end
