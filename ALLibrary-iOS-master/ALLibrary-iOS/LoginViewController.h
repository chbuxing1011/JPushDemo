//
//  LoginViewController.h
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseViewController.h"
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"
#import "KuaiDi.h"
#import "ALViewController.h"
@interface LoginViewController
: BaseViewController <UIActionSheetDelegate, UMSocialUIDelegate,
UMSocialShakeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *m_versionLbl;
@property (weak, nonatomic) IBOutlet UITextField *m_appkey;
@property (weak, nonatomic) IBOutlet UITextField *m_mastersecret;
@property (weak, nonatomic) IBOutlet UITextField *m_alert;
@property (weak, nonatomic) IBOutlet UITextField *m_category;
@property (weak, nonatomic) IBOutlet UITextField *m_badge;
@property (weak, nonatomic) IBOutlet UISwitch *m_sound;
@property (weak, nonatomic) IBOutlet UISwitch *m_contentavailable;

@end
