//
//  TVListCell.h
//  VoiceRemoteControl
//
//  Created by 刘俊 on 14-7-14.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVListCell : UITableViewCell
{
    IBOutlet UILabel *TVName;
    IBOutlet UIImageView *seprateLine;
}

-(void)addTVInfo:(NSDictionary *)info;

@end
