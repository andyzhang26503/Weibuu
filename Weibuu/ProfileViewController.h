//
//  ProfileViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeiboManager.h"
#import "SinaWeibo.h"
#import "User.h"
@interface ProfileViewController : UITableViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate>

@property (nonatomic,strong) User *userEntity;
@property (nonatomic,strong) NSString *screenName;
//- (id)initWithUserInfo:(User *)user;
@end
