//
//  MentionsViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeiboManager.h"
#import "Status.h"
@interface MentionsViewController : UITableViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate>


@property (nonatomic,strong) NSMutableArray *retweetStatus;
@end
