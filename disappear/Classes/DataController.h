//
//  DataController.h
//  disappear
//
//  Created by CpyShine on 13-6-3.
//  Copyright (c) 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject{
    
    NSString * m_filePath;
    
    NSDictionary * m_dataDic;
    
}


+(DataController*) getSharedDataController;

+(void) releaseSharedDataController;

-(void) savePlayerTemplateData:(NSInteger) score;


-(NSArray*) readLoaclScoreTopList;

-(NSDictionary*) readWorldScpreTopList;

-(NSArray *) readPlayerDefaultProperty;

-(NSInteger) getHighScore;

-(void) saveUserName:(NSString*)name;

@end
