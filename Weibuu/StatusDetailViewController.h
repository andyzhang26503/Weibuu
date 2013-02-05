//
//  StatusDetailViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-2-4.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
@interface StatusDetailViewController : UITableViewController

{
    Status *_statusEntity;
}

- (id)initWithStatusMain:(Status *)status;
@end
