//
//  FollowAndFansViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboManager.h"
#import "User.h"
@interface FollowAndFansViewController : UITableViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    UISegmentedControl *_segControl;
    int _segIndex;
}
@property (nonatomic,assign) int segIndex;
@property (nonatomic,strong) NSMutableArray *usersArray;
@property (nonatomic,strong) NSString *screenName;

@end
