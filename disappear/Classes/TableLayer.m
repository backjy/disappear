//
//  TableLayer.m
//  disappear
//
//  Created by CpyShine on 13-6-7.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "TableLayer.h"

#import "DataController.h"


@implementation TableLayer


- (id)init
{
    self = [super init];
    if (self) {
        
        m_localLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:200 height:150];
        
        m_worldLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:200 height:150];
        
        [m_worldLayer setPosition:ccp(220, 0)];
        
        [self addChild:m_localLayer];
        
        [self addChild:m_worldLayer];
        
        m_pageMaxCount = 2;
        m_pageCurrent = 1;
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
}

-(void)loadLoaclLayer:(NSInteger)score{
    
    
    [m_localLayer removeAllChildren];
    
    CCLabelTTF * tile = [CCLabelTTF labelWithString:@"you top score" fontName:@"Arial" fontSize:14];
    
    [tile setPosition:ccp(m_localLayer.contentSize.width/2, m_localLayer.contentSize.height+10)];
    [m_localLayer addChild:tile];
    
    NSArray *  scorearray = [[DataController getSharedDataController] readLoaclScoreTopList];
    
    NSObject * object;
    NSInteger count = 6;
    BOOL flag = true;
    
//    [self loadWorldTopList:score];
    
    if (scorearray.count==0) {
        [self setNoDataInlist:m_localLayer];
    }
    
    [self loadWorldTopList:1];
    
    for (object in scorearray) {
        
        if (![object isKindOfClass:[NSNumber class]]) {
            continue;
        }
        
        NSNumber * number = (NSNumber*)object;
        int nu = number.integerValue;
        
        CCLabelTTF * scorelabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",nu] fontName:@"Arial" fontSize:18];
        CCLabelTTF * namelabel = [CCLabelTTF labelWithString:@"YOU" fontName:@"Arial" fontSize:14];
        
        if (score == nu && flag) {
            flag = false;
            [scorelabel setColor:ccc3(255, 0, 0)];
            [namelabel setColor:ccc3(255, 0, 0)];
        }else{
            [scorelabel setColor:ccc3(0, 0, 0)];
            [namelabel setColor:ccc3(0, 0, 0)];
        }
        
        [scorelabel setAnchorPoint:ccp(1,0)];
        [scorelabel setPosition:ccp(150, 20*count)];
        
        [namelabel setAnchorPoint:ccp(0, 0)];
        [namelabel setPosition:ccp(15, 21*count)];
        
        [m_localLayer addChild:scorelabel];
        [m_localLayer addChild:namelabel];
        count --;
    }
}

-(void) loadWorldTopList:(NSInteger)score{
    
    
    [m_worldLayer removeAllChildren];
    
    CCLabelTTF * tile = [CCLabelTTF labelWithString:@"world top score" fontName:@"Arial" fontSize:14];
    
    [tile setPosition:ccp(m_localLayer.contentSize.width/2, m_localLayer.contentSize.height+10)];
    [m_worldLayer addChild:tile];
    
    
    NSDictionary * dic = [[DataController getSharedDataController] readWorldScpreTopList];
    
    if (!dic) {
        [self setNoDataInlist:m_worldLayer];
        return;
    }
    
    NSArray *  scorearray = [dic objectForKey:@"score"];
    NSArray *  nameArray = [dic objectForKey:@"name"];
    
    if (!scorearray || !nameArray) {
        [self setNoDataInlist:m_worldLayer];
        return;
    }
    NSInteger count = 6;
    BOOL flag = true;
    
    [self loadWorldTopList:score];
    
    if (scorearray.count==0) {
        [self setNoDataInlist:m_worldLayer];
        return;
    }
    
    for (int i = 0; i<scorearray.count;i++) {
        
        NSNumber * number = [scorearray objectAtIndex:i];
        
        if (!number) {
            continue;
        }
        
        int nu = number.integerValue;
        
        CCLabelTTF * scorelabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",nu] fontName:@"Arial" fontSize:18];
        CCLabelTTF * namelabel = [CCLabelTTF labelWithString:[nameArray objectAtIndex:i] fontName:@"Arial" fontSize:14];
        
        if (score == nu && flag) {
            flag = false;
            [scorelabel setColor:ccc3(255, 0, 0)];
            [namelabel setColor:ccc3(255, 0, 0)];
        }else{
            [scorelabel setColor:ccc3(0, 0, 0)];
            [namelabel setColor:ccc3(0, 0, 0)];
        }
        
        [scorelabel setAnchorPoint:ccp(1,0)];
        [scorelabel setPosition:ccp(135, 20*count)];
        
        [namelabel setAnchorPoint:ccp(0, 0)];
        [namelabel setPosition:ccp(15, 21*count)];
        
        [m_localLayer addChild:scorelabel];
        [m_localLayer addChild:namelabel];
        count --;
    }
}

-(void) setNoDataInlist:(CCLayer*) l{
    
    CCLabelTTF * alert = [CCLabelTTF labelWithString:@"目前没有记录!"fontName:@"Arial" fontSize:18];
    [alert setColor:ccc3(10, 10, 10)];
    [alert setPosition:ccp(80, 75)];
    [l addChild:alert];
}

-(void)leftPageMove:(CGFloat)distance{
    if (m_pageCurrent<=1) {
        m_pageCurrent = 1;
        return;
    }
//    NSLog(@"left move");
    m_pageCurrent --;
    [self stopAllActions];
    CGPoint pos = self.position;
    CCMoveTo * moveto = [CCMoveTo actionWithDuration:0.2 position:ccp(pos.x + distance+20, pos.y)];
    CCMoveTo * moveto2 = [CCMoveTo actionWithDuration:0.2 position:ccp(pos.x + distance, pos.y)];
    [self runAction:[CCSequence actionOne:moveto two:moveto2]];
}

-(void)rightPageMove:(CGFloat)distance{
    
    if (m_pageCurrent>=m_pageMaxCount) {
        m_pageCurrent = m_pageMaxCount;
        return;
    }
//    NSLog(@"right move");
    m_pageCurrent ++;
    [self stopAllActions];
    CGPoint pos = self.position;
    CCMoveTo * moveto = [CCMoveTo actionWithDuration:0.2 position:ccp(pos.x - distance-20, pos.y)];
    CCMoveTo * moveto2 = [CCMoveTo actionWithDuration:0.2 position:ccp(pos.x -distance, pos.y)];
    [self runAction:[CCSequence actionOne:moveto two:moveto2]];
}

@end
