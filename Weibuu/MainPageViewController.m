//
//  MainPageViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "MainPageViewController.h"
#import "WriteWbViewController.h"
@interface MainPageViewController ()

@end

@implementation MainPageViewController
@synthesize statusesArray = _statusesArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"主页";
        self.tabBarItem.title=@"主页";
        self.tabBarItem.image=[UIImage imageNamed:@"Home-32p"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    [mysinaweibo logIn];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = bbi;
    

    UIBarButtonItem *bbiQuit = [[UIBarButtonItem alloc] initWithTitle:@"写微博" style:UIBarButtonItemStylePlain target:self action:@selector(writeWeibo)];
    self.navigationItem.leftBarButtonItem=bbiQuit;
    
    [self requestTimeLine];
    
}
- (void)requestTimeLine
{
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"statuses/friends_timeline.json"
                             params:nil
                         httpMethod:@"Get"
                           delegate:self];
        
    }

}

- (void)logOut
{
    [[SinaWeiboManager sinaweibo] logOut];
}

- (void)writeWeibo
{
    WriteWbViewController *wvc = [[WriteWbViewController alloc] init];
    
    [self.navigationController pushViewController:wvc animated:YES];
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
    return [self.statusesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"MainPageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    if (self.statusesArray) {
        Status *status =  [self.statusesArray objectAtIndex:indexPath.row];
        //cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row] ;
        cell.textLabel.text = status.text;
        cell.detailTextLabel.text = status.user.name;
        
    }
    return cell;
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
    
}


#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog([NSString stringWithFormat:@"user did login:userid=%@,accessToken=%@,expireDate=%@,refreshToken=%@",sinaweibo.userID,sinaweibo.accessToken,sinaweibo.expirationDate,sinaweibo.refreshToken] );
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    SinaWeibo *mysinaweibo = [SinaWeiboManager sinaweibo];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:mysinaweibo.accessToken,@"AccessTokenKey",mysinaweibo.expirationDate,@"ExpirationDateKey",mysinaweibo.userID,@"UserIDKey", nil];
    [defaults setObject:dictionary forKey:@"SinaWeiboAuthData"];
    [defaults synchronize];
    
    [self requestTimeLine];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"SinaWeiboAuthData"];
    [defaults synchronize];
    
    [[SinaWeiboManager sinaweibo] logIn];

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
    if ([request.url hasSuffix:@"statuses/friends_timeline.json"]) {
        self.statusesArray = [Status statusesWithJson:result];
        [[self tableView] reloadData];
    }
}
@end
