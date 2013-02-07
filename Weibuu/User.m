//
//  User.m
//  Weibuu
//
//  Created by zhang andy on 13-1-17.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize allowAllActMsg=_allowAllActMsg;
@synthesize allowAllComment=_allowAllComment;
@synthesize avatarLarge=_avatarLarge;
@synthesize biFollowersCount=_biFollowersCount;
@synthesize blockWord=_blockWord;
@synthesize city=_city;
@synthesize createdAt=_createdAt;
@synthesize description=_description;
@synthesize domain=_domain;
@synthesize favouritesCount=_favouritesCount;
@synthesize followMe=_followMe;
@synthesize followCount=_followCount;
@synthesize following=_following;
@synthesize friendsCount=_friendsCount;
@synthesize gender=_gender;
@synthesize geoEnabled=_geoEnabled;
@synthesize idNo=_idNo;
@synthesize idstr=_idstr;
@synthesize lang=_lang;
@synthesize location=_location;
@synthesize mbrank=_mbrank;
@synthesize mbtype=_mbtype;
@synthesize name=_name;
@synthesize onlineStatus=_onlineStatus;
@synthesize profileImageUrl=_profileImageUrl;
@synthesize profileUrl=_profileUrl;
@synthesize province=_province;
@synthesize remark=_remark;
@synthesize screenName=_screenName;
@synthesize star=_star;
@synthesize statusesCount=_statusesCount;
@synthesize url=_url;
@synthesize verified=_verified;
@synthesize verifiedReason=_verifiedReason;
@synthesize verifiedType=_verifiedType;
@synthesize weihao=_weihao;
@synthesize statusId = _statusId;
+ (NSMutableArray *)usersWithJson:(id)json
{
    NSMutableArray *usersArray = [NSMutableArray arrayWithCapacity:20];
    NSArray *array = [json objectForKey:@"users"];
    for (id userJson in array) {
        User *user = [[User alloc] init];
        user.idNo =  [[userJson objectForKey:@"id"] intValue];
        user.idstr = [userJson objectForKey:@"idstr"];
        user.screenName = [userJson objectForKey:@"screen_name"];
        user.name = [userJson objectForKey:@"name"];
        user.province = [userJson objectForKey:@"province"];
        user.city = [userJson objectForKey:@"city"];
        user.location = [userJson objectForKey:@"location"];
        user.description = [userJson objectForKey:@"description"];
        user.url = [userJson objectForKey:@"url"];
        user.profileImageUrl = [userJson objectForKey:@"profile_image_url"];
        user.profileUrl = [userJson objectForKey:@"profile_url"];
        user.domain = [userJson objectForKey:@"domain"];
        user.weihao = [userJson objectForKey:@"weihao"];
        user.gender = [userJson objectForKey:@"gender"];
        user.followCount = [userJson objectForKey:@"followers_count"];
        user.friendsCount = [userJson objectForKey:@"friends_count"];
        user.statusesCount = [userJson objectForKey:@"statuses_count"];
        user.favouritesCount = [userJson objectForKey:@"favourites_count"];
        user.createdAt = [userJson objectForKey:@"created_at"];
        user.following = [userJson objectForKey:@"following"];
        user.allowAllActMsg = [userJson objectForKey:@"allow_all_act_msg"];
        user.geoEnabled = [userJson objectForKey:@"geo_enabled"];
        user.verified = [userJson objectForKey:@"verified"];
        user.verifiedType = [userJson objectForKey:@"verified_type"];
        user.remark = [userJson objectForKey:@"remark"];
        user.statusId = [userJson objectForKey:@"status_id"];
        user.allowAllComment = [userJson objectForKey:@"allow_all_comment"];
        user.avatarLarge = [userJson objectForKey:@"avatar_large"];
        user.verifiedReason = [userJson objectForKey:@"verified_reason"];
        user.followMe = [userJson objectForKey:@"follow_me"];
        user.onlineStatus = [userJson objectForKey:@"online_status"];
        user.biFollowersCount = [userJson objectForKey:@"bi_followers_count"];
        user.lang = [userJson objectForKey:@"lang"];
        user.star = [userJson objectForKey:@"star"];
        user.mbtype = [userJson objectForKey:@"mbtype"];
        user.mbrank = [userJson objectForKey:@"mbrank"];
        user.blockWord = [userJson objectForKey:@"block_word"];
        
        [usersArray addObject:user];
    }
    return usersArray;
}
@end
