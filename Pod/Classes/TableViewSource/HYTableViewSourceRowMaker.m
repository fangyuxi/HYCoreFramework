//
//  HYTableViewSourceRowMaker.m
//  Pods
//
//  Created by fangyuxi on 16/6/14.
//
//

#import "HYTableViewSourceRowMaker.h"

@implementation HYTableViewSourceRowMaker

- (instancetype)initWithModel:(HYBaseCellModel *)model
{
    self = [super init];
    if (self)
    {
        model == nil ? (_model = [[HYBaseCellModel alloc] init]) : (_model = model);
        return self;
    }
    return nil;
}

- (HYTableViewSourceRowMaker *(^)(HYCustomCellPosition))rowPosition
{
    return ^HYTableViewSourceRowMaker *(HYCustomCellPosition rowPosition){
    
        self.model.position = rowPosition;
        return self;
        
    };
}
@end
