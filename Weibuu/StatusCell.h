//
//  StatusCell.h
//  Weibuu
//
//  Created by zhang andy on 13-1-23.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "STTweetLabel.h"
@interface StatusCell : UITableViewCell<UIWebViewDelegate>
{
    CGFloat _webViewHeight;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *source;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailPic;

//@property (nonatomic,strong) STTweetLabel *statusSTLabel;
@property (nonatomic,strong) UIWebView *tweetWebView;

@property (nonatomic,strong) Status *statusEntity;
//@property (nonatomic,assign) CGFloat webViewHeight;
- (CGFloat)hightForCellWithStatus:(Status *)status;
@end
