//
//  AtSomebodyViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-2-24.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "AtSomebodyViewController.h"
#import "SinaWeiboManager.h"
#import "User.h"
#import "UserDetailNameCell.h"
#import "User.h"
#import "AFNetworking.h"
#define AtSBCellId @"UserDetailNameCell"
@interface AtSomebodyViewController ()

@end

@implementation AtSomebodyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"UserDetailNameCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:AtSBCellId];
    
    self.mySearchBar.showsScopeBar = NO;
    
    self.filteredUsersArray = [NSMutableArray arrayWithCapacity:self.usersArray.count];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestfriends];
}

#pragma mark - weibo request
- (void)requestfriends
{
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"friendships/friends.json"
                             params:[NSMutableDictionary dictionaryWithObjectsAndKeys:mysinaweibo.userID,@"uid", nil]
                         httpMethod:@"GET"
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.filteredUsersArray.count;
    }
    return self.usersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDetailNameCell *cell = [tableView dequeueReusableCellWithIdentifier:AtSBCellId];
    
    User *user;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        user = [self.filteredUsersArray objectAtIndex:indexPath.row];
        if (!cell) {
            NSArray *topLevelObj = [[NSBundle mainBundle] loadNibNamed:@"UserDetailNameCell" owner:nil options:nil];
            cell = [topLevelObj objectAtIndex:0];
        }
    }else{
        user =  [self.usersArray objectAtIndex:indexPath.row];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:user.profileImageUrl];
    [cell.avatarView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    cell.nameLabel.text = user.name;
    if (user.verified) {
        cell.verifiedImage.hidden = NO;
    }else{
        cell.verifiedImage.hidden = YES;
    }

    cell.backgroundView=nil;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.unfollowButton.hidden = YES;
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76.0f;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    User *user;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        user = [self.filteredUsersArray objectAtIndex:indexPath.row];
    }else{
        user = [self.usersArray objectAtIndex:indexPath.row];
    }
        
    if([self.viewController respondsToSelector:@selector(selAtUser:)]){
        [self.viewController performSelector:@selector(selAtUser:) withObject:user.name];
    }
    [self.navigationController popViewControllerAnimated:YES];
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

}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterUserForSearchText:searchString];
    return YES;
}
- (void)filterUserForSearchText:(NSString *)searchText
{
    [self.filteredUsersArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name contains[c] %@",searchText];
    NSArray *tempArray = [self.usersArray filteredArrayUsingPredicate:predicate];
    self.filteredUsersArray = [NSMutableArray arrayWithArray:tempArray];
}
@end
