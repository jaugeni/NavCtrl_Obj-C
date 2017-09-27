//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"
#import "Dao.h"



@interface ProductVC ()


@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleAddMode)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
}

-(void)toggleAddMode {
    
    AddEditProduct* addEditProductVC = [[AddEditProduct alloc]init];
    addEditProductVC.title = @"Add Product";
    addEditProductVC.product = self.products;
    addEditProductVC.flagIsAddMod = YES;
    
    [self.navigationController pushViewController:addEditProductVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    ProductClass* product = [self.products objectAtIndex:[indexPath row]];
    
    if (product.productImage) {
        cell.imageView.image = product.productImage;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"emptystate-homeView.png"];
    }
    cell.textLabel.text = product.productName;
    cell.showsReorderControl = YES;
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];

}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        AddEditProduct* addEditProductVC = [[AddEditProduct alloc]init];
                                        addEditProductVC.title = @"Edit Product";
                                        addEditProductVC.flagIsAddMod = NO;
                                        addEditProductVC.currentProductIndex = (int) indexPath.row;
                                        addEditProductVC.currentProduct = self.products[indexPath.row];
                                        [self.navigationController pushViewController:addEditProductVC animated:YES];
                                    }];
    button.backgroundColor = [UIColor greenColor]; //arbitrary color
    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         [self.products removeObjectAtIndex:indexPath.row];
                                         [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                     }];
    button2.backgroundColor = [UIColor redColor]; //arbitrary color
    
    return @[button2, button]; //array with all the buttons you want. 1,2,3, etc...
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.products exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    self.productLinkVC = [[ProductLinkVc alloc]init];
    ProductClass* product = [self.products objectAtIndex:[indexPath row]];
    
    self.productLinkVC.title = product.productName;
//    self.productLinkVC.currentProductIndex = (int) indexPath.row;
    self.productLinkVC.currentProduct = product;
    [self.navigationController pushViewController:self.productLinkVC animated:YES];
}




- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
