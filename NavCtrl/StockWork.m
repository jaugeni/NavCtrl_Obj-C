//
//  StockWork.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/26/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "StockWork.h"
#import "Dao.h"

@implementation StockWork

- (void) getStockPrice{
    
    NSMutableString *tickers = [[NSMutableString alloc] init];
    NSMutableArray* companyList = [[Dao sharedDao] companyList];
    for (int i = 0; i < companyList.count; i++) {
        CompanyClass* currentCompany = companyList[i];
        if (i == companyList.count - 1){
            [tickers appendFormat:@"%@", currentCompany.stockTicker];
        } else {
            [tickers appendFormat:@"%@+", currentCompany.stockTicker];
        }
    }
    NSString *url= [NSString stringWithFormat: @"https://download.finance.yahoo.com/d/quotes.csv?s=%@&f=nl1",tickers];
    NSURL *urlone = [NSURL URLWithString:url];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:urlone completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                              
                                              if(error){
                                                  
                                              } else {
                                                  NSArray *seporetByCompany = [responseData componentsSeparatedByString:@"\n"];
                                                  for (int i = 0; i < seporetByCompany.count-1; i++) {
                                                      CompanyClass* currentCompany = companyList[i];
                                                      NSArray *getPrice = [seporetByCompany[i] componentsSeparatedByString:@","];
                                                      currentCompany.currentPrice = getPrice[getPrice.count - 1];

                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          [self.table reloadData];
                                                      });

                                                      
                                                      
                                                  }
                                              }
                                          }];
    
    [downloadTask resume];
}
@end
