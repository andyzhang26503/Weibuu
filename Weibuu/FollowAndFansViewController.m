//
//  FollowAndFansViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "FollowAndFansViewController.h"
#import "UserDetailNameCell.h"
#import "AFNetworking.h"
#import "UserDetailViewController.h"
#define UserDetailName @"UserDetailNameCell"

@interface FollowAndFansViewController ()

@end

@implementation FollowAndFansViewController

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
        self.tabBarItem.title=@"好友";
        self.tabBarItem.image=[UIImage imageNamed:@"Digg-32p"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"好友";
    
    UINib *nib = [UINib nibWithNibName:@"UserDetailNameCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:UserDetailName];
    
    _segControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"关注",@"粉丝", nil]];
    _segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.navigationItem.titleView = _segControl;
    [_segControl addTarget:self action:@selector(selFollow) forControlEvents:UIControlEventValueChanged];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)selFollow
{
    _segIndex = _segControl.selectedSegmentIndex;
    if (_segIndex==0) {
        [self requestfriends];
    }else if(_segIndex==1){
        [self requestFans];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"friends viewWillAppear");
    
    _segControl.selectedSegmentIndex=_segIndex;

    [self requestfriends];
    
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

    return [self.usersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UserDetailNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:UserDetailName];
    User *user = [self.usersArray objectAtIndex:indexPath.row];
    
    NSURL *imageUrl = [NSURL URLWithString:user.profileImageUrl];
    [nameCell.avatarView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    nameCell.nameLabel.text = user.name;
    if (user.verified) {
        nameCell.verifiedImage.hidden = NO;
    }else{
        nameCell.verifiedImage.hidden = YES;
    }
    [nameCell.unfollowButton setTitle:@"取消关注" forState:UIControlStateNormal];
    nameCell.userDetailVC = self;
    nameCell.screenName = user.screenName;
    nameCell.backgroundView=nil;
    nameCell.backgroundColor = [UIColor clearColor];
    nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    nameCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //cell.textLabel.text = user.name;
    //cell.detailTextLabel.text = user.description;

    return nameCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
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

    UserDetailViewController *udv = [[UserDetailViewController alloc] initWithUserInfo:[self.usersArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:udv animated: YES];
}



#pragma mark - weibo request
- (void)requestfriends
{
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (!self.screenName) {
        if (mysinaweibo.isAuthValid) {
            [mysinaweibo requestWithURL:@"friendships/friends.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:mysinaweibo.userID,@"uid", nil]
                             httpMethod:@"GET"
                               delegate:self];
            
        }
    }else{
        if (mysinaweibo.isAuthValid) {
            [mysinaweibo requestWithURL:@"friendships/friends.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.screenName,@"screen_name", nil]
                             httpMethod:@"GET"
                               delegate:self];
            
        }
    }
    

    
}

- (void)requestFans
{
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (!self.screenName) {
        if (mysinaweibo.isAuthValid) {
            [mysinaweibo requestWithURL:@"friendships/followers.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:mysinaweibo.userID,@"uid", nil]
                             httpMethod:@"GET"
                               delegate:self];
            
        }
    }else{
        if (mysinaweibo.isAuthValid) {
            [mysinaweibo requestWithURL:@"friendships/followers.json"
                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.screenName,@"screen_name", nil]
                             httpMethod:@"GET"
                               delegate:self];
            
        }

    }
    

}

- (void)unfollowUser:(NSString *)screenName
{
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"friendships/destroy.json"
                             params:[NSMutableDictionary dictionaryWithObjectsAndKeys:screenName,@"screen_name", nil]
                         httpMethod:@"POST"
                           delegate:self];
        
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
    if ([request.url hasSuffix:@"friendships/friends.json"]) {
        self.usersArray = [User usersWithJson:result];
        [[self tableView] reloadData];
    }
    if ([request.url hasSuffix:@"friendships/followers.json"]) {
        self.usersArray = [User usersWithJson:result];
        [[self tableView] reloadData];
    }
    if ([request.url hasSuffix:@"friendships/destroy.json"]) {
        NSLog(@"friendships/destroy.json==%@",result);

    }
}



@end
