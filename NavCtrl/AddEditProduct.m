//
//  AddEditProduct.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "AddEditProduct.h"
#import "Dao.h"

@interface AddEditProduct ()

@end

@implementation AddEditProduct

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(toggleSaveMode)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toggleCancelMode)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    if(!self.flagIsAddMod){
        self.addEditProductName.text = self.currentProduct.productName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toggleSaveMode{
    if (self.flagIsAddMod) {
        [[Dao sharedDao] addNewProduct:self.addEditProductName.text withCompany:self.product];
    } else {
        
        [[Dao sharedDao] editProduct:self.addEditProductName.text withProduct:self.currentProduct andProductIndex:self.currentProductIndex];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toggleCancelMode{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_addEditProductName release];
    [super dealloc];
}
@end
