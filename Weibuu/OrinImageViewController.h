//
//  OrinImageViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-2-20.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrinImageViewController : UIViewController
{
    NSURL *_oringPicUrl;
}
@property (weak, nonatomic) IBOutlet UIImageView *oringImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)closeButtonTap:(id)sender;
- (id)initWithPicURL:(NSURL *)picUrl;
@end
