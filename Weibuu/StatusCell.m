//
//  StatusCell.m
//  Weibuu
//
//  Created by zhang andy on 13-1-23.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "StatusCell.h"
#import "AFNetworking.h"
@implementation StatusCell
@synthesize statusEntity  = _statusEntity;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)setStatusEntity:(Status *)statusEntity
{
    _statusEntity = statusEntity;
    self.name.text = statusEntity.user.name;
    self.retweetCount.text = [statusEntity.repostsCount stringValue];
    self.commentCount.text = [statusEntity.commentsCount stringValue];
    self.status.text = statusEntity.text;
    self.createdAt.text = statusEntity.createdAt;
    //self.source.text =statusEntity.source;
    
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@"<a .*>(.*)</a>" options:0 error:nil];
    NSArray *matches = [reg matchesInString:statusEntity.source options:0 range:NSMakeRange(0, [statusEntity.source length])];
    if ([matches count]>0) {
        NSTextCheckingResult *result = [matches objectAtIndex:0];
        if ([result numberOfRanges]==2) {
            NSRange r = [result rangeAtIndex:1];
            self.source.text =[[statusEntity source] substringWithRange:r];
            
        }
    }
    
    
    if ([statusEntity.user.verified isEqualToNumber:[NSNumber numberWithInt:0]]) {
        self.verifiedImage.image = nil;
    }else{
        self.verifiedImage.image = [UIImage imageNamed:@"avatar_vip.png"];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:statusEntity.user.profileImageUrl];
    //self.avatarImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    [self.avatarImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"loadingImage_50x118.png"]];
    
    self.name.textColor = [UIColor grayColor];
    self.status.textColor = [UIColor darkGrayColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
