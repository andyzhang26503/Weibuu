//
//  WriteWbViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-1-21.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "WriteWbViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "PoisViewController.h"
#import "POI.h"
#import "AtSomebodyViewController.h"
#import "User.h"
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
    self.textViewBackgroundPic.image = [[UIImage imageNamed:@"input_window.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 80, 15)];
    
    _oringImage = self.uploadImage.imageView.image;
    
    //Here I add a UITextView in code, it will work if it's added in IB too
//    _textView = [[UITextView alloc] initWithFrame:CGRectMake(9,20, 300,150)];
//    [_textView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
//    [_textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
//    [_textView.layer setBorderWidth:2.0];
//    [_textView.layer setCornerRadius:8.0f];
//    [_textView.layer setMasksToBounds:YES];
//    _textView.delegate=self;
//    
//
//    
//    [self.view addSubview:_textView];
    
    //UIToolbar *tempToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,20, 320,44)];

    //[self.view addSubview:tempToolbar];
    
    
    // Do any additional setup after loading the view from its nib.
    [_weiboTextVIew becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    //[_textView resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    //[_textView resignFirstResponder];
}

- (void)sendWeibo
{
    if (!_weiboTextVIew.text) {
        return;
    }
    
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    UIImage *img =  self.uploadImage.imageView.image;
    if (img!=_oringImage) {
        if (mysinaweibo.isAuthValid) {
            [mysinaweibo requestWithURL:@"statuses/upload.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:_weiboTextVIew.text,@"status",img,@"pic", nil]
                             httpMethod:@"POST"
                               delegate:self];
            
        }
    }else{
        if (mysinaweibo.isAuthValid) {
            [mysinaweibo requestWithURL:@"statuses/update.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:_weiboTextVIew.text,@"status",[NSString stringWithFormat:@"%f",_userLocation.coordinate.latitude],@"lat",[NSString stringWithFormat:@"%f",_userLocation.coordinate.longitude],@"long", nil]
                             httpMethod:@"POST"
                               delegate:self];
            
        }
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
    NSLog(@"response:%@",response);
}
- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
{
    
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error %@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"statuses/update.json"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];

    }
    if ([request.url hasSuffix:@"statuses/upload.json"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
    }
}

- (IBAction)takePicture:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [actionSheet showInView:self.weiboTextVIew];

}

- (IBAction)getLocation:(id)sender {
    PoisViewController *pvc = [[PoisViewController alloc] init];
    pvc.pViewController = self;
    [self.navigationController pushViewController:pvc animated:YES];
}

- (IBAction)getFriends:(id)sender {
    AtSomebodyViewController *avc = [[AtSomebodyViewController alloc] initWithStyle:UITableViewStylePlain];
    avc.viewController = self;
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)selAtUser:(NSString *)name{
    NSString *text = [self.weiboTextVIew.text stringByAppendingFormat:@"@%@",name];
    self.weiboTextVIew.text = text;
}
- (void)chooseLocation:(CLLocation *)location withPOI:(POI *)poi
{
    _userLocation = location;
    NSString *newString = [self.weiboTextVIew.text stringByAppendingFormat:@"我在:#%@#",poi.title];
    self.weiboTextVIew.text = newString;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    switch (buttonIndex) {
        case 0:
            imagePicker.delegate=self;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            break;
        case 1:
            imagePicker.delegate =self;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            break;
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.uploadImage.imageView.image = image;
    if (picker.sourceType ==UIImagePickerControllerSourceTypeCamera) {
        ALAssetsLibrary *assets = [[ALAssetsLibrary alloc] init];
        [assets writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(image) metadata:nil completionBlock:nil];
    }
    
    //[item setThumbnailDataFromImage:image];
//    
//    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
//    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
//    NSString *key = (__bridge NSString *)newUniqueIdString;
//    [item setImageKey:key];
//    [[BNRImageStore sharedStore] setImage:image forkey:key];
//    CFRelease(newUniqueId);
//    CFRelease(newUniqueIdString);
//    
//    [imageView setImage:image];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
//        [imagePickerPopover dismissPopoverAnimated:YES];
//        imagePickerPopover = nil;
//    }else{
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//    }
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
