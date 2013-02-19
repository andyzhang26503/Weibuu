//
//  StatusCell.m
//  Weibuu
//
//  Created by zhang andy on 13-1-23.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "StatusCell.h"
#import "AFNetworking.h"
#import "HtmlString.h"

#define thumbnailPicHeight 80.0f
#define fontName @"HelveticaNeue"
@implementation StatusCell
@synthesize statusEntity  = _statusEntity;
@synthesize statusLabel = _statusLabel;

static NSDateFormatter *formatter;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }

    return self;
}

//- (UIWebView *)tweetWebView
//{
//    if (!_tweetWebView) {
//        _tweetWebView = [[UIWebView alloc] initWithFrame:CGRectMake(60.0, 27.0, 250.0, 80.0)];
//        _tweetWebView.delegate = self;
//        _tweetWebView.scrollView.scrollEnabled = NO;
//        //_tweetWebView.userInteractionEnabled = YES;
//
//        [self.contentView addSubview:_tweetWebView];
//    }
//    return _tweetWebView;
//}

- (STTweetLabel *)tweetLabel
{
    if (!_tweetLabel) {
        _tweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(60.0, 27.0, 250.0, 80.0)];
        [_tweetLabel setFont:[UIFont fontWithName:fontName size:12]];
        [_tweetLabel setTextColor:[UIColor blackColor]];

        STLinkCallbackBlock callBackBlock = ^(STLinkActionType actionType, NSString *link) {
            
            NSString *displayString = NULL;
            
            switch (actionType) {
                    
                case STLinkActionTypeAccount:
                    displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
                    
                    if ([self.viewController respondsToSelector:@selector(goToUserDetailVC:)]) {
                        [self.viewController performSelector:@selector(goToUserDetailVC:) withObject:[link substringFromIndex:1]];
                    }
          
                    break;
                    
                case STLinkActionTypeHashtag:
                    displayString = [NSString stringWithFormat:@"Twitter hashtag:\n%@", link];
                    break;
                    
                case STLinkActionTypeWebsite:
                    displayString = [NSString stringWithFormat:@"Website:\n%@", link];
                    break;
            }
            NSLog(@"tap==%@",displayString);
        };
        
        [_tweetLabel setCallbackBlock:callBackBlock];
    }

    [self.contentView addSubview:_tweetLabel];
    return _tweetLabel;
}

//- (UIWebView *)retweetWebView
//{
//    if (!_retweetWebView) {
//        _retweetWebView = [[UIWebView alloc] initWithFrame:CGRectMake(57.0f, 89.0f, 236.0f, 50.0f)];
//        _retweetWebView.delegate = self;
//        _retweetWebView.scrollView.scrollEnabled = NO;
//        [self.contentView addSubview:_retweetWebView];
//    }
//    return _retweetWebView;
//}

- (STTweetLabel *)retweetLabel
{
    if (!_retweetLabel) {
        _retweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(57.0f, 89.0f, 236.0f, 50.0f)];
        [_retweetLabel setFont:[UIFont fontWithName:fontName size:12]];
        [_retweetLabel setTextColor:[UIColor blackColor]];
        
        STLinkCallbackBlock callBackBlock = ^(STLinkActionType actionType, NSString *link) {
            
            NSString *displayString = NULL;
            
            switch (actionType) {
                    
                case STLinkActionTypeAccount:
                    displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
                    if ([self.viewController respondsToSelector:@selector(goToUserDetailVC:)]) {
                        [self.viewController performSelector:@selector(goToUserDetailVC:) withObject:[link substringFromIndex:1]];
                    }
                    break;
                    
                case STLinkActionTypeHashtag:
                    displayString = [NSString stringWithFormat:@"Twitter hashtag:\n%@", link];
                    break;
                    
                case STLinkActionTypeWebsite:
                    displayString = [NSString stringWithFormat:@"Website:\n%@", link];
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

    self.name.text = statusEntity.user.name;
    self.retweetCount.text = [statusEntity.repostsCount stringValue];
    self.commentCount.text = [statusEntity.commentsCount stringValue];

//    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
//                                   "<head> \n"
//                                   "<style type=\"text/css\"> \n"
//                                   "body {font-family: \"%@\"; font-size: %@;}\n"
//                                   "</style> \n"
//                                   "</head> \n"
//                                   "<body>%@</body> \n"
//                                   "</html>", @"helvetica", [NSNumber numberWithInt:12], statusEntity.textHtml];
    
    //[[self tweetWebView] loadHTMLString:myDescriptionHTML baseURL:nil];
    [[self tweetLabel] setText:statusEntity.text];
    
    formatter=[[NSDateFormatter alloc] init];
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
    
    
    if (statusEntity.user.verified) {
        self.verifiedImage.hidden = NO;
    }else{
        self.verifiedImage.hidden = YES;
    }
    
    
    NSURL *imageUrl = [NSURL URLWithString:statusEntity.user.profileImageUrl];
    [self.avatarImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    
    
    self.name.textColor = [UIColor grayColor];
    if (statusEntity.thumbnailPic) {
        NSURL *thumbnailPicUrl = [NSURL URLWithString:statusEntity.thumbnailPic];
        [self.thumbnailPic setImageWithURL:thumbnailPicUrl placeholderImage:[UIImage imageNamed:@"loadingImage_50x118.png"]];
    }else{
      
    }
    
    if (statusEntity.origStatus.text) {
        
        UIEdgeInsets edge = UIEdgeInsetsMake(10, 40, 10, 20);
        self.retweetBlock.image = [[UIImage imageNamed:@"timeline_rt_border.png"] resizableImageWithCapInsets:edge];

        //statusEntity.origStatus.textHtml = [HtmlString transformString:[NSString stringWithFormat:@"@%@:%@",statusEntity.origStatus.user.name, statusEntity.origStatus.text]];
        
//        NSString *retweetDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
//                                       "<head> \n"
//                                       "<style type=\"text/css\"> \n"
//                                       "body {font-family: \"%@\"; font-size: %@;}\n"
//                                       "</style> \n"
//                                       "</head> \n"
//                                       "<body>%@</body> \n"
//                                       "</html>", @"helvetica", [NSNumber numberWithInt:12],statusEntity.origStatus.textHtml ];
//        
//        [[self retweetWebView] loadHTMLString:retweetDescriptionHTML baseURL:nil];
        self.retweetLabel.hidden = NO;
        self.retweetBlock.hidden = NO;
        [self.retweetLabel setText:statusEntity.origStatus.nameAndText];

        if (statusEntity.origStatus.thumbnailPic) {
            NSURL *thumbnailPicUrl = [NSURL URLWithString:statusEntity.origStatus.thumbnailPic];
            [self.thumbnailPic setImageWithURL:thumbnailPicUrl placeholderImage:[UIImage imageNamed:@"loadingImage_50x118.png"]];
        }else{
            self.thumbnailPic.image=nil;
        }
    }else{
        self.retweetBlock.hidden = YES;
        self.retweetLabel.hidden = YES;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)tweetStatusHeight:(NSString *)text
{

    CGSize statusSize = [text sizeWithFont:[UIFont fontWithName:fontName size:12.0] constrainedToSize:CGSizeMake(250, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    _tweetLabelHeight = statusSize.height;

    return _tweetLabelHeight;
}

- (CGFloat)retweetStatusHeight:(NSString *)text
{
    
    CGSize statusSize = [text sizeWithFont:[UIFont fontWithName:fontName size:12.0] constrainedToSize:CGSizeMake(236, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    _retweetLabelHeight = statusSize.height;
    return _retweetLabelHeight;
}

//- (CGFloat)tweetLabelHeight
//{
//    CGFloat newHeight =  [self statusHeight:self.statusEntity.text];
//    _webViewHeight = newHeight;
//    return _webViewHeight;
//}
//
//- (CGFloat)retweetLabelHeight
//{
//    CGFloat newHeight =  [self retweetStatusHeight:self.statusEntity.origStatus.text];
//    _retweetWebViewHeight = newHeight;
//    return _retweetWebViewHeight;
//}

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
            cellHeight += fmaxf(70.0f,[self retweetStatusHeight:_statusEntity.origStatus.nameAndText] + thumbnailPicHeight+30)+25;
        }else{
            cellHeight += fmaxf(70.0f,[self retweetStatusHeight:_statusEntity.origStatus.nameAndText]+10)+25;
        }
    }    
    return fmaxf(150.0f, cellHeight);

}

- (void)layoutSubviews {
    [super layoutSubviews];

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
            retweetLabelRect.size.width = 236.0f;
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
            retweetLabelRect.size.width = 236.0f;
            self.retweetLabel.frame = retweetLabelRect;

        }
        
    }else{
        
    }

    
}


//
//- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
//{
//
//    NSString *requestString = [[request URL] absoluteString];
//
//    NSArray *urlComps = [requestString componentsSeparatedByString:@"&"];
//    UIAlertView *alert;
//    
//    if ([urlComps count] > 1 && [(NSString *)[urlComps objectAtIndex:1] isEqualToString:@"cmd1"])//@方法
//    {
//        NSString *str = [[urlComps objectAtIndex:2] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        str = [str substringFromIndex:1];
//        //NSLog(@"%@", str);
//        //alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //[alert show];
//        if ([self.viewController respondsToSelector:@selector(goToUserDetailVC:)]) {
//            [self.viewController performSelector:@selector(goToUserDetailVC:) withObject:str];
//        }
//        
//        return YES;
//    }
//    
//    if ([urlComps count] > 1 && [(NSString *)[urlComps objectAtIndex:1] isEqualToString:@"cmd2"])//话题方法
//    {
//        NSString *str = [[urlComps objectAtIndex:2] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%@", str);
//        
//        alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        return YES;
//    }
//    
//    //以下是使用safri打开链接
//    NSURL *requestURL =[ request URL ];
//    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
//        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
//        return ![ [ UIApplication sharedApplication ] openURL: requestURL];
//    }
//    return YES;
//}


@end
