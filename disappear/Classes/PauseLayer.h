//
//  PauseLayer.h
//  disappear
//
//  Created by CpyShine on 13-6-6.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PauseLayer : CCLayerColor {
    
    CCMenuItemImage * m_resume;
    CCMenuItemImage * m_restart;
    CCMenuItemImage * m_exittomain;
    
}

-(void) startAnimationDiaplay;

@end
