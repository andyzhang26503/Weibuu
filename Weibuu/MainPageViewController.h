//
//  MainPageViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "Status.h"
#import "SinaWeiboManager.h"
#import "StatusCell.h"
#import "PullRefreshTableViewController.h"
@interface MainPageViewController : PullRefreshTableViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    UIActivityIndicatorView *_activityIndicatorView;
}
@property (nonatomic,strong) NSMutableArray *statusesArray;
@end
