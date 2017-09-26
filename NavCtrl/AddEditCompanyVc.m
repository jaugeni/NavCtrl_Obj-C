//
//  AddEditCompanyVc.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "AddEditCompanyVc.h"

@interface AddEditCompanyVc ()

@end

@implementation AddEditCompanyVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(toggleSaveMode)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toggleCancelMode)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    if(!self.flagIsAddMod){
        NSMutableArray *companysArray = [[Dao sharedDao]companyList];
        CompanyClass *currentCompany = companysArray[self.currentCompanyIndex];
        self.addEditCompanyName.text = currentCompany.companyName;
        self.addEditTicker.text = currentCompany.stockTicker;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toggleSaveMode{
    if (self.flagIsAddMod) {
        [[Dao sharedDao] addNewCompany:self.addEditCompanyName.text withTicker:self.addEditTicker.text]; 
    } else {
        [[Dao sharedDao] editCompany:self.addEditCompanyName.text withTicker:self.addEditTicker.text andCompanyIndex:self.currentCompanyIndex];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toggleCancelMode{
    [self.navigationController popViewControllerAnimated:YES];
}

// TODO: Make keyboad appear whan I will be have all textfield
//MARK: move keyboard up



- (void)dealloc {
    [_addEditCompanyName release];
    [_addEditTicker release];
    [_addEditImageUrl release];
    [super dealloc];
}
@end
