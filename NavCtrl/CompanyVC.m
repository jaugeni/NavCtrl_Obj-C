//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
#import "Dao.h"


@interface CompanyVC ()


@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleAddMode)];
    
    self.navigationItem.leftBarButtonItem = editButton;
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"Company";
    
    Dao *dao = [Dao sharedDao];
    self.companyList = dao.companyList;

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    self.companyList = [[Dao sharedDao] companyList];
    self.tableView.editing = NO;
    self.navigationItem.leftBarButtonItem.title = @"Edit";
    [self.tableView reloadData];
}

- (void)toggleEditMode {
    
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.tableView.allowsSelectionDuringEditing = NO;
        self.navigationItem.leftBarButtonItem.title = @"Edit";
        [self.tableView reloadData];
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.tableView.allowsSelectionDuringEditing = YES;
        self.navigationItem.leftBarButtonItem.title = @"Done";
    }
    
}

-(void)toggleAddMode {
    
    AddEditCompanyVc* addEditCompanyVc = [[AddEditCompanyVc alloc]init];
    addEditCompanyVc.title = @"Add Company";
    addEditCompanyVc.flagIsAddMod = YES;
    [self.navigationController pushViewController:addEditCompanyVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    UIImage* image;
    self.currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    if ((image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.currentCompany.companyName]])) {
        cell.imageView.image = image;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"emptystate-homeView.png"];
    }
    cell.textLabel.text = self.currentCompany.companyName;
    cell.showsReorderControl = YES;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


////// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.companyList exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    if (tableView.editing == YES) {
        // Table view is editing - run code here
        self.companyList = [[Dao sharedDao] companyList];
        [self.tableView reloadData];
        AddEditCompanyVc* addEditCompanyVc = [[AddEditCompanyVc alloc]init];
        addEditCompanyVc.title = @"Edit Company";
        addEditCompanyVc.flagIsAddMod = NO;
        addEditCompanyVc.currentCompanyIndex = (int) indexPath.row;
        [self.navigationController pushViewController:addEditCompanyVc animated:YES];
    } else {
        
        self.productViewController = [[ProductVC alloc]init];
        self.productViewController.title = self.currentCompany.companyName;
        self.productViewController.products = self.currentCompany.products;
        
        
        [self.navigationController
         pushViewController:self.productViewController
         animated:YES];
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
