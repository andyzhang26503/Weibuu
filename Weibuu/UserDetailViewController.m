//
//  UserDetailViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-2-8.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "UserDetailViewController.h"
#import "User.h"

#import "UserDetailNameCell.h"
#import "UserDetailInfoCell.h"
#import "UserDetailIntroCell.h"
#import "AFNetworking.h"
@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUserInfo:(User *)user
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _userEntity = user;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.separatorColor = [UIColor clearColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int row=0;
    switch (section) {
        case 0:
            row=2;
            break;
        case 1:
            row=3;
            break;
        default:
            break;
    }
    return row;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                height=76.0f;
                break;
            case 1:
                height=65.0f;
                break;
            default:
                break;
        }
    }else if(indexPath.section==1){
        switch (indexPath.row) {
            case 2:
                height = 120;
                break;
            default:
                height = 47;
                break;
        }
        
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UserDetailNameCell *nameCell;
    UserDetailInfoCell *infoCell;
    NSArray *topLevelObjs;
    UserDetailIntroCell *introCell;
    
    CGRect cellFrame;

    NSURL *imageUrl = [NSURL URLWithString:_userEntity.profileImageUrl];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                nameCell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailNameCell"];
                if (!nameCell) {
                    topLevelObjs = [[NSBundle mainBundle] loadNibNamed:@"UserDetailNameCell" owner:nil options:nil];
                    nameCell = [topLevelObjs objectAtIndex:0];
                }
                
                [nameCell.avatarView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
                nameCell.nameLabel.text = _userEntity.name;
                if (_userEntity.verified) {
                    nameCell.verifiedImage.hidden = NO;
                }else{
                    nameCell.verifiedImage.hidden = YES;
                }
                
                nameCell.backgroundView=nil;
                nameCell.backgroundColor = [UIColor clearColor];
                nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
 
                return nameCell;
                break;
            case 1:
                infoCell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailInfoCell"];
                if (!infoCell) {
                    topLevelObjs = [[NSBundle mainBundle] loadNibNamed:@"UserDetailInfoCell" owner:nil options:nil];
                    infoCell = [topLevelObjs objectAtIndex:0];
                }
                infoCell.fansButton.titleLabel.numberOfLines=2;
                infoCell.fansButton.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
                infoCell.fansButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                //infoCell.fansButton.titleLabel.text = [NSString stringWithFormat:@"%@\n粉丝",_userEntity.followCount];
                [infoCell.fansButton setTitle:[NSString stringWithFormat:@"%@\n粉丝",_userEntity.followCount] forState:UIControlStateNormal];
                
                infoCell.followButton.titleLabel.numberOfLines=2;
                infoCell.followButton.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
                infoCell.followButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                //infoCell.followButton.titleLabel.text = [NSString stringWithFormat:@"%@\n关注",_userEntity.friendsCount];
                [infoCell.followButton setTitle:[NSString stringWithFormat:@"%@\n关注",_userEntity.friendsCount]forState:UIControlStateNormal];
                
                infoCell.statusNoButton.titleLabel.numberOfLines=2;
                infoCell.statusNoButton.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
                infoCell.statusNoButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                //infoCell.statusNoButton.titleLabel.text = [NSString stringWithFormat:@"%@\n微博",_userEntity.statusesCount];
                [infoCell.statusNoButton setTitle:[NSString stringWithFormat:@"%@\n微博",_userEntity.statusesCount] forState:UIControlStateNormal];

                infoCell.topicButton.titleLabel.numberOfLines=2;
                infoCell.topicButton.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
                infoCell.topicButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                //infoCell.topicButton.titleLabel.text = [NSString stringWithFormat:@"%@\n收藏",_userEntity.favouritesCount];
                [infoCell.topicButton setTitle:[NSString stringWithFormat:@"%@\n收藏",_userEntity.favouritesCount] forState:UIControlStateNormal];
                
                infoCell.backgroundView = nil;
                infoCell.backgroundColor= [UIColor clearColor];
                infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return infoCell;
                break;
        }

    }else if(indexPath.section==1){
        introCell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailIntroCell"];
        if (!introCell) {
            topLevelObjs = [[NSBundle mainBundle] loadNibNamed:@"UserDetailIntroCell" owner:nil options:nil];
            introCell = [topLevelObjs objectAtIndex:0];
        }
        switch (indexPath.row) {
            case 0:
                introCell.titleLabel.text = @"新浪认证";
                introCell.contentLabel.text = _userEntity.verifiedReason;
                break;
            case 1:
                introCell.titleLabel.text = @"位置";
                introCell.contentLabel.text = _userEntity.location;
                break;
            case 2:
                introCell.titleLabel.text = @"自我介绍";
                cellFrame = introCell.contentLabel.frame;
                cellFrame.size = [_userEntity.description sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(192, CGFLOAT_MAX) lineBreakMode:NSLineBreakByTruncatingHead];
                introCell.contentLabel.frame = cellFrame;
                introCell.contentLabel.numberOfLines = 10;
                
                introCell.contentLabel.text = _userEntity.description;
                break;
            default:
                break;
        }
        
        tableView.separatorColor = [UIColor lightGrayColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        introCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return introCell;
    }
    return nil;
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

@end
