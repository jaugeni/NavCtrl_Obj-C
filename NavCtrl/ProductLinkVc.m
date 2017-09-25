//
//  ProductLinkVc.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/20/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductLinkVc.h"

@interface ProductLinkVc ()

@end

@implementation ProductLinkVc

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    
    self.web = [WKWebView new];
    
    [self.view addSubview:self.web];
    
    self.navigationItem.rightBarButtonItem = editButton;
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.web.frame = self.view.bounds;
    NSURL *url = [NSURL URLWithString:@"https://www.chase.com"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:myRequest];
    
    self.title = self.currentProduct.productName;

}

- (void)toggleEditMode {
    AddEditProduct* addEditProductVC = [[AddEditProduct alloc]init];
    addEditProductVC.title = @"Edit Product";
    addEditProductVC.flagIsAddMod = NO;
    addEditProductVC.currentProductIndex = self.currentProductIndex;
    addEditProductVC.currentProduct = self.currentProduct;
    [self.navigationController pushViewController:addEditProductVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_web release];
    [super dealloc];
}
@end
