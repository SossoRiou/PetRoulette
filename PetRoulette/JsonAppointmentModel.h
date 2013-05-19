//
//  JsonAppointmentModel.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 16/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//
//#import "JSONKit.h"
#import <Foundation/Foundation.h>


/*
 Classes allowing to make the last conversion from the JSON to subclasses such as ModelAppointmentData 
 We will find here the result of the API post in order to save the appointment
 Follow the Appointment API-post
 */
@interface JsonAppointmentModel : NSObject
@end

@class ModelAppointmentQuery;
@class ModelAppointmentData;
@class ModelAppointmentMessage;

//For connecting to the API
@interface AppointmentApi : NSObject
{
    ModelAppointmentData * data;
    NSString * html;
    NSMutableArray * messages;
    NSString * success;
}

@property(nonatomic,retain) ModelAppointmentData * data;
@property(nonatomic,retain) NSString * html;
@property(nonatomic,retain) NSMutableArray * messages;
@property(nonatomic,retain) NSString * success;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end


@interface ModelAppointmentQuery : NSObject
{
    NSString * time;
    NSString * sql;
}

@property(nonatomic,retain) NSString * time;
@property(nonatomic,retain) NSString * sql;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

//Class containing the result of the post
@interface ModelAppointmentData : NSObject
{
    NSMutableArray * queries;
    NSString * appointment_result;
}

@property(nonatomic,retain) NSMutableArray * queries;
@property(nonatomic,retain) NSString * appointment_result;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end


@interface ModelAppointmentMessage : NSObject
{
    NSString * message;
    NSString * type;
}

@property(nonatomic,retain) NSString * message;
@property(nonatomic,retain) NSString * type;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;



@end
