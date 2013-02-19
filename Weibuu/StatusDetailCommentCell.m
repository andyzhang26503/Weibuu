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

    formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *date=[formatter dateFromString:comment.createdAt];
    
    resultFormatter=[[NSDateFormatter alloc] init];
    resultFormatter.dateFormat = @"MM-dd HH:mm";
    self.createAt.text = [resultFormatter stringFromDate:date];
    
//    _commentEntity.textHtml = [HtmlString transformString:_commentEntity.text];
//    
//    NSString *retweetDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
//                                        "<head> \n"
//                                        "<style type=\"text/css\"> \n"
//                                        "body {font-family: \"%@\"; font-size: %@;}\n"
//                                        "</style> \n"
//                                        "</head> \n"
//                                        "<body>%@</body> \n"
//                                        "</html>", @"helvetica", [NSNumber numberWithInt:10],_commentEntity.textHtml];
//    
//    [[self commentWebView] loadHTMLString:retweetDescriptionHTML baseURL:nil];
    [[self tweetLabel] setText:_commentEntity.text];
    
    if (_commentEntity.user.verified) {
        self.verifiedImage.hidden = NO;
    }else{
        self.verifiedImage.hidden = YES;
    }

}

//- (UIWebView *)commentWebView
//{
//    if (!_commentWebView) {
//        _commentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(50.0, 25.0, 240.0, 30.0)];
//        _commentWebView.delegate = self;
//        _commentWebView.scrollView.scrollEnabled = NO;
//        [self.contentView addSubview:_commentWebView];
//    }
//    return _commentWebView;
//}


- (STTweetLabel *)tweetLabel
{
    if (!_tweetLabel) {
        _tweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(56.0, 25.0, 240.0, 30.0)];
        [_tweetLabel setFont:[UIFont fontWithName:@"helvetica" size:12]];
        [_tweetLabel setTextColor:[UIColor blackColor]];
        
        STLinkCallbackBlock callBackBlock = ^(STLinkActionType actionType, NSString *link) {
            
            NSString *displayString = NULL;
            
            switch (actionType) {
                    
                case STLinkActionTypeAccount:
                    displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
                    
//                    if ([self.viewController respondsToSelector:@selector(goToUserDetailVC:)]) {
//                        [self.viewController performSelector:@selector(goToUserDetailVC:) withObject:[link substringFromIndex:1]];
//                    }
//                    
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


//- (CGFloat)commentHeight:(NSString *)text
//{
//    CGSize commentSize =  [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:10] constrainedToSize:CGSizeMake(226, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
//    return commentSize.height+17.0f;
//}
- (CGFloat)tweetLabelHeight:(NSString *)text
{
    CGSize commentSize =  [text sizeWithFont:[UIFont fontWithName:@"helvetica" size:12] constrainedToSize:CGSizeMake(240, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    return commentSize.height;

}
- (CGFloat)heightForCellWithComment:(Comment *)comment
{
    _commentEntity = comment;
    [self setNeedsLayout];
    CGFloat webViewHeight = [self tweetLabelHeight:_commentEntity.text];
    CGFloat cellHeight =  webViewHeight+40;
    return cellHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect commentRect = self.tweetLabel.frame;
    commentRect.size.height = [self tweetLabelHeight:_commentEntity.text];;
    self.tweetLabel.frame = commentRect;
}

@end
