//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"
#import "ProductClass.h"

@interface ProductVC ()
@property (nonatomic)ProductClass *iPad;
@property (nonatomic)ProductClass *iPodTouch;
@property (nonatomic)ProductClass *iPhone;
@property (nonatomic)ProductClass *galaxyS4;
@property (nonatomic)ProductClass *galaxyNote;
@property (nonatomic)ProductClass *galaxyTab;
@property (nonatomic)ProductClass *googleCom;
@property (nonatomic)ProductClass *pixel;
@property (nonatomic)ProductClass *chrome;
@property (nonatomic)ProductClass *modelX;
@property (nonatomic)ProductClass *powerwall;
@property (nonatomic)ProductClass *solarPanels;

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)toggleEditMode {
    
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.navigationItem.rightBarButtonItem.title = @"Done";
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.products = [NSMutableArray arrayWithCapacity:1];
    
    self.iPad = [[ProductClass alloc] init];
    self.iPodTouch = [[ProductClass alloc] init];
    self.iPhone = [[ProductClass alloc] init];
    self.galaxyS4 = [[ProductClass alloc] init];
    self.galaxyNote = [[ProductClass alloc] init];
    self.galaxyTab = [[ProductClass alloc] init];
    self.googleCom = [[ProductClass alloc] init];
    self.pixel = [[ProductClass alloc] init];
    self.chrome = [[ProductClass alloc] init];
    self.modelX = [[ProductClass alloc] init];
    self.powerwall = [[ProductClass alloc] init];
    self.solarPanels = [[ProductClass alloc] init];
    
    self.iPad.productName = @"iPad";
    self.iPodTouch.productName = @"iPod Touch";
    self.iPhone.productName = @"iPhone";
    self.galaxyS4.productName = @"Galaxy S4";
    self.galaxyNote.productName = @"Galaxy Note";
    self.galaxyTab.productName = @"Galaxy Tab";
    self.googleCom.productName = @"google.com";
    self.pixel.productName = @"google pixel";
    self.chrome.productName = @"Chrome";
    self.modelX.productName = @"Model X";
    self.powerwall.productName = @"Powerwall";
    self.solarPanels.productName = @"Solar Panels";
    
    if ([self.title isEqualToString:@"Apple inc"]) {
        [self.products addObjectsFromArray:@[self.iPad.productName, self.iPodTouch.productName, self.iPhone.productName]];
    } else if ([self.title isEqualToString:@"Samsung inc"]) {
        [self.products addObjectsFromArray:@[self.galaxyS4.productName, self.galaxyNote.productName, self.galaxyTab.productName]];
    } else if ([self.title isEqualToString:@"Google inc"]) {
        [self.products addObjectsFromArray:@[self.googleCom.productName, self.pixel.productName, self.chrome.productName]];
    } else if ([self.title isEqualToString: @"Tesla inc"]) {
        [self.products addObjectsFromArray:@[self.modelX.productName, self.powerwall.productName, self.solarPanels.productName]];
    }
        [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
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
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
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
    // Navigation logic may go here, for example:
    // Create the next view controller.
    self.productLinkVC = [[ProductLinkVc alloc]init];
    
    self.productLinkVC.title = [self.products objectAtIndex:[indexPath row]];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    
    
    [self.navigationController pushViewController:self.productLinkVC animated:YES];
}




- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
