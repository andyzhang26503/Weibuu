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
    
    NSLog(@"view did load");
    
    if (mysinaweibo.isAuthValid) {
        [mysinaweibo requestWithURL:@"statuses/friends_timeline.json"
                             params:nil
                         httpMethod:@"Get"
                           delegate:self];

    }
    
//    if (mysinaweibo.isAuthValid) {
//        [mysinaweibo requestWithURL:@"statuses/mentions.json"
//                             params:nil
//                         httpMethod:@"Get"
//                           delegate:self];
//        
//    }
//    NSString *weiboid = @"3535048819028303";
//    if (mysinaweibo.isAuthValid) {
//        [mysinaweibo requestWithURL:@"statuses/comments.json"
//                             params:[NSMutableDictionary dictionaryWithObject:weiboid forKey:@"id"]
//                         httpMethod:@"Get"
//                           delegate:self];
//        
//    }

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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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

        Status *sta = [[Status alloc] init];
        NSMutableArray *statuses = [sta statusesWithJson:result];
        Status *status1 = [statuses objectAtIndex:0];

        NSLog([NSString stringWithFormat:@"statuses/friends_timeline:%@",status1.createdAt]);
        
    }
//    if ([request.url hasSuffix:@"statuses/mentions.json"]){
//        NSLog([NSString stringWithFormat:@"statuses/mentions.json result:%@",result]);
//    }
//    if ([request.url hasSuffix:@"statuses/comments.json"]){
//        NSLog([NSString stringWithFormat:@"statuses/comments.json result:%@",result]);
//    }
    
   
}
@end
