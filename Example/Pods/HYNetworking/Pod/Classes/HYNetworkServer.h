//
//  HYNetworkServer.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>


//任何的server必须继承这个协议
@protocol HYNetworkServerProtocal <NSObject>

@property (nonatomic, readonly)NSString *serverName;
@property (nonatomic, assign, getter=isOnline)BOOL online;
@property (nonatomic, assign, getter=isVerify)BOOL verify;
@property (nonatomic, readonly)NSString *baseUrl;

@end

@interface HYNetworkServer : NSObject<HYNetworkServerProtocal>
{
    
}



@end
