//
//  AddEditProduct.h
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductClass.h"

@interface AddEditProduct : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *addEditProductName;

@property (retain, nonatomic) IBOutlet UITextField *addEditingProductLink;
@property (retain, nonatomic) IBOutlet UITextField *addEditImageProduct;

@property (retain, nonatomic) NSMutableArray *product;
@property (retain, nonatomic) ProductClass *currentProduct;
@property (nonatomic) int currentProductIndex;
@property (nonatomic) BOOL flagIsAddMod;
@end
