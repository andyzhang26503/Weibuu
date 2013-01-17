//
//  Status.h
//  Weibuu
//
//  Created by zhang andy on 13-1-17.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Status : NSObject

@property (nonatomic,strong) NSNumber *attitudesCount;
@property (nonatomic,strong) NSString *bmiddlePic;
@property (nonatomic,strong) NSNumber *commentsCount;
@property (nonatomic,strong) NSString *createdAt;
@property (nonatomic,strong) NSNumber *favorited;
@property (nonatomic,strong) NSString *geo;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *originalPic;
@property (nonatomic,strong) NSNumber *repostsCount;
@property (nonatomic,strong) NSString *source;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *thumbnailPic;

@property (nonatomic,strong) User *user;

-(id) initWithJson;
-(NSMutableArray *) statusesWithJson:(id)json;
@end
