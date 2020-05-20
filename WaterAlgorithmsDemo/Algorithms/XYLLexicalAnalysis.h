//
//  XYLLexicalAnalysis.h
//  WaterAlgorithmsDemo
//
//  Created by 唐崇 on 2020/1/10.
//  Copyright © 2020 xuyanlan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LexicalAnalysisStatus) {
    LexicalAnalysisStatusInit = 0,  //初始态
    LexicalAnalysisStatusID,        //ID态 ,     标识符 age
    LexicalAnalysisStatusGT,        //大于 ,      >
    LexicalAnalysisStatusGE,        //大于等于,    >=
    LexicalAnalysisStatusIntLiteral,//字面量       23
};

@interface XYLLexicalAnalysis : NSObject
@property (nonatomic, assign)LexicalAnalysisStatus analysisStatus;
@end

NS_ASSUME_NONNULL_END
