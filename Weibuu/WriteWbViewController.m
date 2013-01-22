//
//  WriteWbViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-1-21.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "WriteWbViewController.h"

@interface WriteWbViewController ()

@end

@implementation WriteWbViewController

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
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(9,20, 300,150)];
    
    //The rounded corner part, where you specify your view's corner radius:

    [_textView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [_textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_textView.layer setBorderWidth:2.0];
    [_textView.layer setCornerRadius:8.0f];
    [_textView.layer setMasksToBounds:YES];
    _textView.delegate=self;
    

    
    [self.view addSubview:_textView];
    
    //UIToolbar *tempToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,20, 320,44)];

    //[self.view addSubview:tempToolbar];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [_textView resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_textView resignFirstResponder];
}

- (void)sendWeibo
{
    if (!_textView.text) {
        return;
    }
    
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"statuses/update.json"
                             params:[NSMutableDictionary dictionaryWithObjectsAndKeys:_textView.text,@"status", nil]
                         httpMethod:@"POST"
                           delegate:self];
    
    }

}

#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{

}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    
    
}

#pragma mark - SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response;
{
    
}
- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
{
    
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"statuses/update.json"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];

    }
}

@end
