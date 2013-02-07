//
//  StatusDetailCommentCell.m
//  Weibuu
//
//  Created by zhang andy on 13-2-6.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "StatusDetailCommentCell.h"
#import "HtmlString.h"


@implementation StatusDetailCommentCell
@synthesize commentEntity = _commentEntity;
static NSDateFormatter *formatter;
static NSDateFormatter *resultFormatter;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCommentEntity:(Comment *)comment
{
    _commentEntity = comment;
    NSURL *commentUserImageUrl =  [NSURL URLWithString:_commentEntity.user.profileImageUrl];
    [self.avatarImage setImageWithURL:commentUserImageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    self.name.text = comment.user.name;
    //self.createAt.text = comment.createdAt;
    
    formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *date=[formatter dateFromString:comment.createdAt];
    
    resultFormatter=[[NSDateFormatter alloc] init];
    resultFormatter.dateFormat = @"MM-dd HH:mm";
    self.createAt.text = [resultFormatter stringFromDate:date];
    
    _commentEntity.textHtml = [HtmlString transformString:_commentEntity.text];
    
    NSString *retweetDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                        "<head> \n"
                                        "<style type=\"text/css\"> \n"
                                        "body {font-family: \"%@\"; font-size: %@;}\n"
                                        "</style> \n"
                                        "</head> \n"
                                        "<body>%@</body> \n"
                                        "</html>", @"helvetica", [NSNumber numberWithInt:10],_commentEntity.textHtml];
    
    [[self commentWebView] loadHTMLString:retweetDescriptionHTML baseURL:nil];
    
    if (_commentEntity.user.verified) {
        self.verifiedImage.hidden = NO;
    }else{
        self.verifiedImage.hidden = YES;
    }

}

- (UIWebView *)commentWebView
{
    if (!_commentWebView) {
        _commentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(50.0, 25.0, 240.0, 30.0)];
        _commentWebView.delegate = self;
        _commentWebView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:_commentWebView];
    }
    return _commentWebView;
}

//- (CGFloat)commentHeight:(NSString *)text
//{
//    CGSize commentSize =  [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:10] constrainedToSize:CGSizeMake(226, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
//    return commentSize.height+17.0f;
//}
- (CGFloat)webViewHeight:(NSString *)text
{
    CGSize commentSize =  [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:10] constrainedToSize:CGSizeMake(226, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    return commentSize.height+17.0f;

}
- (CGFloat)heightForCellWithComment:(Comment *)comment
{
    _commentEntity = comment;
    [self setNeedsLayout];
    CGFloat webViewHeight = [self webViewHeight:_commentEntity.text];
    CGFloat cellHeight =  webViewHeight+30.0f;
    return cellHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect commentRect = self.commentWebView.frame;
    commentRect.size.height = [self webViewHeight:_commentEntity.text];;
    self.commentWebView.frame = commentRect;
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
