//
//  LMYDateUtility.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYDateUtility.h"


static NSString * const timeFormat_yMd = @"yyyy-MM-dd";
static NSString * const timeFormat_Hm = @"HH:mm";
static NSString * const timeFormat_EHm = @"EEEE HH:mm";

@interface LMYDateUtility ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation LMYDateUtility


+ (instancetype)shareInterface
{
    static LMYDateUtility *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[LMYDateUtility alloc] init];
        obj.dateFormatter = [[NSDateFormatter alloc] init];
        obj.dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    });
    return obj;
}

/* 时间显示(Date -> string)
 * dateFormatter : 时间格式
 *stampDate:(NSDate *)时间挫
 */
- (NSString *)getStringWithDate:(NSDate *)stampDate dateFormatter:(NSString *)dateFormatter
{
    [self.dateFormatter setDateFormat:dateFormatter];
    return [self.dateFormatter stringFromDate:stampDate];
}


/*今天，昨天，星期几（一周内）,年月日
 */
- (NSString *)stringDateForStampDate:(NSDate *)stampDate dateFormat:(NSString *)dateformat
{
    NSDate *currentDate = [NSDate date];
    NSString *currentDay = [self getStringWithDate:currentDate dateFormatter:timeFormat_yMd];//当前的日期
    
    NSString * stempDay = [self getStringWithDate:stampDate dateFormatter:timeFormat_yMd];//需要比较的日期
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * date1 =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate * date2 =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay*2];
    NSDate * date3 =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay*3];
    NSDate * date4 =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay*4];
    NSDate * date5 =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay*5];
    NSDate * date6 =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay*6];
    
    NSString * dateDay1 = [self getStringWithDate:date1 dateFormatter:timeFormat_yMd];//前1天
    NSString * dateDay2 = [self getStringWithDate:date2 dateFormatter:timeFormat_yMd];//前2天
    NSString * dateDay3 = [self getStringWithDate:date3 dateFormatter:timeFormat_yMd];//前3天
    NSString * dateDay4 = [self getStringWithDate:date4 dateFormatter:timeFormat_yMd];//前4天
    NSString * dateDay5 = [self getStringWithDate:date5 dateFormatter:timeFormat_yMd];//前5天
    NSString * dateDay6 = [self getStringWithDate:date6 dateFormatter:timeFormat_yMd];//前6天
    
    if ([stempDay isEqualToString:currentDay]) {
        return [NSString stringWithFormat:@"今天 %@",[self getStringWithDate:stampDate dateFormatter:timeFormat_Hm]];
    }
    else if ([stempDay isEqualToString:dateDay1]) {//昨天
        return [NSString stringWithFormat:@"昨天 %@", [self getStringWithDate:stampDate dateFormatter:timeFormat_Hm]];
    }else if ([stempDay isEqualToString:dateDay2] ||
              [stempDay isEqualToString:dateDay3] ||
              [stempDay isEqualToString:dateDay4] ||
              [stempDay isEqualToString:dateDay5] ||
              [stempDay isEqualToString:dateDay6]) {//间隔一周内
        return [self getStringWithDate:stampDate dateFormatter:timeFormat_EHm];
    } else {//大于一周
        return [self getStringWithDate:stampDate dateFormatter:dateformat];
    }
}


/* 一小时内的时间规则(一分钟内:刚刚， 一小时内:xx分钟前)
 */
- (NSString *)dateTimeOneHour:(NSTimeInterval)compareInterval
{
    NSTimeInterval mine = 60;// one mine
    NSTimeInterval hour = 60*60;//one hour
    if (compareInterval < 0) {
        return @"";
    }else if (compareInterval < mine) {
        return @"刚刚";
    }else if (compareInterval < hour){
        NSUInteger miu = (NSUInteger)compareInterval / 60;
        return [NSString stringWithFormat:@"%ld分钟前", (unsigned long)miu];
    }
    return @"";
}


/* 时间显示规则
 * havDay : (YES: 一小时内规则区分23:-- 至 第二天00:--) (NO: 不区分23:-- 至 第二天00:--)
 * stampDate : (NSDate *)时间挫
 * timeFormateType : 时间格式
 */
- (NSString *)dateStringWithStampDate:(NSDate *)stampDate dateFormatter:(NSString *)dateFormatter havDay:(BOOL)havDay
{
    NSString *strDescription = @"";
    NSDate *currentDate = [NSDate date];
    NSTimeInterval compareInterval = [currentDate timeIntervalSinceDate:stampDate];
    NSTimeInterval hour = 60*60;//one hour
    if (!havDay) {
        if (compareInterval < hour) {
            strDescription = [self dateTimeOneHour:compareInterval];
        }else{
            strDescription = [self stringDateForStampDate:stampDate dateFormat:dateFormatter];
        }
    }else{
        [self.dateFormatter setDateFormat:timeFormat_yMd];
        NSString *theDay = [self.dateFormatter stringFromDate:stampDate];//需要比较的日期
        NSString *currentDay = [self.dateFormatter stringFromDate:currentDate];//当前日期
        if ([theDay isEqualToString:currentDay]) {
            if (compareInterval < hour) {
                strDescription = [self dateTimeOneHour:compareInterval];
            }else{
                strDescription = [self stringDateForStampDate:stampDate dateFormat:dateFormatter];
            }
        }else{
            strDescription = [self stringDateForStampDate:stampDate dateFormat:dateFormatter];
        }
    }
    return strDescription;
}


#pragma mark - 将某个时间戳转化成   今天、昨天、星期 、 yyyy-MM-dd HH:mm
+ (NSString *)timestampFormatWithTime:(NSTimeInterval)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSLog(@"1296035591  = %@",confromTimesp);
    
    NSString *confromTimespStr = [[self shareInterface] stringDateForStampDate:confromTimesp dateFormat:format];
    
    NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    return confromTimespStr;
}

@end
