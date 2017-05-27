# 废弃

[![CI Status](http://img.shields.io/travis/fangyuxi/HYCoreFramework.svg?style=flat)](https://travis-ci.org/fangyuxi/HYCoreFramework)
[![Version](https://img.shields.io/cocoapods/v/HYCoreFramework.svg?style=flat)](http://cocoapods.org/pods/HYCoreFramework)
[![License](https://img.shields.io/cocoapods/l/HYCoreFramework.svg?style=flat)](http://cocoapods.org/pods/HYCoreFramework)
[![Platform](https://img.shields.io/cocoapods/p/HYCoreFramework.svg?style=flat)](http://cocoapods.org/pods/HYCoreFramework)

## 废弃

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HYCoreFramework is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HYCoreFramework"
```
## Section Row Maker 

```objc
        //列表页section
        [self updateSection:maker.section userMaker:^(WBPTTableViewSourceSectionMaker *maker) {
                                
              maker.deleteAllRows();
              //cells
              for (NSInteger index = 0; index < [infoList count]; ++index)
               {
                  NSDictionary *dic = [infoList objectAtIndex:index];
                                    
                  if ([dic isKindOfClass:[NSDictionary class]])
                  {
                    WBPTMainJobCellModel *model = [[WBPTMainJobCellModel alloc]
                                                      initWithDictionary:[infoList objectAtIndex:index]];
                    [model calculateCellElementFrame];
                    maker.addRow(model).rowPosition([WBPTBaseCell plainStyleWithIndex:index Count:[infoList count]]);
                  }
                 }
         }];
                            
                            //列表页section
                [self makeSection:^(WBPTTableViewSourceSectionMaker *maker) {
                    
                    //identifier
                    maker.setIdentifier(@"WBPTMainJobCellModel");
                    
                    //filterView as sectoinHeader
                    WBPTMainFilterSectionHeaderView *filterView = [[WBPTMainFilterSectionHeaderView alloc] initWithReuseIdentifier:nil];
                    maker.addUnReusedSectionHeaderView(filterView);
                    
                    //cells
                    for (NSInteger index = 0; index < [infoList count]; ++index)
                    {
                        NSDictionary *dic = [infoList objectAtIndex:index];
                        
                        if ([dic isKindOfClass:[NSDictionary class]])
                        {
                            WBPTMainJobCellModel *model = [[WBPTMainJobCellModel alloc]
                                                           initWithDictionary:[infoList objectAtIndex:index]];
                            [model calculateCellElementFrame];
                            maker.addRow(model).rowPosition([WBPTBaseCell plainStyleWithIndex:index Count:[infoList count]]);
                        }
                    }
                }];
```

## Author

fangyuxi, xcoder.fang@gmail.com

## License

HYCoreFramework is available under the MIT license. See the LICENSE file for more info.
