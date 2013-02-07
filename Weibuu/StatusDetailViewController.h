//
//  StatusDetailViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-2-4.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "SinaWeibo.h"
#import "Comment.h"

@interface StatusDetailViewController : UITableViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate>

{
    Status *_statusEntity;
    NSMutableArray *_commentsArray;
}

- (id)initWithStatusMain:(Status *)status;
@end
