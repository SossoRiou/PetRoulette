//
//  JsonAppointmentModel.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 16/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "JsonAppointmentModel.h"

@implementation JsonAppointmentModel

@end


@implementation AppointmentApi

@synthesize data;
@synthesize html;
@synthesize messages;
@synthesize success;

- (void) dealloc
{
    /*
    [Data release];
    [Html release];
    [Messages release];
    [Success release];
    [super dealloc];
     */
}

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
   /* id obj = [[[Api alloc] initWithDictionary:dictionary] autorelease];
    return obj;
    */
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self=[super init];
    if(self)
    {
        
        data = [[ModelAppointmentData alloc] initWithDictionary:[dictionary objectForKey:@"data"]];
        html = [dictionary objectForKey:@"html"];
        
        NSArray* temp =  [dictionary objectForKey:@"messages"];
        messages =  [[NSMutableArray alloc] init];
        for (NSDictionary *d in temp) {
            [messages addObject:[ModelAppointmentMessage objectWithDictionary:d]];
        }
        success = [dictionary objectForKey:@"success"];
    }
    return self;
}


@end


@implementation ModelAppointmentQuery

@synthesize time;
@synthesize sql;

- (void) dealloc
{
   /* [Time release];
    [Sql release];
    [super dealloc];
    */
}

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
    /*
    id obj = [[[ModelQuery alloc] initWithDictionary:dictionary] autorelease];
    return obj;
     */
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self=[super init];
    if(self)
    {
        time = [dictionary objectForKey:@"time"];
        sql = [dictionary objectForKey:@"sql"];
    }
    return self;
}


@end


@implementation ModelAppointmentData

@synthesize queries;
@synthesize appointment_result;

- (void) dealloc
{
    /*
    [Queries release];
    [Appointment_result release];
    [super dealloc];
     */
}

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
    id obj = [[ModelAppointmentData alloc] initWithDictionary:dictionary];
    return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self=[super init];
    if(self)
    {
        
        NSArray* temp =  [dictionary objectForKey:@"queries"];
        queries =  [[NSMutableArray alloc] init];
        for (NSDictionary *d in temp) {
            [queries addObject:[[ModelAppointmentQuery alloc] initWithDictionary:d]];
        }
        appointment_result = [dictionary objectForKey:@"appointment_result"];
    }
    return self;
}


@end


@implementation ModelAppointmentMessage

@synthesize message;
@synthesize type;

- (void) dealloc
{
    /*
    [Message release];
    [Type release];
    [super dealloc];
     */
}

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
    id obj = [[ModelAppointmentMessage alloc] initWithDictionary:dictionary];
    return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self=[super init];
    if(self)
    {
        message = [dictionary objectForKey:@"message"];
        type = [dictionary objectForKey:@"type"];
    }
    return self;
}


@end

