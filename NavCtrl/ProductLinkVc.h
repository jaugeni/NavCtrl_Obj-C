//
//  ProductLinkVc.h
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/20/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "AddEditProduct.h"

@interface ProductLinkVc : UIViewController

@property (retain, nonatomic)  WKWebView *web;
@property (nonatomic) int currentProductIndex;
@property (retain, nonatomic) ProductClass *currentProduct;
@property (nonatomic) int currentCompanytIndex;

@end
