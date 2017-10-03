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
     UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-navBack"] style:NO target:self action:@selector(toggleBackMode)];
    
    self.web = [WKWebView new];
    
    [self.view addSubview:self.web];
    
    self.navigationItem.rightBarButtonItem = editButton;
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.web.frame = self.view.bounds;
    if([self validateUrl:self.currentProduct.productUrlString]){
        NSURL *url = [NSURL URLWithString: self.currentProduct.productUrlString];
            NSURLRequest *myRequest = [NSURLRequest requestWithURL:url];
            [self.web loadRequest:myRequest];
    }else{
        NSLog(@"Not valid URL");
    }
    
    self.title = self.currentProduct.productName;
    
}

- (void)toggleEditMode {
    AddEditProduct* addEditProductVC = [[AddEditProduct alloc]init];
    addEditProductVC.title = @"Edit Product";
    addEditProductVC.flagIsAddMod = NO;
    addEditProductVC.currentProductIndex = self.currentProductIndex;
    addEditProductVC.currentProduct = self.currentProduct;
    addEditProductVC.currentCompanyIndex = self.currentCompanytIndex;
    [self.navigationController pushViewController:addEditProductVC animated:YES];
}

-(void)toggleBackMode{
    [self.navigationController popViewControllerAnimated:YES];
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
