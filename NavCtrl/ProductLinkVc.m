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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.web = [WKWebView new];
    
    [self.view addSubview:self.web];
    
    
    // Do any additional setup after loading the view from its nib.

}

-(void)viewWillAppear:(BOOL)animated {
    
    self.web.frame = self.view.bounds;
    NSURL *url = [NSURL URLWithString:@"https://www.chase.com"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:myRequest];
    
//    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
//                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//                                              [self.webView loadRequest:myRequest];
//
//                                              if (!error){
//                                                  [self.webView loadRequest:myRequest];
//                                              }
//                                              // 4: Handle response here
//                                          }];
//
//    [downloadTask resume];
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
