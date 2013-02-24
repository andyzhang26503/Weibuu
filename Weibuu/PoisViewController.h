//
//  PoisViewController.h
//  Weibuu
//
//  Created by zhang andy on 13-2-23.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SinaWeibo.h"
@interface PoisViewController : UITableViewController<CLLocationManagerDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    CLLocationManager *_locationManager;
    CLLocation *_bestEffortAtLocation;
    
    NSArray *_poiArray;
}
@property (nonatomic,weak) id pViewController;
@end
