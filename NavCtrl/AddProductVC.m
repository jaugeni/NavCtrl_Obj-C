//
//  AddProductVC.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "AddProductVC.h"
#import "Dao.h"

@interface AddProductVC ()

@end

@implementation AddProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(toggleSaveMode)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationController.navigationBar.topItem.title = @"Cancel";
//    self.navigationController.navigationBar.topItem.rightBarButtonItem.image = [UIImage imageNamed:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toggleSaveMode{
    
    [[Dao sharedDao] addNewProduct:self.addProduct.text withCompany:self.products];
//    [[Dao sharedDao] addNewProduct:self.addProduct.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc {
    [_addProduct release];
    [super dealloc];
}
@end
