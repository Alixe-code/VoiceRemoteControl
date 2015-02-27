//
//  SettingCell.h
//  UIDesign
//
//  Created by 刘俊 on 14-7-31.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define CellHeight 44

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
{
    IBOutlet UILabel *title;
}

-(void)addWidgtWithImage:(NSString *)imageName withTitle:(NSString *)text;
-(void)addSwitch;

@end
