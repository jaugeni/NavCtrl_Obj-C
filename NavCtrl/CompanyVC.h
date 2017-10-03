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
#import "AddEditCompanyVc.h"

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UIStackView *undoRedoBtnStock;
@property (retain, nonatomic) IBOutlet UIButton *redoBtn;
@property (retain, nonatomic) IBOutlet UIButton *undoBtn;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)redoPressed:(id)sender;
- (IBAction)undoPressed:(id)sender;

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) ProductVC *productViewController;
@property (nonatomic, retain) CompanyClass* currentCompany;
@property (nonatomic) BOOL flagIsAddMod;

@end
