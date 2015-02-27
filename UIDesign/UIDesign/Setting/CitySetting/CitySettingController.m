//
//  CitySettingController.m
//  UIDesign
//
//  Created by 刘俊 on 14-8-4.
//  Copyright (c) 2014年 yunzhisheng. All rights reserved.
//

#define isiPhone5 [UIScreen mainScreen].bounds.size.height>480

#import "CitySettingController.h"

@interface CitySettingController ()
{
    NSArray *cityArray;
    NSMutableArray *resultArray;
    
    IBOutlet UITableView *resultTable;
    IBOutlet UISearchBar *mySearchBar;
}

@end

@implementation CitySettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cityArray = [self getCityWords];
    
    resultArray = [[NSMutableArray  alloc]init];
    [resultArray addObject:@"hello"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_bg"]];
    resultTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //[self setTableFrame];
}

-(void)setTableFrame
{
    CGRect frame;
    if (isiPhone5)
    {
        frame = CGRectMake(0, 64, 320, 503);
    }
    else
    {
        frame = CGRectMake(0, 64, 320, 503);
    }
    
    [resultTable setFrame:frame];
}

-(NSArray *)getCityWords
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"txt"];
    NSString *cityStr = [NSString  stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return [cityStr componentsSeparatedByString:@"\n"];
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

- (BOOL)isIncludeChineseInString:(NSString*)str
{
    for (int i=0; i<str.length; i++)
    {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff)
        {
            return true;
        }
    }
    return false;
}

-(void)searchWords:(NSString *)word
{
    if (word.length==0)
    {
        cityArray = [self getCityWords];
        [resultTable reloadData];
    }
    else
    {
        if ([self isIncludeChineseInString:word])
        {

            [resultArray removeAllObjects];
            NSArray *allCity = [self getCityWords];
            for (NSString *oneCity in allCity)
            {
                NSRange range=[oneCity rangeOfString:word];
                if (range.length>0)
                {
                    [resultArray addObject:oneCity];
                }
            }
            
            cityArray = nil;
            cityArray = resultArray;
            
            [resultTable reloadData];
        }
    }
 }

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (cityArray.count!=0)
    {
        return cityArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        if (cityArray.count!=0)
        {
            NSString *cityName = cityArray[indexPath.row];
            cell.textLabel.text = cityName;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"UITableViewCell :%@",cell.textLabel.text);
}

#pragma mark UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    cityArray = [self getCityWords];
    searchBar.text = @"";
    [resultTable reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length>0)
    {
        searchBar.showsCancelButton = YES;
        //将取消按钮改成中文
        UIView *view = mySearchBar.subviews[0];
        NSArray *info = view.subviews;
        for(UIView *cc in info)
        {
            if([cc isKindOfClass:[UIButton class]])
            {
                UIButton *btn = (UIButton *)cc;
                [btn setTitle:@"取消"  forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        searchBar.showsCancelButton = NO;
    }
    [self searchWords:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length !=0)
    {
        [self searchWords:searchBar.text];
    }
    else
    {
        cityArray = [self getCityWords];
    }
    [resultTable reloadData];
    
    [mySearchBar resignFirstResponder];
}

@end
