//
//  MainPageViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "MainPageViewController.h"
#import "AppDelegate.h"

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

-(SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return [delegate sinaweibo];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SinaWeibo *mysinaweibo = [self sinaweibo];
    [mysinaweibo logIn];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = bbi;
    

    UIBarButtonItem *bbiQuit = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.leftBarButtonItem=bbiQuit;
    
    [self requestTimeLine];
    
}
- (void)requestTimeLine
{
    SinaWeibo *mysinaweibo = [self sinaweibo];
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"statuses/friends_timeline.json"
                             params:nil
                         httpMethod:@"Get"
                           delegate:self];
        
    }
    NSLog(@"viewdidload after..");

}

- (void)logOut
{
    [[self sinaweibo] logOut];
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
    NSLog(@"into numberofrows");
    NSLog([NSString stringWithFormat:@"statuses33count==%d",[self.statusesArray count]]);
    return [self.statusesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"into cellforrow");
    NSLog([NSString stringWithFormat:@"statuses22count==%d",[self.statusesArray count]]);
    
    static NSString *CellIdentifier = @"Cell";
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
    SinaWeibo *mysinaweibo = [self sinaweibo];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:mysinaweibo.accessToken,@"AccessTokenKey",mysinaweibo.expirationDate,@"ExpirationDateKey",mysinaweibo.userID,@"UserIDKey", nil];
    [defaults setObject:dictionary forKey:@"SinaWeiboAuthData"];
    [defaults synchronize];
    
    [self requestTimeLine];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"weibo log out!");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"SinaWeiboAuthData"];
    [defaults synchronize];
    
    [[self sinaweibo] logIn];

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
        NSLog([NSString stringWithFormat:@"result==%@",result]);
        self.statusesArray = [Status statusesWithJson:result];
        Status *status1 = [self.statusesArray objectAtIndex:0];
        [[self tableView] reloadData];
    }
}
@end
