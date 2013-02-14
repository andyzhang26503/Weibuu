//
//  UserDetailNameCell.h
//  Weibuu
//
//  Created by zhang andy on 13-2-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserDetailNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *unfollowButton;
@property (weak, nonatomic) id userDetailVC;
@property (strong, nonatomic) NSString *screenName;
- (IBAction)destroyFollow:(id)sender;

@end
