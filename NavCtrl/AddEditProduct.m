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
        self.addEditingProductLink.text = self.currentProduct.productUrlString;
        self.addEditImageProduct.text = self.currentProduct.productImageString;
    }
    
    self.addEditProductName.delegate = self;
    self.addEditImageProduct.delegate = self;
    self.addEditingProductLink.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toggleSaveMode{
    if (self.flagIsAddMod) {
        [[Dao sharedDao] addNewProduct:self.addEditProductName.text withProductLink:self.addEditingProductLink.text withImageUrl:self.addEditImageProduct.text andCompany:self.product];
        
    } else {
        
        [[Dao sharedDao] editProduct:self.addEditProductName.text withProductLink:self.addEditingProductLink.text withImageUrl:self.addEditImageProduct.text withProduct:self.currentProduct andProductIndex:self.self.currentProductIndex];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toggleCancelMode{
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: move keyboard up

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.addEditImageProduct.isFirstResponder){
        NSValue* keyboardFrameBegin = [[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey];
        
        CGRect keyboardFrame = [keyboardFrameBegin CGRectValue];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardFrame.size.height;
            self.view.frame = f;
        }];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    if (self.addEditImageProduct.isFirstResponder){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = 0.0f;
            self.view.frame = f;
        }];
    }
}


// MARK: textfield


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
- (void)dealloc {
    [_addEditProductName release];
    [_addEditingProductLink release];
    [_addEditImageProduct release];
    [super dealloc];
}
@end
