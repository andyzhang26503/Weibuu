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
#import <QuartzCore/QuartzCore.h>
#import "SORelativeDateTransformer.h"
#import "STTweetLabel.h"

typedef enum {
    CellNotClick,
    CellSpecialClick,
    CellNormalClick
}CellClickStatus;

@interface StatusCell : UITableViewCell<STLinkProtocol>
{
    CGFloat _tweetLabelHeight;
    CGFloat _retweetLabelHeight;
    CellClickStatus _cellClickStatus;
    
    BOOL __block jumpOutFlag;
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
@property (weak, nonatomic) IBOutlet UIImageView *retweetBlock;

//@property (nonatomic,strong) STTweetLabel *statusSTLabel;
//@property (nonatomic,strong) UIWebView *tweetWebView;
//@property (nonatomic,strong) UIWebView *retweetWebView;

@property (nonatomic, strong) STTweetLabel *tweetLabel;
@property (nonatomic, strong) STTweetLabel *retweetLabel;
@property (nonatomic,strong) Status *statusEntity;

@property (nonatomic,weak) id viewController;
//@property (nonatomic,strong) NSIndexPath *curIndexPath;
@property (nonatomic,assign) CellClickStatus cellClickStatus;

- (CGFloat)hightForCellWithStatus:(Status *)status;
@end
