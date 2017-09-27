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
@property (nonatomic, assign) UITableView *table;

-(void)addNewCompany:(NSString*)name withTicker:(NSString*)ticker withImageUrl:(NSString*)stringUrl;
-(void)editCompany:(NSString*)name withTicker:(NSString*)ticker withImageUrl:(NSString*)stringUrl andCompanyIndex:(int)index;

-(void)addNewProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl andCompany:(NSMutableArray*)array;
-(void)editProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl withProduct:(ProductClass*)currentProduct andProductIndex:(int)index;
@end
