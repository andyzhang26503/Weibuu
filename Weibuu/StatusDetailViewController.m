//
//  StatusDetailViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-2-4.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "StatusDetailViewController.h"
#import "StatusDetailNameCell.h"
#import "StatusDetailContentCell.h"
#import "StatusDetailCommentCell.h"

#import "AFNetworking.h"
#import "SinaWeiboManager.h"
#import "Comment.h"
#import "UserDetailViewController.h"
#import "ProfileViewController.h"
#define StatusDetailName @"StatusDetailCellName"
#define StatusDetailContent @"StatusDetailCellContent"
#define StatusDetailComment @"StatusDetailCellComment"
@interface StatusDetailViewController ()

@end

@implementation StatusDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStatusMain:(Status *)status
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _statusEntity = status;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[self tableView] setHidden:YES];
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//    UINib *nib = [UINib nibWithNibName:@"StatusDetailCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:StatusDetailCellContent];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self requestComments];
}

- (void)requestComments
{
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"comments/show.json"
                             params:[NSMutableDictionary dictionaryWithObjectsAndKeys:_statusEntity.idstr,@"id", nil]
                         httpMethod:@"Get"
                           delegate:self];
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2+_commentsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //StatusDetailCell *contentCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailCellContent];
    CGFloat cellHeight;
    StatusDetailContentCell *contentCell;
    StatusDetailCommentCell *commentCell;
    switch (indexPath.row) {
        case 0:
            cellHeight = 75.0f;
            break;
        case 1:
            contentCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailContent];
            if (!contentCell) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusDetailContentCell" owner:nil options:nil];
                contentCell = [topLevelObjects objectAtIndex:0];
                
            }
            
            cellHeight = [contentCell hightForCellWithStatus:_statusEntity];
            break;
        default:
            commentCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailComment];
            if (!commentCell) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusDetailCommentCell" owner:nil options:nil];
                commentCell = [topLevelObjects objectAtIndex:0];
            }
            cellHeight = [commentCell heightForCellWithComment:[_commentsArray objectAtIndex:indexPath.row-2]];
            
            //cellHeight = 57.0f;
            break;
    }
    
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *imageUrl = [NSURL URLWithString:_statusEntity.user.profileImageUrl];
    StatusDetailNameCell *nameCell;
    StatusDetailContentCell *contentCell;
    StatusDetailCommentCell *commentCell;
    
    switch (indexPath.row) {
        case 0:
            nameCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailName];
            if (!nameCell) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusDetailNameCell" owner:nil options:nil];
                nameCell = [topLevelObjects objectAtIndex:0];
                //nameCell = [[StatusDetailNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StatusDetailName];
            }
            [nameCell.avatarImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
            nameCell.name.text = _statusEntity.user.name;
            if (_statusEntity.user.verified) {
                nameCell.verifiedImage.hidden = NO;
            }else{
                nameCell.verifiedImage.hidden = YES;
            }
            [nameCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [nameCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return nameCell;
            break;
        case 1:
            contentCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailContent];
            if (!contentCell) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusDetailContentCell" owner:nil options:nil];
                contentCell = [topLevelObjects objectAtIndex:0];

            }
            [contentCell setStatusEntity:_statusEntity];
            [contentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [contentCell setViewController:self];
            return contentCell;
            break;
        default:
            commentCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailComment];
            if (!commentCell) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusDetailCommentCell" owner:nil options:nil];
                commentCell = [topLevelObjects objectAtIndex:0];

            }
            Comment *comment = [_commentsArray objectAtIndex:indexPath.row-2];
            [commentCell setCommentEntity:comment];
            [commentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return commentCell;
            break;
    }
    
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[[self tableView] setHidden:NO];
    return nil;
}

- (void)goToUserDetailVC:(NSString *)ascreenName
{
    ProfileViewController *pvc = [[ProfileViewController alloc] initWithStyle:UITableViewStyleGrouped];
    pvc.screenName = ascreenName;
    [self.navigationController pushViewController:pvc animated: YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDetailViewController *udv;
    switch (indexPath.row) {
        case 0:
            udv = [[UserDetailViewController alloc] initWithUserInfo:_statusEntity.user];
            [self.navigationController pushViewController:udv animated: YES];
            break;
        case 1:

            break;
            
        default:
            break;
    }
    
}


#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{

}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    
    
}

#pragma mark - SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response;
{
    
}
- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data
{
    
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"comments/show.json"]) {
        _commentsArray = [Comment commentsWithJson:result];
        [[self tableView] reloadData];
    }

}


@end
