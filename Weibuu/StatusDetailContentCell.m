//
//  StatusDetailContentCell.m
//  Weibuu
//
//  Created by zhang andy on 13-2-6.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "StatusDetailContentCell.h"
#import "AFNetworking.h"
#import "HtmlString.h"
#import "SORelativeDateTransformer.h"
#define thumbnailPicHeight 122.0f

@implementation StatusDetailContentCell
@synthesize statusEntity  = _statusEntity;
static NSDateFormatter *formatter;
static UITapGestureRecognizer *tap;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}


- (STTweetLabel *)tweetLabel
{
    if (!_tweetLabel) {
        _tweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(20.0, 27.0, 280.0, 80.0)];
        [_tweetLabel setFont:[UIFont fontWithName:@"helvetica" size:12]];
        [_tweetLabel setTextColor:[UIColor blackColor]];
        
        STLinkCallbackBlock callBackBlock = ^(STLinkActionType actionType, NSString *link) {
            
            NSString *displayString = NULL;
            
            switch (actionType) {
                    
                case STLinkActionTypeAccount:
                    self.cellClickStatus = CellSpecialClick;
                    displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
                    if ([self.viewController respondsToSelector:@selector(goToUserDetailVC:)]) {
                        [self.viewController performSelector:@selector(goToUserDetailVC:) withObject:[link substringFromIndex:1]];
                    }                    
                    break;
                case STLinkActionTypeHashtag:
                    self.cellClickStatus = CellSpecialClick;
                    displayString = [NSString stringWithFormat:@"Twitter hashtag:\n%@", link];
                    break;
                    
                case STLinkActionTypeWebsite:
                    self.cellClickStatus = CellSpecialClick;
                    displayString = [NSString stringWithFormat:@"Website:\n%@", link];
                    break;
                case STLinkActionTypeNothing:
                    self.cellClickStatus = CellNormalClick;
                    displayString = @"Nothing";
                    break;
            }
            NSLog(@"tap==%@",displayString);
        };
        
        [_tweetLabel setCallbackBlock:callBackBlock];
    }
    
    [self.contentView addSubview:_tweetLabel];
    return _tweetLabel;
}

- (STTweetLabel *)retweetLabel
{
    if (!_retweetLabel) {
        _retweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(57.0f, 89.0f, 280.0f, 50.0f)];
        [_retweetLabel setFont:[UIFont fontWithName:@"helvetica" size:12]];
        [_retweetLabel setTextColor:[UIColor blackColor]];
        
        STLinkCallbackBlock callBackBlock = ^(STLinkActionType actionType, NSString *link) {
            
            NSString *displayString = NULL;
            
            switch (actionType) {
                case STLinkActionTypeAccount:
                    self.cellClickStatus = CellSpecialClick;
                    displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
                    if ([self.viewController respondsToSelector:@selector(goToUserDetailVC:)]) {
                        [self.viewController performSelector:@selector(goToUserDetailVC:) withObject:[link substringFromIndex:1]];
                    }
                    break;
                case STLinkActionTypeHashtag:
                    self.cellClickStatus = CellSpecialClick;
                    displayString = [NSString stringWithFormat:@"Twitter hashtag:\n%@", link];
                    break;
                    
                case STLinkActionTypeWebsite:
                    self.cellClickStatus = CellSpecialClick;
                    displayString = [NSString stringWithFormat:@"Website:\n%@", link];
                    break;
                case STLinkActionTypeNothing:
                    self.cellClickStatus = CellNormalClick;
                    displayString = @"Nothing";
                    break;
            }
            NSLog(@"tap==%@",displayString);
        };
        
        [_retweetLabel setCallbackBlock:callBackBlock];
    }
    
    [self.contentView addSubview:_retweetLabel];
    return _retweetLabel;
}


- (void)setStatusEntity:(Status *)statusEntity
{
    _statusEntity = statusEntity;
    
    //self.name.text = statusEntity.user.name;
    self.retweetCount.text = [statusEntity.repostsCount stringValue];
    self.commentCount.text = [statusEntity.commentsCount stringValue];

    [[self tweetLabel] setText:statusEntity.text];
    if (!formatter) {
        formatter=[[NSDateFormatter alloc] init];
    }    
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *date=[formatter dateFromString:statusEntity.createdAt];
    
    SORelativeDateTransformer *relativeTrans = [[SORelativeDateTransformer alloc] init];
    NSString *relativeDate = [relativeTrans transformedValue:date];
    
    //resultFormatter=[[NSDateFormatter alloc] init];
    //resultFormatter.dateFormat = @"MM-dd HH:mm";
    //self.createdAt.text = [resultFormatter stringFromDate:date];
    self.createdAt.text = relativeDate;
    
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@"<a .*>(.*)</a>" options:0 error:nil];
    NSArray *matches = [reg matchesInString:statusEntity.source options:0 range:NSMakeRange(0, [statusEntity.source length])];
    if ([matches count]>0) {
        NSTextCheckingResult *result = [matches objectAtIndex:0];
        if ([result numberOfRanges]==2) {
            NSRange r = [result rangeAtIndex:1];
            self.source.text =[NSString stringWithFormat:@" 来自:%@",[[statusEntity source] substringWithRange:r]];
            
        }
    }
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPic)];
    [self.thumbnailPic addGestureRecognizer:tap];
    self.thumbnailPic.userInteractionEnabled = YES;
    
    if (statusEntity.thumbnailPic) {
        NSURL *thumbnailPicUrl = [NSURL URLWithString:statusEntity.thumbnailPic];
        [self.thumbnailPic setImageWithURL:thumbnailPicUrl placeholderImage:[UIImage imageNamed:@"loadingImage_50x118.png"]];
        _oringPic = [NSURL URLWithString:statusEntity.bmiddlePic];
    }else{
        
    }
    
    if (statusEntity.origStatus.text) {
        
        UIEdgeInsets edge = UIEdgeInsetsMake(10, 40, 10, 20);
        self.retweetBlock.image = [[UIImage imageNamed:@"timeline_rt_border.png"] resizableImageWithCapInsets:edge];
        
        self.retweetLabel.hidden = NO;
        self.retweetBlock.hidden = NO;
        [self.retweetLabel setText:statusEntity.origStatus.nameAndText];
        
        if (statusEntity.origStatus.thumbnailPic) {
            NSURL *thumbnailPicUrl = [NSURL URLWithString:statusEntity.origStatus.thumbnailPic];
            [self.thumbnailPic setImageWithURL:thumbnailPicUrl placeholderImage:[UIImage imageNamed:@"loadingImage_50x118.png"]];
            _oringPic = [NSURL URLWithString:statusEntity.origStatus.bmiddlePic];
        }else{
            self.thumbnailPic.image=nil;
        }
    }else{
        self.retweetBlock.hidden = YES;
        self.retweetLabel.hidden = YES;
    }
    
}

- (void)tapPic
{
    NSLog(@"tapPic");
    if([self.viewController respondsToSelector:@selector(tapPic:)]&&_oringPic){
        [self.viewController performSelector:@selector(tapPic:) withObject:_oringPic];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (CGFloat)tweetStatusHeight:(NSString *)text
{
    
    CGSize statusSize = [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:12.0] constrainedToSize:CGSizeMake(280, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    _tweetLabelHeight = statusSize.height;
    
    return _tweetLabelHeight;
}

- (CGFloat)retweetStatusHeight:(NSString *)text
{
    
    CGSize statusSize = [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:12.0] constrainedToSize:CGSizeMake(256, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    _retweetLabelHeight = statusSize.height;
    return _retweetLabelHeight;
}

- (CGFloat)hightForCellWithStatus:(Status *)status;
{
    _statusEntity = status;
    
    [self setNeedsLayout];
    
    CGFloat tweetHeight = [self tweetStatusHeight:_statusEntity.text];
    CGFloat cellHeight =  tweetHeight+30;
    if (self.statusEntity.thumbnailPic) {
        cellHeight += thumbnailPicHeight+25;
    }
    
    if (self.statusEntity.origStatus.text) {
        if (self.statusEntity.origStatus.thumbnailPic) {
            cellHeight += [self retweetStatusHeight:_statusEntity.origStatus.nameAndText] + thumbnailPicHeight+55;
        }else{
            cellHeight += [self retweetStatusHeight:_statusEntity.origStatus.nameAndText]+45;
        }
    }
    return fmaxf(150.0f, cellHeight);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cellClickStatus = CellNormalClick;
    CGRect tweetLabelRect =  self.tweetLabel.frame;
    tweetLabelRect.size.height = [self tweetStatusHeight:_statusEntity.text];
    self.tweetLabel.frame = tweetLabelRect;
    
    if (self.statusEntity.thumbnailPic) {
        CGRect thumbnailPicRect = self.thumbnailPic.frame;
        thumbnailPicRect.origin.y = tweetLabelRect.size.height+30;
        thumbnailPicRect.size.height = thumbnailPicHeight;
        self.thumbnailPic.frame = thumbnailPicRect;
    }else{
        CGRect thumbnailPicRect = self.thumbnailPic.frame;
        thumbnailPicRect.size.height = 0.0f;
        self.thumbnailPic.frame = thumbnailPicRect;
    }
    
    if (self.statusEntity.origStatus.text) {
        CGRect retweetLabelRect;
        if (self.statusEntity.origStatus.thumbnailPic) {
            CGRect retweetBlockRect = self.retweetBlock.frame;
            retweetBlockRect.size.height= fmaxf(70.0f, [self retweetStatusHeight:_statusEntity.origStatus.nameAndText] + thumbnailPicHeight+30.0f); ;
            retweetBlockRect.origin.y = tweetLabelRect.size.height+30;
            self.retweetBlock.frame = retweetBlockRect;
            
            retweetLabelRect = retweetBlockRect;
            retweetLabelRect.origin.y += 10;
            retweetLabelRect.origin.x += 20;
            CGFloat retweetLabelHeight = [self retweetStatusHeight:_statusEntity.origStatus.nameAndText];
            retweetLabelRect.size.height = retweetLabelHeight;
            retweetLabelRect.size.width = 256.0f;
            self.retweetLabel.frame = retweetLabelRect;
            
            CGRect thumbnailPicRect = self.thumbnailPic.frame;
            thumbnailPicRect.origin.y = retweetLabelRect.size.height+tweetLabelRect.size.height +50.0f;
            thumbnailPicRect.size.height = thumbnailPicHeight;
            self.thumbnailPic.frame = thumbnailPicRect;
            
        }else{
            CGRect retweetBlockRect = self.retweetBlock.frame;
            retweetBlockRect.size.height= fmaxf(70.0f, [self retweetStatusHeight:_statusEntity.origStatus.nameAndText]+10.0f);
            retweetBlockRect.origin.y = tweetLabelRect.size.height+30.0f;
            self.retweetBlock.frame = retweetBlockRect;
            
            retweetLabelRect = retweetBlockRect;
            retweetLabelRect.origin.y += 10;
            retweetLabelRect.origin.x += 20;
            CGFloat retweetLabelHeight = [self retweetStatusHeight:_statusEntity.origStatus.nameAndText];
            retweetLabelRect.size.height = retweetLabelHeight;
            retweetLabelRect.size.width = 256.0f;
            self.retweetLabel.frame = retweetLabelRect;
            
        }
        
    }else{
        
    }
    
    
}

@end
