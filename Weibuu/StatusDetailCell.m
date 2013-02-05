//
//  StatusDetailCell.m
//  Weibuu
//
//  Created by zhang andy on 13-2-4.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "StatusDetailCell.h"
#import "StatusCell.h"
#import "AFNetworking.h"
#import "HtmlString.h"

#define thumbnailPicHeight 80.0f
@implementation StatusDetailCell
@synthesize statusEntity  = _statusEntity;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (UIWebView *)tweetWebView
{
    if (!_tweetWebView) {
        _tweetWebView = [[UIWebView alloc] initWithFrame:CGRectMake(29, 20.0, 250.0, 80.0)];
        _tweetWebView.delegate = self;
        _tweetWebView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:_tweetWebView];
    }
    return _tweetWebView;
}

- (UIWebView *)retweetWebView
{
    if (!_retweetWebView) {
        _retweetWebView = [[UIWebView alloc] initWithFrame:CGRectMake(48.0f, 91.0f, 236.0f, 50.0f)];
        _retweetWebView.delegate = self;
        _retweetWebView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:_retweetWebView];
    }
    return _retweetWebView;
}

- (void)setStatusEntity:(Status *)statusEntity
{
    _statusEntity = statusEntity;
    self.retweetCount.text = [statusEntity.repostsCount stringValue];
    self.commentCount.text = [statusEntity.commentsCount stringValue];
    
    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@;}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>%@</body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:12], statusEntity.textHtml];
    
    [[self tweetWebView] loadHTMLString:myDescriptionHTML baseURL:nil];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *date=[formatter dateFromString:statusEntity.createdAt];
    
    NSDateFormatter *resultFormatter=[[NSDateFormatter alloc] init];
    resultFormatter.dateFormat = @"MM-dd HH:mm";
    self.createdAt.text = [resultFormatter stringFromDate:date];
    
//    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@"<a .*>(.*)</a>" options:0 error:nil];
//    NSArray *matches = [reg matchesInString:statusEntity.source options:0 range:NSMakeRange(0, [statusEntity.source length])];
//    if ([matches count]>0) {
//        NSTextCheckingResult *result = [matches objectAtIndex:0];
//        if ([result numberOfRanges]==2) {
//            NSRange r = [result rangeAtIndex:1];
//            self.source.text =[NSString stringWithFormat:@" 来自:%@",[[statusEntity source] substringWithRange:r]];
//            
//        }
//    }
    
    if (statusEntity.thumbnailPic) {
        NSURL *thumbnailPicUrl = [NSURL URLWithString:statusEntity.thumbnailPic];
        [self.thumbnailPic setImageWithURL:thumbnailPicUrl placeholderImage:[UIImage imageNamed:@"loadingImage_50x118.png"]];
    }else{
        
    }
    
    if (statusEntity.origStatus.text) {
        
        UIEdgeInsets edge = UIEdgeInsetsMake(10, 40, 10, 20);
        self.retweetBlock.image = [[UIImage imageNamed:@"timeline_rt_border.png"] resizableImageWithCapInsets:edge];
        
        statusEntity.origStatus.textHtml = [HtmlString transformString:[NSString stringWithFormat:@"@%@:%@",statusEntity.origStatus.user.name, statusEntity.origStatus.text]];
        
        NSString *retweetDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                            "<head> \n"
                                            "<style type=\"text/css\"> \n"
                                            "body {font-family: \"%@\"; font-size: %@;}\n"
                                            "</style> \n"
                                            "</head> \n"
                                            "<body>%@</body> \n"
                                            "</html>", @"helvetica", [NSNumber numberWithInt:12],statusEntity.origStatus.textHtml ];
        
        [[self retweetWebView] loadHTMLString:retweetDescriptionHTML baseURL:nil];
        self.retweetWebView.hidden = NO;
        
        if (statusEntity.origStatus.thumbnailPic) {
            NSURL *thumbnailPicUrl = [NSURL URLWithString:statusEntity.origStatus.thumbnailPic];
            [self.thumbnailPic setImageWithURL:thumbnailPicUrl placeholderImage:[UIImage imageNamed:@"loadingImage_50x118.png"]];
        }else{
            self.thumbnailPic.image=nil;
        }
    }else{
        self.retweetBlock.image = nil;
        self.retweetWebView.hidden = YES;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (CGFloat)statusHeight:(NSString *)text
{
    
    CGSize statusSize = [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:13.0] constrainedToSize:CGSizeMake(250, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return statusSize.height+52.0f;
}

- (CGFloat)retweetStatusHeight:(NSString *)text
{
    
    CGSize statusSize = [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:13.0] constrainedToSize:CGSizeMake(256, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return statusSize.height+52.0f;
}

- (CGFloat)webViewHeight
{
    CGFloat newHeight =  [self statusHeight:self.statusEntity.text];
    _webViewHeight = newHeight;
    return _webViewHeight;
}

- (CGFloat)retweetWebViewHeight
{
    CGFloat newHeight =  [self retweetStatusHeight:self.statusEntity.origStatus.text];
    _retweetWebViewHeight = newHeight;
    return _retweetWebViewHeight;
}

- (CGFloat)hightForCellWithStatus:(Status *)status
{
    _statusEntity = status;
    
    [self setNeedsLayout];
    
    CGFloat webViewHeight = [self webViewHeight];
    CGFloat cellHeight =  webViewHeight;
    if (self.statusEntity.thumbnailPic) {
        cellHeight += thumbnailPicHeight-60.0f;
    }
    
    if (self.statusEntity.origStatus) {
        if (self.statusEntity.origStatus.thumbnailPic) {
            cellHeight += [self retweetWebViewHeight] + thumbnailPicHeight+90.0f;
        }else{
            cellHeight += [self retweetWebViewHeight]+90.0f;
        }
    }
    return fmaxf(185.0f, cellHeight);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect webViewRect =  self.tweetWebView.frame;
    webViewRect.size.height = [self webViewHeight];
    self.tweetWebView.frame = webViewRect;
    
    if (self.statusEntity.thumbnailPic) {
        CGRect thumbnailPicRect = self.thumbnailPic.frame;
        thumbnailPicRect.origin.y = webViewRect.size.height;
        thumbnailPicRect.size.height = thumbnailPicHeight;
        self.thumbnailPic.frame = thumbnailPicRect;
    }else{
        CGRect thumbnailPicRect = self.thumbnailPic.frame;
        thumbnailPicRect.size.height = 0.0f;
        self.thumbnailPic.frame = thumbnailPicRect;
    }
    
    if (self.statusEntity.origStatus.text) {
        CGRect retweetWebViewRect;
        if (self.statusEntity.origStatus.thumbnailPic) {
            CGRect retweetBlockRect = self.retweetBlock.frame;
            retweetBlockRect.size.height= [self retweetWebViewHeight] + thumbnailPicHeight+30.0f;
            retweetBlockRect.origin.y = webViewRect.size.height+30.0f;
            self.retweetBlock.frame = retweetBlockRect;
            
            retweetWebViewRect = retweetBlockRect;
            retweetWebViewRect.origin.y += 10;
            retweetWebViewRect.origin.x += 20;
            CGFloat retweetWebViewHeight = [self retweetWebViewHeight];
            retweetWebViewRect.size.height = retweetWebViewHeight;
            retweetWebViewRect.size.width = 236.0f;
            self.retweetWebView.frame = retweetWebViewRect;
            
            CGRect thumbnailPicRect = self.thumbnailPic.frame;
            thumbnailPicRect.origin.y = retweetWebViewRect.size.height+webViewRect.size.height +50.0f;
            thumbnailPicRect.size.height = thumbnailPicHeight;
            self.thumbnailPic.frame = thumbnailPicRect;
            
        }else{
            CGRect retweetBlockRect = self.retweetBlock.frame;
            retweetBlockRect.size.height= [self retweetWebViewHeight]+30.0f;
            retweetBlockRect.origin.y = webViewRect.size.height+30.0f;
            self.retweetBlock.frame = retweetBlockRect;
            
            retweetWebViewRect = retweetBlockRect;
            retweetWebViewRect.origin.y += 10;
            retweetWebViewRect.origin.x += 20;
            CGFloat retweetWebViewHeight = [self retweetWebViewHeight];
            retweetWebViewRect.size.height = retweetWebViewHeight;
            retweetWebViewRect.size.width = 236.0f;
            self.retweetWebView.frame = retweetWebViewRect;
        }
        
    }else{
        
    }
    
    
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[request URL] absoluteString];
    
    NSArray *urlComps = [requestString componentsSeparatedByString:@"&"];
    UIAlertView *alert;
    
    if ([urlComps count] > 1 && [(NSString *)[urlComps objectAtIndex:1] isEqualToString:@"cmd1"])//@方法
    {
        NSString *str = [[urlComps objectAtIndex:2] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        
        alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return YES;
    }
    
    if ([urlComps count] > 1 && [(NSString *)[urlComps objectAtIndex:1] isEqualToString:@"cmd2"])//话题方法
    {
        NSString *str = [[urlComps objectAtIndex:2] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        
        alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return YES;
    }
    
    //以下是使用safri打开链接
    NSURL *requestURL =[ request URL ];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL: requestURL];
    }
    return YES;
}

@end

