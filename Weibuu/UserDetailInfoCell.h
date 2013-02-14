//
//  UserDetailInfoCell.h
//  Weibuu
//
//  Created by zhang andy on 13-2-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *fansButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UIButton *statusNoButton;
@property (weak, nonatomic) IBOutlet UIButton *topicButton;

@property (weak, nonatomic) id viewController;
@property (strong,nonatomic) NSString *screenName;
- (IBAction)fansButtonTap:(id)sender;
- (IBAction)followButtonTap:(id)sender;
- (IBAction)statusButtonTap:(id)sender;
- (IBAction)topicButtonTap:(id)sender;

@end
