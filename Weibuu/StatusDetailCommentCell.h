//
//  StatusDetailCommentCell.h
//  Weibuu
//
//  Created by zhang andy on 13-2-6.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "AFNetworking.h"
@interface StatusDetailCommentCell : UITableViewCell<UIWebViewDelegate>
{
    CGFloat _webViewHeight;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *createAt;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedImage;

@property (nonatomic,strong) Comment *commentEntity;
@property (nonatomic,strong) UIWebView *commentWebView;


- (CGFloat)heightForCellWithComment:(Comment *)comment;

@end
