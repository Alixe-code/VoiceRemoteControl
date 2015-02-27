//
//  CheckUpdateController.m
//  UIDesign
//
//  Created by 刘俊 on 14-8-1.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "CheckUpdateController.h"

@interface CheckUpdateController ()

@end

@implementation CheckUpdateController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    
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

@end
