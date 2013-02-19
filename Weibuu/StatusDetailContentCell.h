//
//  StatusDetailContentCell.h
//  Weibuu
//
//  Created by zhang andy on 13-2-6.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "STTweetLabel.h"
typedef enum {
    CellNotClick,
    CellSpecialClick,
    CellNormalClick
}CellClickStatus;


@interface StatusDetailContentCell : UITableViewCell<STLinkProtocol>
{
    CGFloat _tweetLabelHeight;
    CGFloat _retweetLabelHeight;
    CellClickStatus _cellClickStatus;
}

@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailPic;
@property (weak, nonatomic) IBOutlet UIImageView *retweetBlock;
@property (weak, nonatomic) IBOutlet UILabel *source;

@property (nonatomic, strong) STTweetLabel *tweetLabel;
@property (nonatomic, strong) STTweetLabel *retweetLabel;

@property (nonatomic,strong) Status *statusEntity;
@property (nonatomic,weak) id viewController;
@property (nonatomic,assign) CellClickStatus cellClickStatus;
- (CGFloat)hightForCellWithStatus:(Status *)status;
@end
