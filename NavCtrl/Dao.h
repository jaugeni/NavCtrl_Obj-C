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

@interface Dao : NSObject
+ (Dao *)sharedDao;

@property (nonatomic,retain) NSMutableArray *companyList;

-(void)addNewCompany:(NSString*)name;
-(void)addNewProduct:(NSString*)name withCompany:(NSMutableArray*)array;
@end
