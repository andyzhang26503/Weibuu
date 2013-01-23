//
//  User.h
//  Weibuu
//
//  Created by zhang andy on 13-1-17.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic,strong) NSNumber *allowAllActMsg;
@property (nonatomic,strong) NSNumber *allowAllComment;
@property (nonatomic,strong) NSString *avatarLarge;
@property (nonatomic,strong) NSNumber *biFollowersCount;
@property (nonatomic,strong) NSNumber *blockWord;
@property (nonatomic,strong) NSNumber *city;
@property (nonatomic,strong) NSString *createdAt;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSString *domain;
@property (nonatomic,strong) NSNumber *favouritesCount;
@property (nonatomic,strong) NSNumber *followMe;
@property (nonatomic,strong) NSNumber *followCount;
@property (nonatomic,strong) NSNumber *following;
@property (nonatomic,strong) NSNumber *friendsCount;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSNumber *geoEnabled;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *lang;
@property (nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSNumber *mbrank;
@property (nonatomic,strong) NSNumber *mbtype;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSNumber *onlineStatus;
@property (nonatomic,strong) NSString *profileImageUrl;
@property (nonatomic,strong) NSString *profileUrl;
@property (nonatomic,strong) NSNumber *province;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *screenName;
@property (nonatomic,strong) NSNumber *star;
@property (nonatomic,strong) NSNumber *statusesCount;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSNumber *verified;
@property (nonatomic,strong) NSString *verifiedReason;
@property (nonatomic,strong) NSNumber *verifiedType;
@property (nonatomic,strong) NSString *weihao;

@property (nonatomic,strong) NSString *statusId;
@property (nonatomic,strong) NSString *coverImage;
+ (NSMutableArray *)usersWithJson:(id)json;
@end
