//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
#import "Dao.h"
#import "StockWork.h"


@interface CompanyVC ()
@property NSTimer *timer;

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleAddMode)];
    
    self.navigationItem.leftBarButtonItem = editButton;
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.title = @"Company";
    
    Dao *dao = [Dao sharedDao];
    self.companyList = dao.companyList;
    [self redoUndoHidden:YES];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"ReloadTable" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    self.companyList = [[Dao sharedDao] companyList];
    [self.tableView reloadData];
    
    self.tableView.editing = NO;
    self.navigationItem.leftBarButtonItem.title = @"Edit";
    
    [self redoUndoHidden:YES];
    [self timerForStack];

}

- (void)reloadTableView{
    [self.companyList removeAllObjects];
    self.companyList = [[Dao sharedDao] companyList];
    [self.tableView reloadData];
    [self updateStck];
}

- (void)toggleEditMode {
    
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.tableView.allowsSelectionDuringEditing = NO;
        self.navigationItem.leftBarButtonItem.title = @"Edit";
        [self.tableView reloadData];
        [self redoUndoHidden:YES];
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.tableView.allowsSelectionDuringEditing = YES;
        self.navigationItem.leftBarButtonItem.title = @"Done";
        [self redoUndoHidden:NO];
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

- (IBAction)redoPressed:(id)sender {
    [[Dao sharedDao] redo];
}

- (IBAction)undoPressed:(id)sender {
    [[Dao sharedDao] undo];
}

-(void)redoUndoHidden:(BOOL)hidden{
    self.undoBtn.hidden = hidden;
    self.redoBtn.hidden = hidden;
    self.undoRedoBtnStock.hidden = hidden;
}

-(void)updateStck{
    StockWork* stockWork = [[StockWork alloc] init];
    [stockWork getStockPrice];
    [stockWork setTable:self.tableView];
}

-(void)timerForStack{
    [self.timer invalidate];
    self.timer = nil;
    [self updateStck];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateStck) userInfo:nil repeats:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    self.currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    
    NSURL *url = [NSURL URLWithString: self.currentCompany.companyImageSting];
    UIImage* companyImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
    if (companyImage) {
        cell.imageView.image = companyImage;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"emptystate-homeView.png"];
    }
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.currentCompany.companyName, self.currentCompany.stockTicker];
    cell.detailTextLabel.text = self.currentCompany.currentPrice;
    [cell.detailTextLabel setTextColor: [UIColor grayColor]];
    cell.showsReorderControl = YES;
    
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    
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
        [[Dao sharedDao] deleteCurrentCompanyByIndex:(int)indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    Dao *object = self.companyList[fromIndexPath.row];
    [self.companyList removeObjectAtIndex: fromIndexPath.row];
    [self.companyList insertObject:object atIndex:toIndexPath.row];
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
        self.productViewController.currentCompanyIndex = (int) indexPath.row;
        
        [self.navigationController pushViewController:self.productViewController animated:YES];
    }
}



- (void)dealloc {
    [_tableView release];
    [_redoBtn release];
    [_undoBtn release];
    [_undoRedoBtnStock release];
    [super dealloc];
}
@end
