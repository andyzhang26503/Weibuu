//
//  MentionsViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "MentionsViewController.h"
#import "SinaWeibo.h"
#import "StatusCell.h"
#import "StatusDetailViewController.h"
#import "ProfileViewController.h"
#import "OrinImageViewController.h"
#define MentionsStatusCell @"MentionsStatusCell"
@interface MentionsViewController ()

@end

@implementation MentionsViewController
@synthesize retweetStatus = _retweetStatus;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title=@"@我";
        self.tabBarItem.image=[UIImage imageNamed:@"Technorati-32p"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self tableView] setHidden:YES];
    //self.title=@"@我";
    
    UINib *nib = [UINib nibWithNibName:@"StatusCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:MentionsStatusCell];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.screenName &&!self.loginUserId) {
        [self requestMenstions];
    }else{
        [self requestAllStatusByUser];
    }

}
- (void)refresh
{
    if (!self.screenName &&!self.loginUserId) {
        [self requestMenstions];
    }else{
        [self requestAllStatusByUser];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.retweetStatus count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:MentionsStatusCell];
    
    return [cell hightForCellWithStatus:[self.retweetStatus objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"MentionsCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
//    Status *mentionStatus = [self.retweetStatus objectAtIndex:[indexPath row]];
//    cell.textLabel.text = mentionStatus.text;
//    cell.detailTextLabel.text = mentionStatus.origStatus.text;
    
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:MentionsStatusCell];
    Status *status =  [self.retweetStatus objectAtIndex:indexPath.row];
    [cell setStatusEntity:status];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.viewController = self;
    
    return cell;

}

- (void)goToUserDetailVC:(NSString *)ascreenName
{
    ProfileViewController *pvc = [[ProfileViewController alloc] initWithStyle:UITableViewStyleGrouped];
    pvc.screenName = ascreenName;
    [self.navigationController pushViewController:pvc animated: YES];
}

- (void)tapPic:(NSURL *)oringPic
{
    NSLog(@"Main page tapPic,%@",oringPic);
    OrinImageViewController *orinVC = [[OrinImageViewController alloc] initWithPicURL:oringPic];
    [self.navigationController presentViewController:orinVC animated:YES completion:nil];
    
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
    StatusCell *cell = (StatusCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.cellClickStatus==CellNormalClick) {
        StatusDetailViewController *dvc = [[StatusDetailViewController alloc] initWithStatusMain:[self.retweetStatus objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

#pragma mark - weibo request
- (void)requestMenstions
{
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"statuses/mentions.json"
                             params:nil
                         httpMethod:@"Get"
                           delegate:self];
        
    }

}
- (void)requestAllStatusByUser
{
    
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    
    if (mysinaweibo.isAuthValid) {
        if (self.loginUserId) {
            [mysinaweibo requestWithURL:@"statuses/user_timeline.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.loginUserId,@"uid", nil]
                             httpMethod:@"Get"
                               delegate:self];
        }else{
            [mysinaweibo requestWithURL:@"statuses/user_timeline.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.screenName,@"screen_name", nil]
                             httpMethod:@"Get"
                               delegate:self];
        }
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
    if ([request.url hasSuffix:@"statuses/mentions.json"]) {
        self.retweetStatus = [Status statusesWithJson:result];
        [[self tableView] reloadData];
        
    }
    if ([request.url hasSuffix:@"statuses/user_timeline.json"]) {
        self.retweetStatus = [Status statusesWithJson:result];
        [[self tableView] reloadData];
        
    }
    [[self tableView] setHidden:NO];
    [self stopLoading];
}


@end
