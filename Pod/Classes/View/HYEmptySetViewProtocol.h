//
//  HYEmptySetViewProtocol.h
//  Pods
//
//  Created by fangyuxi on 16/3/30.
//
//

#ifndef HYEmptySetViewProtocol_h
#define HYEmptySetViewProtocol_h

typedef void(^HYEmptyDataSetActions)(NSString *events);

@protocol HYEmptySetViewProtocol <NSObject>

@optional
@property (nonatomic, copy) HYEmptyDataSetActions emptyDataSetActions;
@property (nonatomic, assign) CGFloat verticalOffset;

@end

#endif /* HYEmptySetViewProtocol_h */
