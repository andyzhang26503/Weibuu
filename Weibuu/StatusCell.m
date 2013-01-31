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
@implementation StatusCell
@synthesize statusEntity  = _statusEntity;
@synthesize statusLabel = _statusLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }

    return self;
}

//- (STTweetLabel *)statusSTLabel
//{
//    if (!_statusSTLabel) {
//        _statusSTLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(60, 27.0, 250.0, 120.0)];
//        [_statusSTLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
//        [self.contentView addSubview:_statusSTLabel];
//    }
//    
//    return _statusSTLabel;
//}

- (UIWebView *)tweetWebView
{
    if (!_tweetWebView) {
        _tweetWebView = [[UIWebView alloc] initWithFrame:CGRectMake(60.0, 27.0, 250.0, 80.0)];
        _tweetWebView.delegate = self;
        _tweetWebView.backgroundColor = [UIColor lightGrayColor];
        
        _tweetWebView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:_tweetWebView];
    }
    return _tweetWebView;
}

- (void)setStatusEntity:(Status *)statusEntity
{
    _statusEntity = statusEntity;
    
    
    
    self.name.text = statusEntity.user.name;
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
    [self.avatarImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    
    self.name.textColor = [UIColor grayColor];
    self.statusLabel.textColor = [UIColor darkGrayColor];
    self.statusLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
    
    if (statusEntity.thumbnailPic) {
        //self.thumbnailPic.hidden=NO;
        NSURL *thumbnailPicUrl = [NSURL URLWithString:statusEntity.thumbnailPic];
        [self.thumbnailPic setImageWithURL:thumbnailPicUrl placeholderImage:[UIImage imageNamed:@"noImage50x118.png"]];
    }else{
       // self.thumbnailPic.hidden=YES;
    }
        
//    STLinkCallbackBlock callbackBlock = ^(STLinkActionType actionType, NSString *link) {
//        
//        NSString *displayString = NULL;
//        UIAlertView *alert = NULL;
//        
//        switch (actionType) {
//                
//            case STLinkActionTypeAccount:
//                displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
//                alert= [[UIAlertView alloc] initWithTitle:@"result" message:displayString delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
//                [alert show];
//                                
//                break;
//                
//            case STLinkActionTypeHashtag:
//                displayString = [NSString stringWithFormat:@"Twitter hashtag:\n%@", link];
//                break;
//                
//            case STLinkActionTypeWebsite:
//                displayString = [NSString stringWithFormat:@"Website:\n%@", link];
//                break;
//        }
//        
//        //[_displayLabel setText:displayString];
//        
//    };
//    
//    [self.statusSTLabel setCallbackBlock:callbackBlock];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)statusHeight:(NSString *)text
{

    CGSize statusSize = [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:12.0] constrainedToSize:CGSizeMake(250, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return statusSize.height+20.0f;
}


- (CGFloat)hightForCellWithStatus:(Status *)status;
{
    _statusEntity = status;
    CGFloat webViewHeight = [self webViewHeight];
    CGFloat cellHeight =  webViewHeight+38.0f;
    if (self.statusEntity.thumbnailPic) {
        cellHeight += thumbnailPicHeight;
    }
    
//    NSString *allString;
//    if (status.origStatus.text) {
//        allString = [status.text stringByAppendingString:status.origStatus.text];
//    }else{
//        allString = status.text;
//    }
//    
//    CGSize size = [allString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"cell height==%f",cellHeight);
    
    [self setNeedsLayout];
    return fmaxf(185.0f, cellHeight);

}
- (CGFloat)webViewHeight
{
    CGFloat newHeight =  [self statusHeight:self.statusEntity.text];
    _webViewHeight = newHeight+30;
    return _webViewHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    

    CGRect webViewRect =  self.tweetWebView.frame;
    webViewRect.size.height = [self webViewHeight];
    self.tweetWebView.frame = webViewRect;
    
    //self.createdAt.frame
    if (self.statusEntity.thumbnailPic) {

        
        CGRect thumbnailPicRect = self.thumbnailPic.frame;
        thumbnailPicRect.origin.y = webViewRect.size.height +10.0f;
        thumbnailPicRect.size.height = thumbnailPicHeight;
        self.thumbnailPic.frame = thumbnailPicRect;
    }else{
//        CGRect createRect = CGRectOffset(self.createdAt.frame, 0, webViewRect.size.height);
//        self.createdAt.frame = createRect;
//        
//        CGRect sourceRect = CGRectOffset(self.source.frame, 0, webViewRect.size.height);
//        self.source.frame = sourceRect;
//        
//        CGRect tweetImageRect = CGRectOffset(self.thumbnailPic.frame, 0, 0);
//        self.thumbnailPic.frame = tweetImageRect;
        CGRect thumbnailPicRect = self.thumbnailPic.frame;
        //thumbnailPicRect.origin.y = webViewRect.size.height +40.0f;
        thumbnailPicRect.size.height = 0.0f;
        self.thumbnailPic.frame = thumbnailPicRect;
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
