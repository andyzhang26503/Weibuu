//
//  AppDelegate.m
//  Weibuu
//
//  Created by zhang andy on 13-1-16.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
@implementation AppDelegate
@synthesize sinaweibo=_sinaweibo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self customAppearance];
    MainPageViewController *mpvc = [[MainPageViewController alloc] initWithStyle:UITableViewStylePlain];
    MentionsViewController *mvc = [[MentionsViewController alloc] initWithNibName:nil bundle:nil];
    FollowAndFansViewController *fvc = [[FollowAndFansViewController alloc] initWithNibName:nil bundle:nil];
    ProfileViewController *pvc = [[ProfileViewController alloc] initWithNibName:nil bundle:nil];
    SettingsViewController *svc = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:mpvc];
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:mvc];
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:fvc];
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:pvc];
    UINavigationController *nv5 = [[UINavigationController alloc] initWithRootViewController:svc];
    
    UITabBarController *tabbc = [[UITabBarController alloc] init];
    tabbc.viewControllers = [NSArray arrayWithObjects:nv,nv2,nv3,nv4,nv5, nil];
    
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:mpvc];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    self.window.rootViewController = tabbc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)customAppearance
{
    UIImage *surfGradient32 = [[UIImage imageNamed:@"surf_gradient_textured_32.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *surfGradient44 = [[UIImage imageNamed:@"surf_gradient_textured_44.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:surfGradient44 forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:surfGradient32 forBarMetrics:UIBarMetricsLandscapePhone];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1],UITextAttributeTextColor,[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, -1)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"Arial_Bold" size:12.0],UITextAttributeFont, nil]];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"navBarShadow.png"]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    
    
    UIImage *button24 = [[UIImage imageNamed:@"button_textured_24.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *button30 = [[UIImage imageNamed:@"button_textured_30.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:220.0/255.0 green:104.0/255.0 blue:1.0/255.0 alpha:1.0],
                                                          UITextAttributeTextColor,
                                                          [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
                                                          UITextAttributeTextShadowColor,
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
                                                          UITextAttributeTextShadowOffset,
                                                          [UIFont fontWithName:@"AmericanTypewriter" size:0.0],
                                                          UITextAttributeFont,
                                                          nil]
                                                forState:UIControlStateNormal];
    
    UIImage *buttonBack30 = [[UIImage imageNamed:@"button_back_textured_30"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    UIImage *buttonBack24 = [[UIImage imageNamed:@"button_back_textured_24"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    
    UIImage *tabBarImage = [UIImage imageNamed:@"tab_select_indicator.png"];
    [[UITabBar appearance] setSelectionIndicatorImage:tabBarImage];
    
    UIImage *tabBackground = [[UIImage imageNamed:@"tab_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBackground];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
