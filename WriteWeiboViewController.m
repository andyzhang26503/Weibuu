//
//  WriteWeiboViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-1-21.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "WriteWeiboViewController.h"

@interface WriteWeiboViewController ()

@end

@implementation WriteWeiboViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"写微博";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendWeibo)];
    
    //Here I add a UITextView in code, it will work if it's added in IB too
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 220, 200, 100)];
    
    //The rounded corner part, where you specify your view's corner radius:
    textView.layer.cornerRadius = 5;
    textView.clipsToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
