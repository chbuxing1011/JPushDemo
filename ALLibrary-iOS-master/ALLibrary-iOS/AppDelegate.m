//
//  AppDelegate.m
//  RTLibrary-ios
//
//  Created by Ryan on 14-7-2.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "AppDelegate.h"
#import "AppUtils.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialTencentWeiboHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialRenrenHandler.h"
#import "UMSocialQQHandler.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]
    //    bounds]];
    //    // Override point for customization after application launch.
    //    self.window.backgroundColor = [UIColor whiteColor];
    //    [self.window makeKeyAndVisible];
    
    [Crittercism enableWithAppID:[AppUtils getcrittercismKey] andDelegate:nil];
    //
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig
     setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f"
                            appSecret:@"db426a9829e4b49a0dcac7b4162da6b6"
                                  url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler
     openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //打开腾讯微博SSO开关，设置回调地址
    [UMSocialTencentWeiboHandler
     openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    
    //打开人人网SSO开关
    [UMSocialRenrenHandler openSSO];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468"
                               appKey:@"c7394704798a158208a74ab60104f0ba"
                                  url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    //
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state;
    // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the
    // application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}

@end
