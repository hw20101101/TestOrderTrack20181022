//
//  CustomView.h
//  TestOrderTrack20181022
//
//  Created by 快摇002 on 2018/11/6.
//  Copyright © 2018 aiitec. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomView : UILabel{
    BOOL testHits;
}

@property (nonatomic, copy) NSArray *passthroughViews;

-(BOOL) isPassthroughView: (UIView*) view;

@end

NS_ASSUME_NONNULL_END
