//
//  Status.m
//  Weibuu
//
//  Created by zhang andy on 13-1-17.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "Status.h"

@implementation Status

@synthesize attitudesCount=_attitudesCount;
@synthesize bmiddlePic=_bmiddlePic;
@synthesize commentsCount=_commentsCount;
@synthesize createdAt=_createdAt;
@synthesize favorited=_favorited;
@synthesize geo=_geo;
@synthesize id=_id;
@synthesize idstr=_idstr;
@synthesize originalPic=_originalPic;
@synthesize repostsCount=_repostsCount;
@synthesize source=_source;
@synthesize text=_text;
@synthesize thumbnailPic=_thumbnailPic;

@synthesize user=_user;

-(id) initWithJson
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSMutableArray *) statusesWithJson:(id)json
{
    NSMutableArray *statusesArray =[[NSMutableArray alloc] initWithCapacity:20];
    NSArray *statuses = [json objectForKey:@"statuses"];

    for (id statues in statuses) {
        Status *status = [[Status alloc] init];
        status.attitudesCount = [statues objectForKey:@"attitudes_count"];
        status.bmiddlePic = [statues objectForKey:@"bmiddle_pic"];
        status.commentsCount = [statues objectForKey:@"comments_count"];
        status.createdAt = [statues objectForKey:@"created_at"];
        status.favorited = [statues objectForKey:@"favorited"];
        status.geo = [statues objectForKey:@"geo"];
        status.id = [statues objectForKey:@"id"];
        status.idstr = [statues objectForKey:@"idstr"];
        status.originalPic = [statues objectForKey:@"original_pic"];
        status.repostsCount = [statues objectForKey:@"reposts_count"];
        status.source = [statues objectForKey:@"source"];
        status.text = [statues objectForKey:@"text"];
        status.thumbnailPic = [statues objectForKey:@"thumbnail_pic"];
        
        NSDictionary *userDict = [statues objectForKey:@"user"];
        User *user = [[User alloc] init];
        user.allowAllActMsg = [userDict objectForKey:@"allow_all_act_msg"];
        user.allowAllComment = [userDict objectForKey:@"allow_all_comment"];
        user.avatarLarge = [userDict objectForKey:@"avatar_large"];
        user.biFollowersCount = [userDict objectForKey:@"bi_followers_count"];
        user.blockWord = [userDict objectForKey:@"block_word"];
        user.city = [userDict objectForKey:@"city"];
        user.createdAt = [userDict objectForKey:@"created_at"];
        user.description = [userDict objectForKey:@"description"];
        user.domain = [userDict objectForKey:@"domain"];
        user.favouritesCount = [userDict objectForKey:@"favourites_count"];
        user.followMe = [userDict objectForKey:@"follow_me"];
        user.followCount = [userDict objectForKey:@"followers_count"];
        user.following = [userDict objectForKey:@"following"];
        user.friendsCount = [userDict objectForKey:@"friends_count"];
        user.gender = [userDict objectForKey:@"gender"];
        user.geoEnabled = [userDict objectForKey:@"geo_enabled"];
        user.id = [userDict objectForKey:@"id"];
        user.idstr = [userDict objectForKey:@"idstr"];
        user.lang = [userDict objectForKey:@"lang"];
        user.location = [userDict objectForKey:@"location"];
        user.mbrank = [userDict objectForKey:@"mbrank"];
        user.mbtype = [userDict objectForKey:@"mbtype"];
        user.name = [userDict objectForKey:@"name"];
        user.onlineStatus = [userDict objectForKey:@"online_status"];
        user.profileImageUrl = [userDict objectForKey:@"profile_image_url"];
        user.profileUrl = [userDict objectForKey:@"profile_url"];
        user.province = [userDict objectForKey:@"province"];
        user.remark = [userDict objectForKey:@"remark"];
        user.screenName = [userDict objectForKey:@"screen_name"];
        user.star = [userDict objectForKey:@"star"];
        user.statusesCount = [userDict objectForKey:@"statuses_count"];
        user.url = [userDict objectForKey:@"url"];
        user.verified = [userDict objectForKey:@"verified"];
        user.verifiedReason = [userDict objectForKey:@"verified_reason"];
        user.verifiedType = [userDict objectForKey:@"verified_type"];
        user.weihao = [userDict objectForKey:@"weihao"];
        
        status.user = user;
        
        [statusesArray addObject:status];

    }

    return statusesArray;
}
@end
