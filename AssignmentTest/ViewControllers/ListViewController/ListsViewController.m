//
//  ListsViewController.m
//  AssignmentTest
//
//  Created by Muhhmmd Jawed Ansari on 20/05/23.
//

#import "ListsViewController.h"
#import "ListTVCell.h"
#import <SDWebImage/SDWebImage.h>
#import "AssignmentTest-Swift.h"



@interface ListsViewController ()

@end

@implementation ListsViewController

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *userTableIdentifier = @"ListTVCell";
    
    ListTVCell *cell = (ListTVCell *)[tableView dequeueReusableCellWithIdentifier: userTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListTVCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblName.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.lblEmail.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"email"];
    
    NSString *newString = [NSString stringWithFormat:@"Country | %@", [[dataArray objectAtIndex:indexPath.row] valueForKey:@"country"]];
    
    //cell.lblCountry.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"country"];
    
    cell.lblCountry.text= newString;
    
    cell.lblDate.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"registerdate"];
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[[dataArray objectAtIndex:indexPath.row] valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.objDetailModel.selectedIndex = indexPath.row;
    vc.objDetailModel.UserListData = dataArray;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
