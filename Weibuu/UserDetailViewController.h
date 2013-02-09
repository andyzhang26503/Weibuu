//
//  UserDetailViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-2-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface UserDetailViewController : UITableViewController
{
    User *_userEntity;
}

- (id)initWithUserInfo:(User *)user;
@end
