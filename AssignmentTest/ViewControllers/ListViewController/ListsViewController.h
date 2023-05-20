//
//  ListsViewController.h
//  AssignmentTest
//
//  Created by Muhhmmd Jawed Ansari on 20/05/23.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ListsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
