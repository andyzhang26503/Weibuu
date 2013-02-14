//
//  UserDetailNameCell.m
//  Weibuu
//
//  Created by zhang andy on 13-2-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "UserDetailNameCell.h"

@implementation UserDetailNameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)destroyFollow:(id)sender {
    if([self.userDetailVC respondsToSelector:@selector(unfollowUser:)]){
        [self.userDetailVC performSelector:@selector(unfollowUser:) withObject:self.screenName];
        
        [self.unfollowButton setTitle:@"关注" forState:UIControlStateNormal];
    }

}
@end
