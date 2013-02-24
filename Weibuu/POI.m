//
//  POI.m
//  Weibuu
//
//  Created by zhang andy on 13-2-23.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "POI.h"

@implementation POI

+ (NSArray *)poiWithJson:(id)json
{
    NSMutableArray *poiArray = [NSMutableArray arrayWithCapacity:20];
    NSArray *p = [json objectForKey:@"pois"];
    for (NSDictionary *dic in p) {
        POI *poi = [[POI alloc] init];
        poi.poiid = [dic objectForKey:@"poiid"];
        poi.title = [dic objectForKey:@"title"];
        poi.address = [dic objectForKey:@"address"];
        poi.lon = [[dic objectForKey:@"lon"] intValue];
        poi.lat = [[dic objectForKey:@"lat"] intValue];
        poi.category = [[dic objectForKey:@"category"] intValue];
        poi.city = [dic objectForKey:@"city"];
        
        [poiArray addObject:poi];
    }
    
    return poiArray;
}
@end
