//
//  Dao.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Dao.h"
#import "Company+CoreDataClass.h"
#import "Product+CoreDataClass.h"


@implementation Dao

+ (Dao *)sharedDao {
    static Dao *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
        
        _sharedInstance.appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
        _sharedInstance.context = _sharedInstance.appDelegate.managedObjectContext;
        _sharedInstance.request = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
        _sharedInstance.managedCompanyList = [[NSMutableArray alloc] initWithArray:[_sharedInstance.context executeFetchRequest:_sharedInstance.request error:nil]];
        if (_sharedInstance.managedCompanyList.count) {
            [_sharedInstance fillCompanyList];
        } else {
            [_sharedInstance createCompanye];
        }
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
    tempCompany.currentPrice = [[NSString alloc] init];
    tempCompany.products = [[NSMutableArray alloc] init];
    [self.companyList addObject:tempCompany];
    
    Company *temp = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.context];
    temp.name = name;
    temp.imageUrl = stringUrl;
    temp.stockTicker = ticker;
    temp.products = [[NSSet alloc] init];
    [self.managedCompanyList addObject:temp];
    [_appDelegate saveContext];
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
    [self.companyList replaceObjectAtIndex:index withObject:currentCompany];
    
    Company *current = self.managedCompanyList[index];
    current.name = name;
    current.imageUrl = stringUrl;
    current.stockTicker = ticker;
        [_appDelegate saveContext];
}



-(void)addNewProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl andCompanyIndex:(int)companyIndex{
    
    ProductClass *tempProduct = [[ProductClass alloc] init];
    tempProduct.productName = name;
    tempProduct.productUrlString = stringUrl;
    tempProduct.productImageString = imageStringUrl;
    CompanyClass *currentCompany = _companyList[companyIndex];
    [currentCompany.products addObject:tempProduct];
    
    Company *currentComp = _managedCompanyList[companyIndex];
    Product *temp = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.context];
    temp.name = name;
    temp.productUrl = stringUrl;
    temp.imageUrl = imageStringUrl;
    temp.company = currentComp;
    [currentComp.products setByAddingObject:temp];
        [_appDelegate saveContext];
}

-(void)editProduct:(NSString*)name withProductLink:(NSString*)stringUrl withImageUrl:(NSString*)imageStringUrl withCompanyIndex:(int)companyIndex andProductIndex:(int)indexProduct;{
    CompanyClass *currentCompany = self.companyList[companyIndex];
    ProductClass *currentProduct = currentCompany.products[indexProduct];
    currentProduct.productName = name;
    currentProduct.productUrlString = stringUrl;
    currentProduct.productImageString = imageStringUrl;
    [currentCompany.products replaceObjectAtIndex:indexProduct withObject: currentProduct];
    
    Company *currComp = self.managedCompanyList[companyIndex];
    NSArray *productsArray = [currComp.products allObjects];
    Product *currProd = productsArray[indexProduct];
    currProd.name = name;
    currProd.imageUrl = imageStringUrl;
    currProd.productUrl = stringUrl;
    currProd.company = currComp;
        [_appDelegate saveContext];
}

-(void)deleteCurrentCompanyByIndex:(int)currentIndex{
    Company *current = self.managedCompanyList[currentIndex];
    [self.context deleteObject:current];
        [_appDelegate saveContext];
    [self.companyList removeObjectAtIndex:currentIndex];
}

-(void)deleteCurrentProductByIndex:(int)currentProductIndex withCompanyIndex:(int)companyIndex{
    Company *currComp = self.managedCompanyList[companyIndex];
    NSMutableArray *productsArray = [[currComp.products allObjects] mutableCopy];
    Product *currProd = productsArray[currentProductIndex];
    [self.context deleteObject:currProd];
        [_appDelegate saveContext];
    
    CompanyClass *currentComp = self.companyList[companyIndex];
    [currentComp.products removeObjectAtIndex:currentProductIndex];
}

-(void)undo{
    
    
    [self.companyList removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        [self.context undo];
        [_appDelegate saveContext];
        self.managedCompanyList = [[NSMutableArray alloc] initWithArray:[self.context executeFetchRequest:self.request error:nil]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            [self fillCompanyList];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTable" object:nil];
            
        });
    });
    
    
}

-(void)redo{
    [self.companyList removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        [self.context redo];
        [_appDelegate saveContext];
        self.managedCompanyList = [[NSMutableArray alloc] initWithArray:[self.context executeFetchRequest:self.request error:nil]];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            [self fillCompanyList];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTable" object:nil];
            
        });
    });
}

-(void)createCompanye{
    CompanyClass *apple = [[CompanyClass alloc] init];
    apple.companyName = @"Apple inc";
    apple.stockTicker = @"AAPL";
    apple.currentPrice = [[NSString alloc] init];
    apple.companyImageSting = @"https://image.freepik.com/free-icon/apple-logo_318-40184.jpg";
    
    ProductClass* macBookPro = [[ProductClass alloc] init];
    macBookPro.productName = @"MackBook Pro";
    macBookPro.productImageString = @"https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/m/bp/mbp15touch/gray/mbp15touch-gray-select-201610?wid=452&hei=420&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1496611018929";
    macBookPro.productUrlString = @"https://www.apple.com/macbook-pro/";
    
    self.companyList = [[NSMutableArray alloc] initWithObjects: apple, nil];
    
    apple.products = [[NSMutableArray alloc] initWithObjects: macBookPro, nil];
    
    self.managedCompanyList = [[NSMutableArray alloc] init];
    
    for (int i =0; i < _companyList.count; i++) {
        CompanyClass* demoComp = _companyList[i];
        Company *saveComp = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.context];
        saveComp.name = demoComp.companyName;
        saveComp.imageUrl = demoComp.companyImageSting;
        saveComp.stockTicker = demoComp.stockTicker;
        
        [_managedCompanyList addObject:saveComp];
        
        saveComp.products = [[NSSet alloc] init];
        
        for (int i=0; i< demoComp.products.count; i++) {
            Product* saveProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.context];
            saveProduct.name = demoComp.products[i].productName;
            saveProduct.productUrl = demoComp.products[i].productUrlString;
            saveProduct.imageUrl = demoComp.products[i].productImageString;
            saveProduct.company = saveComp;
            [saveComp.products setByAddingObject:saveProduct];
        }
        
    }
    //    [_appDelegate saveContext];
}

-(void)fillCompanyList{
    //[self.companyList removeAllObjects];
    self.companyList = [[NSMutableArray alloc] init];
    for (int i =0; i < _managedCompanyList.count; i++) {
        CompanyClass* tempComp = [[CompanyClass alloc] init];
        Company* savedComp = _managedCompanyList[i];
        tempComp.companyName = savedComp.name;
        tempComp.companyImageSting = savedComp.imageUrl;
        tempComp.currentPrice = @"";
        tempComp.stockTicker = savedComp.stockTicker;
        [self.companyList addObject:tempComp];
        
        NSArray *productsArray = [savedComp.products allObjects];
        tempComp.products = [[NSMutableArray alloc] init];
        for (int i=0; i<productsArray.count; i++) {
            ProductClass* tempProduct = [[ProductClass alloc] init];
            Product* savedProduct = productsArray[i];
            tempProduct.productName = savedProduct.name;
            tempProduct.productUrlString = savedProduct.productUrl;
            tempProduct.productImageString = savedProduct.imageUrl;
            [tempComp.products addObject:tempProduct];
        }
    }
}

@end

