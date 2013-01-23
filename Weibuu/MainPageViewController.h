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
@interface MainPageViewController : UITableViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate>

@property (nonatomic,strong) NSMutableArray *statusesArray;
@end
