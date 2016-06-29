//
//  HYTableViewSourceRowMaker.h
//  Pods
//
//  Created by fangyuxi on 16/6/14.
//
//

#import <Foundation/Foundation.h>
#import "HYBaseCellModel.h"

@interface HYTableViewSourceRowMaker : NSObject
{
    
}

- (instancetype)initWithModel:(HYBaseCellModel *)model;

- (HYTableViewSourceRowMaker *(^)(HYCustomCellPosition))rowPosition;

@property (nonatomic, strong) HYBaseCellModel *model;

@end
