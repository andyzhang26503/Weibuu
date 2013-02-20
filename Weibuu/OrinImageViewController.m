//
//  OrinImageViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-2-20.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "OrinImageViewController.h"
#import "AFNetworking.h"
@interface OrinImageViewController ()

@end

@implementation OrinImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closeButtonTap:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithPicURL:(NSURL *)picUrl
{
    self = [super init];
    if (self) {
        _oringPicUrl = picUrl;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapImage
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [self.oringImageView addGestureRecognizer:tap];
    self.oringImageView.userInteractionEnabled = YES;

    [self.oringImageView setImageWithURLRequest:[NSURLRequest requestWithURL:_oringPicUrl] placeholderImage:[UIImage imageNamed:@"black.png"] success:^(NSURLRequest *request,NSHTTPURLResponse *response,UIImage *image){
        [self.oringImageView setImage:image];
        self.scrollView.contentSize = self.oringImageView.image.size;
        self.oringImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        [self.activityIndicator stopAnimating];
 
    }failure:^(NSURLRequest *request,NSHTTPURLResponse *response,NSError *error){
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (!self.oringImageView.image) {
//        [self.activityIndicator startAnimating];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
