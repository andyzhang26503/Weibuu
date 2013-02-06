//
//  StatusDetailContentCell.h
//  Weibuu
//
//  Created by zhang andy on 13-2-6.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
@interface StatusDetailContentCell : UITableViewCell<UIWebViewDelegate>
{
    CGFloat _webViewHeight;
    CGFloat _retweetWebViewHeight;
    //int _currentRow;
}

@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailPic;
@property (weak, nonatomic) IBOutlet UIImageView *retweetBlock;

@property (nonatomic,strong) UIWebView *tweetWebView;
@property (nonatomic,strong) UIWebView *retweetWebView;
@property (nonatomic,strong) Status *statusEntity;

- (CGFloat)hightForCellWithStatus:(Status *)status;
@end
