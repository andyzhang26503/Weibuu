//
//  AppDelegate.h
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo/SinaWeibo.h"
#import "MainPageViewController.h"
#import "MentionsViewController.h"
#import "FollowAndFansViewController.h"
#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "UserDetailViewController.h"

#define kAppKey             @"445238580"
#define kAppSecret          @"616a55ff175e3de0727bb93608d02f82"
#define kAppRedirectURI     @"http://www.sina.com"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) SinaWeibo *sinaweibo;
@end
