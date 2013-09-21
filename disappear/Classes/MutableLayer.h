//
//  MutableLayer.h
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MutableLayer : CCLayerColor {
    CGFloat radiues;
    CGPoint centerPos;
    BOOL    m_started;
    CGFloat m_angle;
    CGFloat m_timeCtrl;
    CGFloat m_r;
}

-(void) startAnimation;

@end
