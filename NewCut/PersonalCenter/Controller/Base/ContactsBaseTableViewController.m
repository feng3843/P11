//
//  ContactsBaseTableViewController.m
//  
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import "ContactsBaseTableViewController.h"
#import "SettingGroup.h"
#import "SettingItem.h"
#import "SettingTableViewCell.h"
#import "SettingArrowItem.h"
#import "CMData.h"

#import "CMAPI.h"
#import "CMTool.h"
#import "PYAllCommon.h"

@interface ContactsBaseTableViewController ()


@end

@implementation ContactsBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (NSArray *)data
{
    if (_data == nil) {
        
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.data[section];
    
    return group.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingGroup *group = self.data[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    SettingTableViewCell *cell = [SettingTableViewCell initWithTableView:tableView];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  取消选中的这一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [CMAPI checkWeb:^{
        SettingGroup *group = self.data[indexPath.section];
        SettingItem *item = group.items[indexPath.row];
        if (item.option) {
            item.option();
        }else
        {
            if ([item isKindOfClass:[SettingArrowItem class]]) {
                SettingArrowItem *arrowItem = (SettingArrowItem *)item;
                if (arrowItem.destVcClass == nil)  return;
                UIViewController *vc = [[arrowItem.destVcClass alloc]init];
                vc.title = item.title;
                
                if (![[CMData getToken] isEqualToString:@""]) {
                    //            self.navigationController.navigationBarHidden = NO;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    self.navigationController.navigationBarHidden = NO;
                    
                    
                }else
                {
                    [self noLogin];
                }
                
            }
        }
    }];
}

@end
