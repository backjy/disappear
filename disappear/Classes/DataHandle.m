//
//  DataHandle.m
//  disappear
//
//  Created by CpyShine on 13-5-29.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "DataHandle.h"

#include "SimpleAudioEngine.h"

#import "DrawSprite.h"
#import "DotPlayingScnen.h"

@implementation DataHandle


static inline int calcIndex(int x,int y){
    return TOTALX * y + x;
}

- (id)init
{
    self = [super initWithColor:ccc4(255, 255, 255, 255)];//WithColor:ccc4(230, 230, 230, 255)
    if (self) {
        
        m_drawSpriteArray = [[NSMutableArray alloc]init];
        
        for (int y = 0; y<TOTALY; y++) {
            for (int x = 0; x<TOTALX; x++) {
                
                DrawSprite * drawS = [DrawSprite node];
                
                [drawS spawnAtX:x Y:y Width:DRAWSPRITE_WIDTH Height:DRAWSPRITE_HEIGH];
                
                [m_drawSpriteArray addObject:drawS];
                
                [self addChild:drawS z:1];
            }
        }
        m_stackArray = [[NSMutableArray alloc]init];
        
    
    }
    self.visible = false;
    [self loadEffectSounds];
    return self;
}

-(void) loadEffectSounds{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/1.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/2.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/3.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/4.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/5.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/6.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/7.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/8.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/9.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/10.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/11.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/12.aif"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/13.aif"];
}

//-(void)onEnter{
//    [super onEnter];
//    
//}

-(DrawSprite *)getCurrentSelectSprite:(CGPoint)pos {
    if (m_drawSpriteArray) {
        
        for (DrawSprite * node in m_drawSpriteArray) {
            
            if (node && [node positionInContent:pos]) {
                return node;
            }
        }
    }
    
    return NULL;
}

-(BOOL) touchBegine:(CGPoint)local{
    
    if (m_toolsDisappear) {
        
        [self toolDisappearSelected:local];
        
        return false;
    }
    
    m_movePos = local;
    m_objectHasContina = NO;
    m_removeAllSameColor = NO;
    
    if (m_stackArray.count !=0) {
        for (DrawSprite * node in m_stackArray) {
            [node unselected];
        }
        [m_stackArray removeAllObjects];
    }
    
    DrawSprite * ds = [self getCurrentSelectSprite:local];
    
    if (ds && [ds selectedType]) {
        
        [m_stackArray addObject:ds];
        [self playingSound:m_stackArray.count];
        m_currentDrawColor = ds.m_color;
        m_drawLine = YES;
        return YES;
    }
    return NO;
}

-(void) touchMove:(CGPoint)local{
    
    m_movePos = local;
    
    DrawSprite * ds = [self getCurrentSelectSprite:local];
    
    if (ds && ccc4FEqual(m_currentDrawColor, ds.m_color)) {
        
        if (ds == [m_stackArray lastObject]) {
            return;
        }
        if (m_stackArray.count >=2 &&
            ds == [m_stackArray objectAtIndex:(m_stackArray.count-2)]) {//退一格
            
            DrawSprite * tds = [m_stackArray lastObject];
            [tds unselected];
            if (m_objectHasContina) {
                m_removeAllSameColor = NO;
                m_objectHasContina = NO;
            }
            [m_stackArray removeLastObject];
            [ds selectedType];
            [self playingSound:m_stackArray.count];//play sounds
            return;
        }
        
        if (!m_objectHasContina && [m_stackArray containsObject:ds]) {
            
            DrawSprite * tds = [m_stackArray lastObject];
            
            NSInteger absValue = abs(ds.m_x - tds.m_x) + abs(ds.m_y - tds.m_y);
            [ds unselected];
            if (absValue == 1 && [ds selectedType]) {
                
                m_objectHasContina = YES;
                m_removeAllSameColor = YES;
                
                [m_stackArray addObject:ds];
                [self playingSound:m_stackArray.count];//play sounds
            }
        }
        
        if (m_objectHasContina && [m_stackArray containsObject:ds]) {
            return;
        }
        
        m_objectHasContina = NO;
        DrawSprite * tds = [m_stackArray lastObject];
        
        NSInteger absValue = abs(ds.m_x - tds.m_x) + abs(ds.m_y - tds.m_y);
        
        if (absValue == 1 && [ds selectedType]) {
            [m_stackArray addObject:ds];//play sounds
            [self playingSound:m_stackArray.count];
        }
    }
}

-(void)touchEnd{
    m_drawLine = NO;
    
    NSInteger disappearCount = 0;
    
    if (m_stackArray.count>=2) {
        if (m_removeAllSameColor) {
            
            [self disappearAllSameColorDotsWithSelected];
            
        }else{
            for (int i=0; i<m_stackArray.count; i++) {
                DrawSprite * node = [m_stackArray objectAtIndex:i];
                if (node) {
                    if (i == m_stackArray.count-1) {
                        [node disappear:YES];
                    }
                    [node disappear:NO];
                    disappearCount ++;
                }
            }
        }
    }else{
        for (DrawSprite * node in m_stackArray) {
            [node unselected];
        }
    }
    [m_stackArray removeAllObjects];
    
    if (self.parent) {
        [self.parent playingScoreAdd:disappearCount];
//        DotPlayingScnen * playing = (DotPlayingScnen*)self.parent;
//        
//        if (playing) {
//            [playing playingScoreAdd:disappearCount];
//        }
    }
}

-(NSInteger) disappearAllSameColorDotsWithSelected{
    NSInteger count = 0;
    BOOL dis = YES;
    for (int i=0; i<m_drawSpriteArray.count; i++) {
        DrawSprite * node = [m_drawSpriteArray objectAtIndex:i];
        if (node && ccc4FEqual(m_currentDrawColor, node.m_color)) {
            if (dis) {
                [node disappear:YES];
                dis = NO;
            }
            [node disappear:NO];
            count ++;
        }
    }
    return count;
}

-(void)draw{
    [super draw];
    
    if (m_drawLine && m_canPlaying) {
        
        glLineWidth(10);
    
        ccColor4B c4b = ccc4BFromccc4F(m_currentDrawColor);
        ccDrawColor4B(c4b.r, c4b.g, c4b.b, c4b.a);
        
        if ([m_stackArray count]>=2) {
            DrawSprite * ds = [m_stackArray objectAtIndex:0];
            CGPoint pos = [ds getDrawNodePosition];
            for (int c=1; c<m_stackArray.count; c++) {
                ds  = [m_stackArray objectAtIndex:c];
                CGPoint pos1 = [ds getDrawNodePosition];
                ccDrawLine(pos, pos1);
                pos = pos1;
            }
        }
        DrawSprite * ds = [m_stackArray lastObject];
        CGPoint pos = [ds getDrawNodePosition];
        ccDrawLine(pos, m_movePos);
    }
}

-(void)disappearEnd{
    
    NSMutableArray * dropArray = [NSMutableArray array];
    
    for (int i = 0; i< m_drawSpriteArray.count; i++) {
        DrawSprite * ds = (DrawSprite*)[m_drawSpriteArray objectAtIndex:i];
        
        [self calcDropDown:ds ResultArray:dropArray];
    }
    
    for (int i = 0; i<dropArray.count; i++) {
        
        DrawSprite * ds = (DrawSprite*)[dropArray objectAtIndex:i];
        
        [ds resetDropdown];
    }
    
    for (int i = 0; i< m_drawSpriteArray.count; i++) {
        
        DrawSprite * ds = (DrawSprite*)[m_drawSpriteArray objectAtIndex:i];
        
        if (ds.m_disappear) {
            [ds respawn];
        }
    }
}

-(void) calcDropDown:(DrawSprite*) drawSprite ResultArray:(NSMutableArray *) resultArray{
    
    if (!drawSprite) {
        return;
    }
    
    while (true) {
        NSInteger x = drawSprite.m_x;
        NSInteger y = drawSprite.m_y;
        
        NSInteger index = y*TOTALY + x;
        NSInteger nIndex = (y-1) * TOTALY +x;
        
        if (nIndex<0) {
            break;
        }
        
        DrawSprite * nDS = (DrawSprite *)[m_drawSpriteArray objectAtIndex:nIndex];
        if (nDS && nDS.m_disappear) {
            NSInteger nX = nDS.m_x;
            NSInteger nY = nDS.m_y;
            
            [nDS resetPropertyA:x Y:y];
            [drawSprite resetPropertyA:nX Y:nY];
            
            [m_drawSpriteArray exchangeObjectAtIndex:index withObjectAtIndex:nIndex];
            
            if (![resultArray containsObject:drawSprite] && !drawSprite.m_disappear) {
                [resultArray addObject:drawSprite];
            }
        }
        if(nDS && !nDS.m_disappear){
            break;
        }
    }
}

-(void) toolDisappearSelected:(CGPoint) local{
    
    DrawSprite * ds = [self getCurrentSelectSprite:local];
    
    int count = 0;
    
    if (ds) {
        
        [self cancelAllDrawNodeBeSelected];
        
        if (m_toolsDisappearType) {
            
            m_currentDrawColor = ds.m_color;
            count = [self disappearAllSameColorDotsWithSelected];
        }else{
            [ds disappear:YES];
            count = 1;
        }
        m_toolsDisappear = NO;
        
        
        
        if (self.parent) {
            
            DotPlayingScnen * playing = (DotPlayingScnen*)self.parent;
            
            if (playing) {
                [playing playingScoreAdd:count];
            }
        }
    }
    
}


-(BOOL)allDrawNodeBeSelected:(BOOL)disappearType{
    
    if (m_toolsDisappear) {
        return NO;
    }
    
    m_toolsDisappearType = disappearType;
    m_toolsDisappear = YES;
    
    for (int i=0; i< m_drawSpriteArray.count; i++) {
        
        DrawSprite *ds = (DrawSprite *)[m_drawSpriteArray objectAtIndex:i];
        if (ds) {
            [ds KeepSelected];
        }
    }
    
    return YES;
}


-(void) cancelAllDrawNodeBeSelected{
    
    for (int i=0; i< m_drawSpriteArray.count; i++) {
        
        DrawSprite *ds = (DrawSprite *)[m_drawSpriteArray objectAtIndex:i];
        if (ds) {
            [ds unKeepSelected];
        }
    }
}


#pragma mark - datahandle 

-(void)startAnimtionDisplay{
    self.visible = true;
    if (m_drawSpriteArray) {
        
        for (DrawSprite * node in m_drawSpriteArray) {
            
            if (node) {
                [node spawnDropdown];
            }
        }
    }
}


-(void)startPlaying{
    
    m_toolsDisappear = false;
    m_canPlaying = YES;
    
    [self setTouchMode:kCCTouchesOneByOne];
    [self setTouchEnabled:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (!m_canPlaying) {
        return NO;
    }
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [self convertToNodeSpace:touchLocation];
    
    
    return [self touchBegine:local];
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    
    
    if (!m_canPlaying) {
        return ;
    }
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [self convertToNodeSpace:touchLocation];
    
    
    [self touchMove:local];
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    [self touchEnd];
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    [self touchEnd];
}

-(void)moveOut{
    m_canPlaying = false;
    [self setVisible:false];
}

-(void)moveIn{
    m_canPlaying = true;
    [self setVisible:true];
}


#pragma mark - 

-(void) playingSound:(NSInteger) count{
    
    if (count>13) {
        count = 13;
    }
    
    NSString * soundName = [NSString stringWithFormat:@"Sounds/%d.aif",count];
    
    [[SimpleAudioEngine sharedEngine] playEffect:soundName];
    
}



- (void)dealloc
{
    [m_stackArray removeLastObject]; [m_stackArray release];
    [m_drawSpriteArray removeLastObject]; [m_drawSpriteArray release];
    
    [super dealloc];
}



@end
