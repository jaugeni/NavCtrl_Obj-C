//
//  ProductVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductLinkVc.h"
#import "AddEditProduct.h"
#import "CompanyClass.h"

@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *companyName;

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) ProductLinkVc *productLinkVC;
@property (nonatomic) int currentCompanyIndex;
@property (nonatomic) BOOL flagIsAddMod;

@end
