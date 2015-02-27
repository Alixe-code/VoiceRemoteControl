//
//  PageView.h
//  UIDesign
//
//  Created by 刘俊 on 14-8-5.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PageView : NSObject
{
    UIView *superView;
    NSMutableArray *pageArray;
    NSInteger currentPage;
}

-(id)initWithSuperView:(UIView *)view;
-(void)setSelected:(NSInteger)page;

@end
