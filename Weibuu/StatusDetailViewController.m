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
#import "AFNetworking.h"

#define StatusDetailName @"StatusDetailCellName"
#define StatusDetailContent @"StatusDetailCellContent"
#define StatusDetailComment @"StatusDetailComment"
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
    //StatusDetailCell *contentCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailCellContent];
    CGFloat cellHeight;
    StatusDetailContentCell *contentCell;
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
            cellHeight = 87.0f;
            break;
    }
    
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *imageUrl = [NSURL URLWithString:_statusEntity.user.profileImageUrl];
    StatusDetailNameCell *nameCell;
    StatusDetailContentCell *contentCell;
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
            return contentCell;
            break;
        default:
            nameCell = [tableView dequeueReusableCellWithIdentifier:StatusDetailName];
            if (!nameCell) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusDetailNameCell" owner:nil options:nil];
                nameCell = [topLevelObjects objectAtIndex:0];

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
    }
    
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[[self tableView] setHidden:NO];
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
