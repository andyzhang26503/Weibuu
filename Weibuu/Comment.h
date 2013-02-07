//
//  Comment.h
//  Weibuu
//
//  Created by zhang andy on 13-2-6.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Status.h"
@interface Comment : NSObject

@property (nonatomic,strong) NSString *createdAt;
@property (nonatomic,assign) int id;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *textHtml;
@property (nonatomic,strong) NSString *source;
@property (nonatomic,strong) NSString *mid;
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) Status *status;

+ (NSMutableArray *)commentsWithJson:(id)json;
@end
