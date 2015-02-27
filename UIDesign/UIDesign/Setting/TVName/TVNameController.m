//
//  TVNameController.m
//  UIDesign
//
//  Created by 刘俊 on 14-8-4.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "TVNameController.h"

@interface TVNameController ()

@end

@implementation TVNameController

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
    nameFie.backgroundColor = [UIColor clearColor];
    nameFie.borderStyle = UITextBorderStyleNone;
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
