//
//  MatchHudLayer.h
//  disappear
//
//  Created by CpyShine on 13-6-20.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MatchHudLayer : CCLayer<UIAlertViewDelegate> {
    BOOL hasResponse;
}

-(void) reveiveMessage:(NSDictionary*)dic Error:(NSDictionary*) error;

@end
