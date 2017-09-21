//
//  CompanyVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"
#import "CompanyClass.h"

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) ProductVC *productViewController;

@property (nonatomic, retain) CompanyClass *apple;
@property (nonatomic, retain) CompanyClass *samsung;
@property (nonatomic, retain) CompanyClass *google;
@property (nonatomic, retain) CompanyClass *tesla;

@end
