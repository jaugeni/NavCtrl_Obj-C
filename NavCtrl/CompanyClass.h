//
//  CompanyClass.h
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductClass.h"

@interface CompanyClass : NSObject
@property (nonatomic, retain) NSString* companyName;
@property (nonatomic, retain) NSString* stockTicker;
@property (nonatomic, retain) NSString* companyImageSting;
@property (nonatomic, retain) NSString* currentPrice;
@property (nonatomic, retain) NSMutableArray<ProductClass*>* products;
@end
