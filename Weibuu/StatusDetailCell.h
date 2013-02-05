//
//  StatusDetailCell.h
//  Weibuu
//
//  Created by zhang andy on 13-2-4.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
@interface StatusDetailCell : UITableViewCell<UIWebViewDelegate>
{
    CGFloat _webViewHeight;
    CGFloat _retweetWebViewHeight;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailPic;
@property (weak, nonatomic) IBOutlet UIImageView *retweetBlock;
@property (weak, nonatomic) IBOutlet UIImageView *retweetPic;
@property (weak, nonatomic) IBOutlet UIImageView *commentPic;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedPic;

@property (nonatomic,strong) UIWebView *tweetWebView;
@property (nonatomic,strong) UIWebView *retweetWebView;
@property (nonatomic,strong) Status *statusEntity;

- (CGFloat)hightForCellWithStatus:(Status *)status;
@end
