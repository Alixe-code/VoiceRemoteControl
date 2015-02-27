//
//  SettingViewController.m
//  UIDesign
//
//  Created by 刘俊 on 14-7-30.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "HeaderView.h"
#import "SettingCell.h"
#import "CitySettingController.h"
#import "TVNameController.h"
#import "CheckUpdateController.h"

@interface SettingViewController ()
{
    TVNameController *tvName;
}

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
    self.tableView.scrollEnabled = NO;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
    self.tableView.tableFooterView = footerView;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sep"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    UIImage *naviImage=[UIImage imageNamed:@"navi.png"];
    UIImage *newImage = [naviImage resizableImageWithCapInsets:UIEdgeInsetsMake(-20, 0, 0, 0)];
    [self.navigationController.navigationBar setBackgroundImage:newImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    CGRect frame = self.tableView.frame;
    frame.origin.y +=20;
    self.tableView.frame = frame;
    self.tableView.superview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [App gestureEnable];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [App gestureDisable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)loadCitySetting
{
    CitySettingController *city = [[CitySettingController alloc]initWithNibName:@"CitySettingController" bundle:nil];
    //UINavigationController *cityNavi = [[UINavigationController alloc]initWithRootViewController:city];
    [self presentViewController:city animated:YES completion:^{
        
    }];
}

-(void)loadTVName
{
    TVNameController *tvNameCtl = [[TVNameController alloc]initWithNibName:@"TVNameController" bundle:nil];
    [self presentViewController:tvNameCtl animated:YES completion:^{
        
    }];
}

-(void)loadCheckUpdate:(NSDictionary *)dic
{
    CheckUpdateController *update = [[CheckUpdateController alloc]initWithNibName:@"CheckUpdateController" bundle:nil];
    [self presentViewController:update animated:YES completion:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView *header = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, HeaderHeight)];
    if (section==0)
    {
        [header addWidgtWithImage:@"phone" withTitle:@"手机设置"];
    }
    else
    {
        [header addWidgtWithImage:@"tv" withTitle:@"电视设置"];
    }
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 3;
    }
    else
    {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell;
    
    if (cell==nil)
    {
        cell =[[NSBundle mainBundle]loadNibNamed:@"SettingCell" owner:self options:nil][0];
    }
    
    NSString *image;
    NSString *title;
    if (indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                title = @"语音唤醒";
                image = @"wakeup";
                
                [cell addSwitch];
            }
                break;
                
            case 1:
            {
                title = @"帮助";
                image = @"help";
            }
                break;
                
            case 2:
            {
                title = @"手机版本更新";
                image = @"phone_update";
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
            {
                title = @"天气所在城市";
                image = @"weather";
            }
                break;
                
            case 1:
            {
                title = @"电视版本更新";
                image = @"tv_update";
            }
                break;
                
            case 2:
            {
                title = @"修改电视名";
                image = @"tv_name";
            }
                break;
                
            default:
                break;
        }
    }
    
    [cell addWidgtWithImage:image withTitle:title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                
            }
                break;
                
            case 1:
            {
                
            }
                break;
                
            case 2:
            {
                [self loadCheckUpdate:nil];
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [self loadCitySetting];
            }
                break;
                
            case 1:
            {
                [self loadCheckUpdate:nil];
            }
                break;
                
            case 2:
            {
                [self loadTVName];
            }
                break;
                
            default:
                break;
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
