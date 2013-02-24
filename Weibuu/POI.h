//
//  POI.h
//  Weibuu
//
//  Created by zhang andy on 13-2-23.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POI : NSObject

@property (nonatomic,strong) NSString *poiid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,assign) double lon;
@property (nonatomic,assign) double lat;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,assign) int category;


+ (NSArray *)poiWithJson:(id)json;
@end
