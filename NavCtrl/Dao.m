//
//  Dao.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Dao.h"


@implementation Dao

+ (Dao *)sharedDao {
    static Dao *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance createCompanye];
    });
    
    return _sharedInstance;
}

-(void)addNewCompany:(NSString*)name withTicker:(NSString*)ticker withImageUrl:(NSString*)stringUrl{
    CompanyClass *tempCompany = [[CompanyClass alloc] init];
    tempCompany.companyName = name;
    if ([ticker isEqualToString:@""])  {
        tempCompany.stockTicker = @"N/A";
    } else {
        tempCompany.stockTicker = ticker;
    }
    tempCompany.companyImageSting = stringUrl;
    tempCompany.companyImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:stringUrl]]];
    tempCompany.currentPrice = [[NSString alloc] init];
    tempCompany.products = [[NSMutableArray alloc] init];
    [self.companyList addObject:tempCompany];
}

-(void)editCompany:(NSString*)name withTicker:(NSString*)ticker withImageUrl:(NSString*)stringUrl andCompanyIndex:(int)index{
    CompanyClass* currentCompany = self.companyList[index];
    currentCompany.companyName = name;
    if (ticker == NULL) {
        currentCompany.stockTicker = @"N/A";
    } else {
        currentCompany.stockTicker = ticker;
    }
    currentCompany.companyImageSting = stringUrl;
    currentCompany.companyImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:stringUrl]]];
    [self.companyList replaceObjectAtIndex:index withObject:currentCompany];
}

-(void)addNewProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl andCompany:(NSMutableArray*)array{
    
    ProductClass *tempProduct = [[ProductClass alloc] init];
    tempProduct.productName = name;
    tempProduct.productUrl = [NSURL URLWithString:stringUrl];
    tempProduct.productImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:imageStringUrl]]];
    tempProduct.productUrlString = stringUrl;
    tempProduct.productImageString = imageStringUrl;
    [array addObject:tempProduct];
}

-(void)editProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl withProduct:(ProductClass*)currentProduct andProductIndex:(int)index{
    currentProduct.productName = name;
    currentProduct.productUrl = [NSURL URLWithString:stringUrl];
    currentProduct.productImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:imageStringUrl]]];
    currentProduct.productUrlString = stringUrl;
    currentProduct.productImageString = imageStringUrl;
    [self.companyList replaceObjectAtIndex:index withObject:currentProduct];
}



-(void)createCompanye{
    
    CompanyClass *apple = [[CompanyClass alloc] init];
    
    apple.companyName = @"Apple inc";
    apple.stockTicker = @"AAPL";
    apple.currentPrice = [[NSString alloc] init];
    apple.companyImage = [UIImage imageNamed:@"Apple inc"];
    
    ProductClass* macBookPro = [[ProductClass alloc] init];
    macBookPro.productName = @"MackBook Pro";
    macBookPro.productImage = [UIImage imageNamed:@"SG1"];
    macBookPro.productUrl = [NSURL URLWithString:@"https://www.apple.com/macbook-pro/"];
    
    self.companyList = [[NSMutableArray alloc] initWithObjects: apple, nil];
    
    apple.products = [[NSMutableArray alloc] initWithArray:@[macBookPro]];
    
}

@end
