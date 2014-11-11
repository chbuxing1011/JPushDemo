//
//  ALTableViewController.m
//  ALLibrary-iOS
//
//  Created by Allen on 14-10-16.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "ALViewController.h"
#import "BaseTableViewProtocol.h"
#import "AEFTableViewDataSource.h"
#import "AEFTableSectionCollection.h"
#import "ALTableViewCell.h"

@interface ALViewController ()
@property (nonatomic, strong) AEFTableViewDataSource *dataSource;

@end

@implementation ALViewController
@synthesize m_tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_tableview =
    [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                 style:UITableViewStyleGrouped];
    [self setupTableView];
    [self.view addSubview:self.m_tableview];
}

- (void)setupTableView {
    static NSString *cellidentifier = @"Cell";
    [self.m_tableview registerClass:[ALTableViewCell class]
             forCellReuseIdentifier:cellidentifier];
    
    NSArray *items = @[
                       @"Rows",
                       @"Rows & Sections",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows",
                       @"Rows"
                       ];
    AEFTableCollection *collection =
    [[AEFTableCollection alloc] initWithObjects:items cellIdentifier:@"Cell"];
    self.dataSource = [[AEFTableViewDataSource alloc]
                       initWithCollection:collection
                       configureCellBlock: ^(UITableViewCell *cell, id item,
                                             NSIndexPath *indexPath) {
                           cell.textLabel.text = item;
                       }];
    
    self.m_tableview.dataSource = self.dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView
 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView
 dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#>
 forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath
 *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath]
 withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array,
 and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath
 *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath
 *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
