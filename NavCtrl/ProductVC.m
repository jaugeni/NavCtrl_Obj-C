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
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-navBack"] style:NO target:self action:@selector(toggleBackMode)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.leftBarButtonItem = backBtn;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableArray *companyList = [[Dao sharedDao] companyList];
    CompanyClass *currentCompany = companyList[self.currentCompanyIndex];
    
    NSURL *url = [NSURL URLWithString: currentCompany.companyImageSting];
    UIImage* companyImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
    
    if (companyImage){
        self.image.image = companyImage;
    } else {
        self.image.image = [UIImage imageNamed:@"emptystate-homeView"];
    }
    self.companyName.text = [NSString stringWithFormat:@"%@ (%@)", currentCompany.companyName, currentCompany.stockTicker];
    
    
    [self.tableView reloadData];
}

-(void)toggleAddMode {
    
    AddEditProduct* addEditProductVC = [[AddEditProduct alloc]init];
    addEditProductVC.title = @"Add Product";
    addEditProductVC.currentCompanyIndex = self.currentCompanyIndex;
    addEditProductVC.flagIsAddMod = YES;
    
    [self.navigationController pushViewController:addEditProductVC animated:YES];
}

-(void)toggleBackMode{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    ProductClass* product = [self.products objectAtIndex:[indexPath row]];
    
    NSURL *url = [NSURL URLWithString: product.productImageString];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
    if (image) {
        cell.imageView.image = image;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"emptystate-homeView.png"];
    }
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.textLabel.text = product.productName;
    cell.showsReorderControl = YES;
    
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
    
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        AddEditProduct* addEditProductVC = [[AddEditProduct alloc]init];
                                        addEditProductVC.title = @"Edit Product";
                                        addEditProductVC.flagIsAddMod = NO;
                                        addEditProductVC.currentProductIndex = (int) indexPath.row;
                                        addEditProductVC.currentProduct = self.products[indexPath.row];
                                        addEditProductVC.currentCompanyIndex = self.currentCompanyIndex;
                                        [self.navigationController pushViewController:addEditProductVC animated:YES];
                                    }];
    button.backgroundColor = [UIColor greenColor]; //arbitrary color
    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         [[Dao sharedDao] deleteCurrentProductByIndex:(int)indexPath.row withCompanyIndex:self.currentCompanyIndex];
                                         [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                     }];
    button2.backgroundColor = [UIColor redColor]; //arbitrary color
    
    return @[button2, button]; //array with all the buttons you want. 1,2,3, etc...
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.productLinkVC = [[ProductLinkVc alloc]init];
    ProductClass* product = [self.products objectAtIndex:[indexPath row]];
    
    self.productLinkVC.title = product.productName;
    self.productLinkVC.currentProductIndex = (int) indexPath.row;
    self.productLinkVC.currentProduct = product;
    self.productLinkVC.currentCompanytIndex = self.currentCompanyIndex;
    [self.navigationController pushViewController:self.productLinkVC animated:YES];
}




- (void)dealloc {
    [_tableView release];
    [_image release];
    [_companyName release];
    [super dealloc];
}
@end
