//
//  DataController.m
//  disappear
//
//  Created by CpyShine on 13-6-3.
//  Copyright (c) 2013年 CpyShine. All rights reserved.
//

#import "DataController.h"

#import "cocos2d.h"


#define WORLD_TOPLIST @"worldtoplist"
#define LOCAL_TOPLIST @"localtoplist"

#define PLAYER_PROPERTY @"playerdefaultProperty"

#define NAME_KEY @"name"
#define SCORE_KEY @"score"
//#define DATA_PLIST_NAME 

static DataController * _sharedDataController=NULL;

@implementation DataController


+(DataController *)getSharedDataController{
    if (_sharedDataController==NULL) {
        _sharedDataController = [[self alloc]init];
    }
    return _sharedDataController;
}

+(void)releaseSharedDataController{
    if (_sharedDataController) {
        [_sharedDataController autorelease];
        _sharedDataController = NULL;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        if (!documentsDirectory) {
            NSLog(@"读取硬盘文件夹 document 失败");
//            return NULL;
        }
        
        m_dataDic  = nil;
        
        m_filePath = [[documentsDirectory stringByAppendingPathComponent:@"data"]retain];
        
        NSLog(@"%@",m_filePath); 
    }
    return self;
}


-(NSArray *)readLoaclScoreTopList{
    
    [self reloadData];
    
    if (!m_dataDic) {
        return nil;
    }
    
    NSArray * array = [m_dataDic objectForKey:LOCAL_TOPLIST];
    
    if (array) {
        return array;
    }
    return NULL;
}

-(NSDictionary *)readWorldScpreTopList{
    
    [self reloadData];
    
    if (!m_dataDic) {
        return nil;
    }
    
    NSDictionary * world = [m_dataDic objectForKey:WORLD_TOPLIST];
    
    if (world) {
        return world;
    }
    return NULL;
}

-(NSArray*) readPlayerDefaultProperty{
    [self reloadData];
    
    if (!m_dataDic) {
        return nil;
//        [array initWithObjects:[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:1], nil]
    }
    
    
    NSArray * array= [m_dataDic objectForKey:PLAYER_PROPERTY];
    if (!array) {
        [array initWithObjects:[NSNumber numberWithInteger:1],
                                [NSNumber numberWithInteger:1],
                                 [NSNumber numberWithLong:1], nil];
    }
    return array;
}

-(NSInteger)getHighScore{
    NSArray * sco = [self readLoaclScoreTopList];
    if (!sco) {
        return 0;
    }
    NSNumber * number = [sco objectAtIndex:0];
    return number.integerValue;
}

-(void) savePlayerDefauleProperty:(NSInteger) level :(NSInteger)gold :(long int) exp{
    NSArray * array = [array initWithObjects:[NSNumber numberWithInteger:level],
                                                [NSNumber numberWithInteger:gold],
                                                    [NSNumber numberWithLong:exp], nil];
    [self saveDataIntoFile:[self readLoaclScoreTopList] World:[self readWorldScpreTopList] :array ];
}

-(void)savePlayerTemplateData:(NSInteger)score{
    
    NSNumber * number = [NSNumber numberWithInteger:score];
    
    NSArray * scoreArray = [self readLoaclScoreTopList];
    NSMutableArray * saveScoreArray = NULL;
    if (scoreArray) {
        saveScoreArray = [NSMutableArray arrayWithArray:scoreArray];
    }else{
        saveScoreArray = [NSMutableArray array];
    }
    [saveScoreArray addObject:number];
    [saveScoreArray sortUsingFunction:Compare context:nil];
    
    BOOL flag = false;
    
    if (saveScoreArray.count>7) {
        
        if (number == [saveScoreArray lastObject]) {
            flag = true;
        }
        [saveScoreArray removeLastObject];
    }
    
    if (!flag) {
        [self saveDataIntoFile:saveScoreArray World:[self readWorldScpreTopList] :[self readPlayerDefaultProperty]];
    }
}

static inline NSInteger Compare(id num1, id num2, void *context)
{
    int value1 = [num1 intValue];
    int value2 = [num2 intValue];
    
    if (value1 < value2)
        return NSOrderedDescending;
    else  if (value1 > value2)
        return NSOrderedAscending;
    else return NSOrderedSame;
}

-(void) saveDataIntoFile:(NSArray*) localArray World:(NSDictionary*) worldLis :(NSArray*)pro{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          localArray,LOCAL_TOPLIST,worldLis,WORLD_TOPLIST,pro,PLAYER_PROPERTY, nil];
    
    [NSKeyedArchiver archiveRootObject:dic toFile:m_filePath];
}

-(void) reloadData{
    
    if (m_dataDic) {
        [m_dataDic autorelease];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:m_filePath]){
        m_dataDic = nil;
        return;
    }
    
    m_dataDic = [NSKeyedUnarchiver unarchiveObjectWithFile:m_filePath];
    
    if (m_dataDic) {
        [m_dataDic retain];
    }
}

@end
