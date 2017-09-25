//
//  AddEditProduct.h
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductClass.h"

@interface AddEditProduct : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *addEditProductName;
@property (retain, nonatomic) NSMutableArray *product;
@property (retain, nonatomic) ProductClass *currentProduct;
@property (nonatomic) int currentProductIndex;
@property (nonatomic) BOOL flagIsAddMod;
@end
