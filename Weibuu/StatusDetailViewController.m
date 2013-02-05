//
//  StatusDetailViewController.m
//  Weibuu
//
//  Created by zhang andy on 13-2-4.
//  Copyright (c) 2013年 com.andy. All rights reserved.
//

#import "StatusDetailViewController.h"
#import "StatusDetailCell.h"
#import "AFNetworking.h"
#define StatusDetailCellId @"StatusDetailCellId"
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
    [[self tableView] setHidden:YES];
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    UINib *nib = [UINib nibWithNibName:@"StatusDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:StatusDetailCellId];

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:StatusDetailCellId];
    CGFloat cellHeight = 70.0f;
    switch (indexPath.row) {
        case 0:
            cellHeight = 87.0f;
            break;
        case 1:
            cellHeight = [cell hightForCellWithStatus:_statusEntity];
            break;
        default:
            cellHeight = 87.0f;
            break;
    }
    
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:StatusDetailCellId forIndexPath:indexPath];
    NSURL *imageUrl = [NSURL URLWithString:_statusEntity.user.profileImageUrl];

    switch (indexPath.row) {
        case 0:
            [cell.avatarImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
            cell.name.text = _statusEntity.user.name;
            if (_statusEntity.user.verified) {
                cell.verifiedImage.hidden = NO;
            }else{
                cell.verifiedImage.hidden = YES;
            }       
            cell.thumbnailPic.hidden = YES;
            cell.retweetBlock.hidden = YES;
            cell.createdAt.hidden = YES;
            cell.commentPic.hidden = YES;
            cell.commentCount.hidden = YES;
            cell.retweetPic.hidden=YES;
            cell.retweetCount.hidden = YES;
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        case 1:
            
            [cell setStatusEntity:_statusEntity];
            cell.verifiedImage.hidden = YES;
            cell.avatarImage.hidden = YES;
            cell.name.hidden = YES;
            cell.thumbnailPic.hidden = YES;
            cell.createdAt.hidden = YES;
            cell.retweetBlock.hidden=YES;
            cell.commentPic.hidden = YES;
            cell.commentCount.hidden = YES;
            cell.retweetPic.hidden=YES;
            cell.retweetCount.hidden = YES;
            break;
        default:
            [cell.avatarImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
            cell.name.text = _statusEntity.user.name;
            if (_statusEntity.user.verified) {
                cell.verifiedImage.hidden = NO;
            }else{
                cell.verifiedImage.hidden = YES;
            }
            cell.thumbnailPic.hidden = YES;
            cell.retweetBlock.hidden = YES;
            cell.createdAt.hidden = YES;
            cell.commentPic.hidden = YES;
            cell.commentCount.hidden = YES;
            cell.retweetPic.hidden=YES;
            cell.retweetCount.hidden = YES;
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
    }
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[self tableView] setHidden:NO];
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

@end
