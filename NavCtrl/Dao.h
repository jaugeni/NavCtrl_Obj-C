//
//  Dao.h
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NavControllerAppDelegate.h"

#import "CompanyClass.h"
#import "ProductClass.h"
#import "StockWork.h"

@interface Dao : NSObject

+ (Dao *)sharedDao;

@property (nonatomic,retain) NSMutableArray *companyList;
@property(nonatomic,retain) NSMutableArray *managedCompanyList;
@property (nonatomic, assign) NavControllerAppDelegate *appDelegate;
@property (nonatomic, retain) NSFetchRequest *request;
@property (nonatomic, assign) NSManagedObjectContext *context;


-(void)addNewCompany:(NSString*)name withTicker:(NSString*)ticker withImageUrl:(NSString*)stringUrl;
-(void)editCompany:(NSString*)name withTicker:(NSString*)ticker withImageUrl:(NSString*)stringUrl andCompanyIndex:(int)index;

-(void)addNewProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl andCompanyIndex:(int)companyIndex;
-(void)editProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl withCompanyIndex:(int)companyIndex andProductIndex:(int)indexProduct;

-(void)deleteCurrentCompanyByIndex:(int)currentIndex;
-(void)deleteCurrentProductByIndex:(int)currentProductIndex withCompanyIndex:(int)companyIndex;
-(void)undo;
-(void)redo;

@end

