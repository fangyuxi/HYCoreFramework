//
//  HYDataPresenterProtocal.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/15.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#ifndef HYDataPresenterProtocal_h
#define HYDataPresenterProtocal_h

//@protocol HYDataPresenterSourceDataProtocal <NSObject>
//
//@property (nonatomic, strong) id content;
//@property (nonatomic, copy) NSString *businessName;
//
//@end


/**
 *  网络层和数据层（有可能是本地数据），向View层提供标准化展示数据的对象。
 
    从request中回来的数据，我们一般不能直接显示，
 
    通常的做法是，将数据在request中处理后再返回，或者request只返回原始数据类型然后
 
    view自己做转化，（我们的项目中由于网络层比较薄，所以很多数据都是在controller
 
    里面自己处理了。） ，所以可以创建一个遵循 HYDataPresenterProtocal 的对象，接受
 
    request的原始数据，给View提供可供显示的数据。
 
    如果同样的业务，但是是不同的接口返回的数据，格式不统一，那么presenter可以通过name
 
    来区分不同的业务（接口），返回同样的数据给view层展示。
 
    列表页中使用tableViewSource和CellModel共同完成了这个职责
 
 */
@protocol HYDataPresenterProtocal <NSObject>

@required
- (id)dataPresenterWithSourceData:(id)sourceData businessName:(NSString *)name;

//@optional
//- (id)dataPresenterWithSourceData:(id<HYDataPresenterSourceDataProtocal>)sourceData;

@property (nonatomic, strong)NSError *error;

@end

#endif /* HYDataPresenterProtocal_h */
