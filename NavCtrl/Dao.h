//
//  Dao.h
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyClass.h"
#import "ProductClass.h"
#import "StockWork.h"

@interface Dao : NSObject
+ (Dao *)sharedDao;

@property (nonatomic,retain) NSMutableArray *companyList;

-(void)addNewCompany:(NSString*)name withTicker:(NSString*)ticker;
-(void)editCompany:(NSString*)name withTicker:(NSString*)ticker andCompanyIndex:(int)index;

-(void)addNewProduct:(NSString*)name withCompany:(NSMutableArray*)array;
-(void)editProduct:(NSString*)name withProduct:(ProductClass*)currentProduct andProductIndex:(int)index;
@end
