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
@interface WriteWbViewController : UIViewController<UITextViewDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    UITextView *_textView;
}

@end
