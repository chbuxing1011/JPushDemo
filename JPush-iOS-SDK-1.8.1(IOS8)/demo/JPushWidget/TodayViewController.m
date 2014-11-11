//
//  TodayViewController.m
//  JPushWidget
//
//  Created by Allen on 14-11-6.
//
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *nd = [[NSUserDefaults alloc]
                          initWithSuiteName:@"group.com.allen.zhang.ios8.demo"];
    NSString *str = [nd objectForKey:@"ZHANGALLEN"];
    NSLog(@"str: %@", str);
    
    self.m_Lbl.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:
(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

@end
