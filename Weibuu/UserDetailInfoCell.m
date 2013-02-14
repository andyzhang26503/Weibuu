//
//  UserInfoCell.m
//  Weibuu
//
//  Created by zhang andy on 13-2-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "UserDetailInfoCell.h"

@implementation UserDetailInfoCell

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

- (IBAction)fansButtonTap:(id)sender {
    
    if([self.viewController respondsToSelector:@selector(fansButtonTap:)]){
        [self.viewController performSelector:@selector(fansButtonTap:) withObject:self.screenName];
    }
}

- (IBAction)followButtonTap:(id)sender {
    if([self.viewController respondsToSelector:@selector(followButtonTap:)]){
        [self.viewController performSelector:@selector(followButtonTap:) withObject:self.screenName];
    }
}

- (IBAction)statusButtonTap:(id)sender {
    if([self.viewController respondsToSelector:@selector(statusButtonTap:)]){
        [self.viewController performSelector:@selector(statusButtonTap:) withObject:self.screenName];
    }
}

- (IBAction)topicButtonTap:(id)sender {
    if([self.viewController respondsToSelector:@selector(topicButtonTap:)]){
        [self.viewController performSelector:@selector(topicButtonTap:) withObject:self.screenName];
    }
}
@end
