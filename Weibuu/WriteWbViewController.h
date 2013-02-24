//
//  WriteWbViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-1-21.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SinaWeiboManager.h"
#import <CoreLocation/CoreLocation.h>
@interface WriteWbViewController : UIViewController<UITextViewDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIImage *_oringImage;
    CLLocation *_userLocation;
}
@property (weak, nonatomic) IBOutlet UIButton *uploadImage;
@property (weak, nonatomic) IBOutlet UIImageView *textViewBackgroundPic;
@property (weak, nonatomic) IBOutlet UITextView *weiboTextVIew;
- (IBAction)takePicture:(id)sender;
- (IBAction)getLocation:(id)sender;

@end
