//
//  SinaWeiboManager.m
//  Weibuu
//
//  Created by zhang andy on 13-1-21.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "SinaWeiboManager.h"
#import "AppDelegate.h"
@implementation SinaWeiboManager


+(SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return [delegate sinaweibo];
}
@end
