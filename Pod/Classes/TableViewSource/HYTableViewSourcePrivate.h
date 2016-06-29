//
//  HYTableViewSourcePrivate.h
//  Pods
//
//  Created by fangyuxi on 16/6/15.
//
//

#import "HYTableViewSource.h"

#ifndef HYTableViewSourcePrivate_h
#define HYTableViewSourcePrivate_h

@interface HYTableViewSource ()
{
    
}

//根据ModelClass返回CellClass
- (Class)cellClassForCellViewModelClass:(Class)aClass;
//根据CellClass返回重用标识符
- (NSString *)cellIdentifierForCellViewModelClass:(Class)aClass;

//根据ModelClass返回FooterHeaderClass
- (Class)footerHeaderclassForFooterHeaderModelClass:(Class)aClass;
//根据FooterHeaderClass返回重用标识符
- (NSString *)identifierForFooterHeaderModelClass:(Class)aClass;

@end


#endif /* HYTableViewSourcePrivate_h */
