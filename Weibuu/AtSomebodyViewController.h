//
//  AtSomebodyViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-2-24.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface AtSomebodyViewController : UITableViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property (nonatomic,strong)NSMutableArray *usersArray;
@property (nonatomic,strong)NSMutableArray *filteredUsersArray;
@property (nonatomic,weak)id viewController;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@end
