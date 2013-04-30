//
//  PetRouletteTests.m
//  PetRouletteTests
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//
#import "Appointment.h"
#import "Pet.h"
#import "GenericParser.h"
#import "PetParser.h"
#import "JsonRandomModel.h"
#import "PetRouletteTests.h"

@implementation PetRouletteTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}
/*  TEST OF VIDEO CODE */

-(void)test_constructor_video{
    Video *test_video = [[Video alloc] initVideoWithTitle:@"Title Test" atOrder:1 withURL:@"http://google.fr/test" createdAt:@"2012-02-04" byShelter:10 forPet:2];
    STAssertNotNil(test_video, @"Could not create test_video");
    STAssertEquals(@"Title Test", test_video.title, @"This video should have Title Test as title but instead of that it has %@", test_video.title);
    STAssertEquals((NSUInteger)1, test_video.order, @"This video should be first as ordering but it's not");
    STAssertEquals(@"http://google.fr/test", test_video.video_url, @"This video should be shown at the URL http://google.fr/test but it's not");
    STAssertEquals(@"2012-02-04", test_video.created_date, @"This video should be created on 2012, february 4th");
    STAssertEquals((NSUInteger)10, test_video.shelter_id, @"This video should be made by Shelter_id : 10 but it's not ");
    STAssertEquals((NSUInteger)2, test_video.pet_id, @"This video should concern the pet_id : 2 but it's not");
}

/*TEST OF PET CODE */

-(void)test_constructor_pet{
    
    Video *test_video = [[Video alloc] initVideoWithTitle:@"Title Test" atOrder:1 withURL:[NSURL URLWithString:@"http://google.fr/test"] createdAt:@"2012-02-04" byShelter:10 forPet:2];
    
    STAssertNotNil(test_video, @"Could not create test_video");
    
    Pet *test_pet = [[Pet alloc] initPetWithId:10 andNamed:@"Upsy" withRace:@"Bouledogue Francais" ofSpeciesId:(NSUInteger)11 andSpeciesName:@"Dogs" bornIn:@"1999-07-05" createdOn:@"2012-02-04" withDescription:@"THE MOST BEAUTIFUL DOG EVER" nexted:0 showedByVideo:test_video];
    
    STAssertNotNil(test_pet, @"Could not create test_pet");
    STAssertEquals((NSUInteger)10, test_pet.pet_id, @"This pet should be registered at id : 10 but it's not");
    STAssertEquals(@"Upsy", test_pet.pet_name, @"This pet should be named Upsy but it's not");
    STAssertEquals(@"Bouledogue Francais", test_pet.pet_race, @"This pet should be a Bouledogue Francais but it's not");
    STAssertEquals(@"Dogs", test_pet.pet_species_name, @"This pet should be a dog but it's not");
    STAssertEquals(@"1999-07-05", test_pet.pet_birthDate, @"This pet add should be born on 1999, july 5th");
    STAssertEquals(@"2012-02-04", test_pet.pet_createdDate, @"This pet add should have been created on 2012, february 4th");
    STAssertEquals(@"THE MOST BEAUTIFUL DOG EVER", test_pet.pet_description, @"This pet should be described as THE MOST BEAUTIFUL DOG EVER but it's not");
    STAssertEquals((NSUInteger)0, test_pet.pet_nextCount, @"The dog should be nexted 0 times but it's not");
    STAssertEquals(test_video, test_pet.pet_currentVideo, @"Ths dog should have the former video but it's not");
    
    
}


-(void)test_set_details_Pet{
    Video *video = [[Video alloc] initVideoWithTitle:@"Title Test" atOrder:1 withURL:[NSURL URLWithString:@"http://google.fr/test"] createdAt:@"2012-02-04" byShelter:10 forPet:2];
    
    Pet *test_pet = [[Pet alloc] initPetWithId:10 andNamed:@"Upsy" withRace:@"Bouledogue Francais" ofSpeciesId:(NSUInteger)11 andSpeciesName:@"Dogs" bornIn:@"1999-07-05" createdOn:@"2012-02-04" withDescription:@"THE MOST BEAUTIFUL DOG EVER" nexted:0 showedByVideo:video];
    
    [test_pet setDetailsShelterWithId:001 andNamed:@"La Maison du Soleil" toCallAtNumber:@"04 67 55 58 71" orByMail:@"solene34.riou@laposte.net" createdON:@"1990-03-11" locatedAtTheAddress:@"115 Chemin des Vignes" showedByListVideo:nil];
    
    STAssertNotNil(test_pet, @"Could not create test_pet");
    STAssertEquals((NSUInteger)001, test_pet.shelter_id, @"This shelter should be registered at id : 001 but it's not");
    STAssertEquals(@"La Maison du Soleil", test_pet.shelter_name, @"This shelter should be named La Maison du Soleil but it's not");
    STAssertEquals(@"04 67 55 58 71", test_pet.shelter_phoneNumber, @"This shelter should be given 04 67 55 58 71 phone number but it's not");
    STAssertEquals(@"solene34.riou@laposte.net", test_pet.shelter_email, @"This shelter should be given solene34.riou@laposte.net but it's not");
    STAssertEquals(@"1990-03-11", test_pet.shelter_creationDate, @"This shelter add should have been created on 2012, february 4th, but it's not");
    STAssertEquals(@"115 Chemin des Vignes", test_pet.shelter_address, @"This shelter should be located at 115 Chemin des Vignes but it's not");
    STAssertNil(test_pet.pet_videoList, @"This pet should have it video list at nil for the moment, and it's not");
}

-(void)test_getAge{
    Video *video = [[Video alloc] initVideoWithTitle:@"Title Test" atOrder:1 withURL:[NSURL URLWithString:@"http://google.fr/test"] createdAt:@"2012-02-04" byShelter:10 forPet:2];
    Pet *pet = [[Pet alloc] initPetWithId:10 andNamed:@"Upsy" withRace:@"Bouledogue Francais" ofSpeciesId:(NSUInteger)11 andSpeciesName:@"Dogs" bornIn:@"1999-07-05" createdOn:@"2012-02-04" withDescription:@"THE MOST BEAUTIFUL DOG EVER" nexted:0 showedByVideo:video];
    
    STAssertEquals((NSUInteger)13, [pet getAge], @"The pet should have 0 years old and it's not");
}

/*TEST OF APPOINTMENT CODE */
-(void)test_constructor_appointment{
    Video *video = [[Video alloc] initVideoWithTitle:@"Title Test" atOrder:1 withURL:[NSURL URLWithString:@"http://google.fr/test"] createdAt:@"2012-02-04" byShelter:10 forPet:2];
    
    Pet *pet = [[Pet alloc] initPetWithId:10 andNamed:@"Upsy" withRace:@"Bouledogue Francais" ofSpeciesId:(NSUInteger)11 andSpeciesName:@"Dogs" bornIn:@"1999-07-05" createdOn:@"2012-02-04" withDescription:@"THE MOST BEAUTIFUL DOG EVER" nexted:0 showedByVideo:video];
    
    Appointment *test_appointment = [[Appointment alloc] initWithPet:pet andUserNamed:@"Soso" withDetails:@"solene34.riou@gmail.com" andAlsoOnPhone:@"06 20 26 60 48" toTheDate:@"2013-06-3"];
    
    STAssertNotNil(test_appointment, @"The appointment could not be created");
    STAssertEquals(pet, test_appointment.appointment_pet, @"The pet concerned by the appointment should be the former pet but it's not");
    STAssertEquals(@"Soso", test_appointment.user_name, @"The user name should be Soso but it's not");
    STAssertEquals(@"solene34.riou@gmail.com", test_appointment.user_email, @"This user email should be solene34.riou@gmail.com but it's not");
    STAssertEquals(@"06 20 26 60 48", test_appointment.user_phoneNumber, @"This user phone number should be 06 20 26 60 48 but it's not");
    STAssertEquals(@"2013-06-3", test_appointment.requested_date, @"This appointment requested date should have been created on 2013, june 3th, but it's not");
}

/*   TEST OF Generic PARSER */
-(void)test_constructor_genericParser{
    GenericParser *test_genericParser = [[GenericParser alloc] init];
    STAssertNotNil(test_genericParser, @"The generic parser could not be created");
}

//Test of methods called to make the connection
//RANDOM
-(void)test_of_requestRandom{
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    NSURLRequest *test_requestRandom = [NSURLRequest requestWithURL:urlRandom];
    STAssertNotNil(test_requestRandom, @"The request should have succeed but it's not. The connexion failed");
}
-(void)test_of_responseRandom{
    //API call
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    NSURLRequest *requestRandom = [NSURLRequest requestWithURL:urlRandom];
    
    //response of the API
    NSData *test_responseRandom = [NSURLConnection sendSynchronousRequest:requestRandom returningResponse:nil error:nil];
    
    STAssertNotNil(test_responseRandom, @"API should have returned a response for the random call but it's not");
}
-(void)test_deserializeRandom{
    //API call
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    NSURLRequest *requestRandom = [NSURLRequest requestWithURL:urlRandom];
    //response of the API
    NSData *responseRandom = [NSURLConnection sendSynchronousRequest:requestRandom returningResponse:nil error:nil];
    
    NSString *test_json_string = [[NSString alloc] initWithData:responseRandom encoding:[NSString defaultCStringEncoding]];
    STAssertNotNil(test_json_string, @"The Random response should be transformed into a String, first, but it's not. The JSON deserialization has failed");
    
    NSData *test_json_data = [test_json_string dataUsingEncoding:[NSString defaultCStringEncoding]];
    STAssertNotNil(test_json_data,  @"The Random response should be transformed, then, into a Data but it's not. The JSON deserialization has failed");
    
    NSDictionary *test_json_dict = [NSJSONSerialization JSONObjectWithData:test_json_data options:0 error:nil];
    STAssertNotNil(test_json_dict, @"The Random response should be transformed, finally, into a Dictionary but it's not. The JSON deserialization has failed");
}
-(void)test_downloadRandomJSONWithURL{
    GenericParser *genericParser = [[GenericParser alloc] init];
    
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    
    NSDictionary *test_dictionary_response = [genericParser downloadRandomJSONWithURL:urlRandom];
    STAssertNotNil(test_dictionary_response, @"JSON Random should exist as dictionary but it does not. The connexion has failed");
}
-(void)test_getter_modelRandomVideo_temp{
    GenericParser *genericParser = [[GenericParser alloc] init];
    ModelRandomVideo *test_modelRandomVideo = [genericParser modelRandomVideo_temp];
    STAssertNotNil(test_modelRandomVideo, @"A ModelRandomVideo should have been created when we want to get the modelRandomVideo_temp but it's not");
}

//Cookie
-(void)test_of_gettingCookie{
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    //getting Cookie
    NSArray *test_cookieArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:urlRandom];
    STAssertNotNil(test_cookieArray, @"The connexion to the random url should have given a cookie but it's not. We do not have any cookie");
}
-(void)test_giveSessionIdFromCookie{
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    //getting Cookie
    NSArray *cookie = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:urlRandom];
    GenericParser *genericParser = [[GenericParser alloc] init];
    NSString *test_cookieRandomString = [genericParser giveSessionIdFromCookie:cookie];
    STAssertNotNil(test_cookieRandomString, @"We should have a string that gives us the sessionid : value but it's not");
    //Maybe we could test the value
}


//DETAILS
-(void)test_of_requestDetails{
    NSURL *urlDetails = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/details"];
    NSURLRequest *test_requestDetails = [NSURLRequest requestWithURL:urlDetails];
    STAssertNotNil(test_requestDetails, @"The request should have succeed but it's not. The connexion failed");
}
-(void)test_of_responseDetails{
    //API call
    NSURL *urlDetails = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/details"];
    NSURLRequest *requestDetails = [NSURLRequest requestWithURL:urlDetails];
    
    //response of the API
    NSData *test_responseDetails = [NSURLConnection sendSynchronousRequest:requestDetails returningResponse:nil error:nil];
    
    STAssertNotNil(test_responseDetails, @"API should have returned a response for the details call but it's not");
}
-(void)test_deserializeDetails{
    //API call
    NSURL *urlDetails = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/details"];
    NSURLRequest *requestDetails = [NSURLRequest requestWithURL:urlDetails];
    
    //response of the API
    NSData *responseDetails = [NSURLConnection sendSynchronousRequest:requestDetails returningResponse:nil error:nil];
    
    NSString *test_json_string = [[NSString alloc] initWithData:responseDetails encoding:[NSString defaultCStringEncoding]];
    STAssertNotNil(test_json_string, @"The Details response should be transformed into a String, first, but it's not. The JSON deserialization has failed");
    
    NSData *test_json_data = [test_json_string dataUsingEncoding:[NSString defaultCStringEncoding]];
    STAssertNotNil(test_json_data,  @"The Details response should be transformed, then, into a Data but it's not. The JSON deserialization has failed");
    
    NSDictionary *test_json_dict = [NSJSONSerialization JSONObjectWithData:test_json_data options:0 error:nil];
    STAssertNotNil(test_json_dict, @"The Details response should be transformed, finally, into a Dictionary but it's not. The JSON deserialization has failed");
}
-(void)test_downloadDetailsJSONWithURL{
    GenericParser *genericParser = [[GenericParser alloc] init];
    
    NSURL *urlDetails = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/details"];
    
    NSDictionary *test_dictionary_response = [genericParser downloadRandomJSONWithURL:urlDetails];
    STAssertNotNil(test_dictionary_response, @"JSON Details should exist as dictionary but it does not. The connexion has failed");
}
-(void)test_getter_modelDetailsPet_temp{
    GenericParser *genericParser = [[GenericParser alloc] init];
    ModelDetailsPet *test_modelDetailsPet = [genericParser modelDetailsPet_temp];
    STAssertNotNil(test_modelDetailsPet, @"A ModelDetailsPet should have been created when we want to get the modelDetailsPet_temp but it's not");
}


/*   TEST OF JSON MODEL */


/*   TEST OF ModelRandomVideo */
-(void)test_initWithDictionary_Model_randomVideo{
    //deserialize code
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    GenericParser *genericParser = [[GenericParser alloc] init];
    NSDictionary *jsonRandom = [genericParser downloadRandomJSONWithURL:urlRandom];
    
    ModelRandomVideo *test_modelRandomVideo = [[ModelRandomVideo alloc] initWithDictionary:jsonRandom];
    STAssertNotNil(test_modelRandomVideo, @"The ModelRandomVideo should have been created from the dictionary but it's not");
    STAssertTrue([test_modelRandomVideo.title isKindOfClass:[NSString class]], @"The modelRandomVideo should have a title as a String, but it's not");
    STAssertNotNil(test_modelRandomVideo.title, @"The modelRandomVideo should have a title, but it's not");
    STAssertTrue([test_modelRandomVideo.ordering isKindOfClass:[NSString class]], @"The modelRandomVideo should have an ordering as a String, but it's not");
    STAssertNotNil(test_modelRandomVideo.ordering, @"The modelRandomVideo should have an ordering, but it's not");
    STAssertTrue([test_modelRandomVideo.pet isKindOfClass:[ModelRandomPet class]], @"The modelRandomVideo should have a pet as a ModelRandomPet, but it's not");
    STAssertNotNil(test_modelRandomVideo.pet, @"The modelRandomVideo should have a pet, but it's not");
    STAssertTrue([test_modelRandomVideo.video_link isKindOfClass:[NSString class]], @"The modelRandomVideo should have a video_link as a String, but it's not");
    STAssertNotNil(test_modelRandomVideo.video_link, @"The modelRandomVideo should have a video_link, but it's not");
    STAssertTrue([test_modelRandomVideo.created_date isKindOfClass:[NSString class]], @"The modelRandomVideo should have an created_date as a String, but it's not");
    STAssertNotNil(test_modelRandomVideo.created_date, @"The modelRandomVideo should have a created_date, but it's not");
    STAssertTrue([test_modelRandomVideo.created_by_id isKindOfClass:[NSString class]], @"The modelRandomVideo should have an id of the Shelter as a String, but it's not");
    STAssertNotNil(test_modelRandomVideo.created_by_id, @"The modelRandomVideo should have an id of the Shelter, but it's not");
    STAssertTrue([test_modelRandomVideo.pet_id isKindOfClass:[NSString class]], @"The modelRandomVideo should have a pet_id as a String, but it's not");
    STAssertNotNil(test_modelRandomVideo.pet_id, @"The modelRandomVideo should have a pet_id, but it's not");
    STAssertTrue([test_modelRandomVideo.idVideo isKindOfClass:[NSString class]], @"The modelRandomVideo should have a idVideo as a String, but it's not");
    STAssertNotNil(test_modelRandomVideo.idVideo, @"The modelRandomVideo should have a idVideo, but it's not");
}
/*   TEST OF ModelRandomPet */
-(void)test_initWithDictionary_Model_randomPet{
    NSURL *urlRandom = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/random"];
    GenericParser *genericParser = [[GenericParser alloc] init];
    NSDictionary *jsonRandom = [genericParser downloadRandomJSONWithURL:urlRandom];
    
    //preparation of the good dictionary
    NSDictionary *test_contenuData = [jsonRandom objectForKey:@"data"];
    STAssertNotNil(test_contenuData, @"The 'data' contents split of the dictionary has failed. A dictionary should exist but it does not");
    NSDictionary *test_contenuVideo = [test_contenuData objectForKey:@"video"];
    STAssertNotNil(test_contenuVideo, @"The 'video' contents split has failed. A dictionary should exist but it does not");
    
    ModelRandomPet *test_modelRandomPet = [[ModelRandomPet alloc] initWithDictionary:[test_contenuVideo objectForKey:@"pet"]];
    STAssertNotNil(test_modelRandomPet, @"The ModelRandomPet should have been created from the dictionary but it's not");
    
    STAssertTrue([test_modelRandomPet.species_id isKindOfClass:[NSString class]], @"The modelRandomPet should have a species_id as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.species_id, @"The modelRandomPet should have a species_id, but it's not");
    STAssertTrue([test_modelRandomPet.description isKindOfClass:[NSString class]], @"The modelRandomPet should have a description as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.description, @"The modelRandomPet should have a description, but it's not");
    STAssertTrue([test_modelRandomPet.created_datetime isKindOfClass:[NSString class]], @"The modelRandomPet should have a created date as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.created_datetime, @"The modelRandomPet should have a created date, but it's not");
    STAssertTrue([test_modelRandomPet.available_until isKindOfClass:[NSString class]], @"The modelRandomPet should have an available_until as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.available_until, @"The modelRandomPet should have an available_until, but it's not");
    STAssertTrue([test_modelRandomPet.organization_id isKindOfClass:[NSString class]], @"The modelRandomPet should have an organization_id as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.organization_id, @"The modelRandomPet should have an organization_id, but it's not");
    STAssertTrue([test_modelRandomPet.date_of_birth isKindOfClass:[NSString class]], @"The modelRandomPet should have a date of birth as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.date_of_birth, @"The modelRandomPet should have a date of birth, but it's not");
    STAssertTrue([test_modelRandomPet.race_id isKindOfClass:[NSString class]], @"The modelRandomPet should have a race_id as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.race_id, @"The modelRandomPet should have a race_id, but it's not");
    STAssertTrue([test_modelRandomPet.idPet isKindOfClass:[NSString class]], @"The modelRandomPet should have a idPet as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.idPet, @"The modelRandomPet should have a idPet, but it's not");
    STAssertTrue([test_modelRandomPet.name isKindOfClass:[NSString class]], @"The modelRandomPet should have a name as a String, but it's not");
    STAssertNotNil(test_modelRandomPet.name, @"The modelRandomPet should have a name, but it's not");
}
/*   TEST Of ModelDetailsPet */
-(void)test_initWithDictionary_Model_detailsPet{
    NSURL *urlDetails = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/details"];
    GenericParser *genericParser = [[GenericParser alloc] init];
    NSDictionary *jsonDetails = [genericParser downloadRandomJSONWithURL:urlDetails];
    
    
    ModelDetailsPet *test_modelDetailsPet = [[ModelDetailsPet alloc] initWithDictionary:jsonDetails];
    STAssertNotNil(test_modelDetailsPet, @"The ModelRandomPet should have been created from the dictionary but it's not");
    
    STAssertTrue([test_modelDetailsPet.species_id isKindOfClass:[NSString class]], @"The modelDetailsPet should have a species_id as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.species_id, @"The modelDetailsPet should have a species_id, but it's not");
    STAssertTrue([test_modelDetailsPet.species_name isKindOfClass:[NSString class]], @"The modelDetailsPet should have a species_name as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.species_name, @"The modelDetailsPet should have a species_name, but it's not");
    STAssertTrue([test_modelDetailsPet.description isKindOfClass:[NSString class]], @"The modelDetailsPet should have a description as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.description, @"The modelDetailsPet should have a description, but it's not");
    STAssertTrue([test_modelDetailsPet.videos isKindOfClass:[NSMutableArray class]], @"The modelDetailsPet should have an array, but it's not");
    
    STAssertTrue([test_modelDetailsPet.created_datetime isKindOfClass:[NSString class]], @"The modelDetailsPet should have a created date as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.created_datetime, @"The modelDetailsPet should have a created date, but it's not");
    STAssertTrue([test_modelDetailsPet.available_until isKindOfClass:[NSString class]], @"The modelDetailsPet should have an available_until as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.available_until, @"The modelDetailsPet should have an available_until, but it's not");
    STAssertTrue([test_modelDetailsPet.organization_id isKindOfClass:[NSString class]], @"The modelDetailsPet should have an organization_id as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.organization_id, @"The modelDetailsPet should have an organization_id, but it's not");
    STAssertTrue([test_modelDetailsPet.date_of_birth isKindOfClass:[NSString class]], @"The modelDetailsPet should have a date of birth as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.date_of_birth, @"The modelDetailsPet should have a date of birth, but it's not");
    STAssertTrue([test_modelDetailsPet.race_id isKindOfClass:[NSString class]], @"The modelDetailsPet should have a race_id as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.race_id, @"The modelDetailsPet should have a race_id, but it's not");
    
    STAssertTrue([test_modelDetailsPet.organization isKindOfClass:[ModelDetailsOrganization class]], @"The modelDetailsPet should have an organization as a ModelDetailsOrganization, but it's not");
    STAssertNotNil(test_modelDetailsPet.organization, @"The modelDetailsPet should have an organization, but it's not");
    
    STAssertTrue([test_modelDetailsPet.race_name isKindOfClass:[NSString class]], @"The modelDetailsPet should have a race name as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.race_name, @"The modelDetailsPet should have a race name, but it's not");
    
    STAssertTrue([test_modelDetailsPet.id_pet isKindOfClass:[NSString class]], @"The modelDetailsPet should have a idPet as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.id_pet, @"The modelDetailsPet should have a idPet, but it's not");
    STAssertTrue([test_modelDetailsPet.name isKindOfClass:[NSString class]], @"The modelDetailsPet should have a name as a String, but it's not");
    STAssertNotNil(test_modelDetailsPet.name, @"The modelDetailsPet should have a name, but it's not");
}
/*   TEST Of ModelDetailsVideo */
-(void)test_initWithDictionary_Model_detailsVideo{
    //deserialize code
    NSURL *urlDetails = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/details"];
    GenericParser *genericParser = [[GenericParser alloc] init];
    NSDictionary *jsonDetails = [genericParser downloadRandomJSONWithURL:urlDetails];
    
    //Into the detailsJson hierarchical
    NSDictionary *test_dictionary_data = [jsonDetails objectForKey:@"data"];
    STAssertNotNil(test_dictionary_data, @"A split dictionary for the key 'data' should exist but it's not.");
    NSDictionary *test_dictionary_pet = [test_dictionary_data objectForKey:@"pet"];
    STAssertNotNil(test_dictionary_pet, @"A split dictionary for the key 'pet' should exist but it's not.");
    NSArray* temp =  [test_dictionary_pet objectForKey:@"videos"];
    STAssertNotNil(temp, @"A temporary array variable should exist to create the good dictionary for videos but it does not");
    
    ModelDetailsVideo *test_modelDetailsVideo = [[ModelDetailsVideo alloc] initWithDictionary:temp[0]];
    STAssertNotNil(test_modelDetailsVideo, @"The modelDetailsVideo should have been created from the dictionary but it's not");
    
    
    STAssertTrue([test_modelDetailsVideo.title isKindOfClass:[NSString class]], @"The modelDetailsVideo should have a title as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.title, @"The modelDetailsVideo should have a title, but it's not");
    STAssertTrue([test_modelDetailsVideo.ordering isKindOfClass:[NSString class]], @"The modelDetailsVideo should have an ordering as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.ordering, @"The modelDetailsVideo should have an ordering, but it's not");
    STAssertTrue([test_modelDetailsVideo.published isKindOfClass:[NSString class]], @"The modelDetailsVideo should have a boolean published as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.published, @"The modelDetailsVideo should have a bolean published, but it's not");
    STAssertTrue([test_modelDetailsVideo.video_link isKindOfClass:[NSString class]], @"The modelDetailsVideo should have a video_link as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.video_link, @"The modelDetailsVideo should have a video_link, but it's not");
    STAssertTrue([test_modelDetailsVideo.created_date isKindOfClass:[NSString class]], @"The modelDetailsVideo should have an created_date as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.created_date, @"The modelDetailsVideo should have a created_date, but it's not");
    STAssertTrue([test_modelDetailsVideo.created_by_id isKindOfClass:[NSString class]], @"The modelDetailsVideo should have an id of the Shelter as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.created_by_id, @"The modelDetailsVideo should have an id of the Shelter, but it's not");
    STAssertTrue([test_modelDetailsVideo.pet_id isKindOfClass:[NSString class]], @"The modelDetailsVideo should have a pet_id as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.pet_id, @"The modelDetailsVideo should have a pet_id, but it's not");
    STAssertTrue([test_modelDetailsVideo.id_video isKindOfClass:[NSString class]], @"The modelDetailsVideo should have a id_video as a String, but it's not");
    STAssertNotNil(test_modelDetailsVideo.id_video, @"The modelDetailsVideo should have a id_video, but it's not");
}

/*   TEST Of ModelDetailsOrganization */
-(void)test_initWithDictionary_Model_detailsOrganization{
    //deserialize code
    NSURL *urlDetails = [[NSURL alloc] initWithString:@"http://78.193.45.72:20081/api/details"];
    GenericParser *genericParser = [[GenericParser alloc] init];
    NSDictionary *jsonDetails = [genericParser downloadRandomJSONWithURL:urlDetails];
    
    //Into the detailsJson hierarchical
    NSDictionary *dictionary_data = [jsonDetails objectForKey:@"data"];
    NSDictionary *dictionary_pet = [dictionary_data objectForKey:@"pet"];
    NSDictionary* test_dictionary_org =  [dictionary_pet objectForKey:@"organization"];
    STAssertNotNil(test_dictionary_org, @"The good organization dictionary should have been created but it's not");
    
    ModelDetailsOrganization *test_organization = [[ModelDetailsOrganization alloc] initWithDictionary:test_dictionary_org];
    STAssertNotNil(test_organization, @"The ModelDetailsOrganization should have been created but it's not");
    
    STAssertTrue([test_organization.youtube_channel isKindOfClass:[NSString class]], @"The modelDetailsOrganization should have a youtube_channel as a String, but it's not");
    STAssertNotNil(test_organization.youtube_channel, @"The modelDetailsOrganization should have a youtube_channel, but it's not");
    STAssertTrue([test_organization.contact_number isKindOfClass:[NSString class]], @"The modelDetailsOrganization should have a contact number as a String, but it's not");
    STAssertNotNil(test_organization.contact_number, @"The modelDetailsOrganization should have a contact number, but it's not");
    STAssertTrue([test_organization.user_id isKindOfClass:[NSString class]], @"The modelDetailsOrganization should have a user id as a String, but it's not");
    STAssertNotNil(test_organization.user_id, @"The modelDetailsOrganization should have a user id, but it's not");
    STAssertTrue([test_organization.name isKindOfClass:[NSString class]], @"The modelDetailsOrganization should have a name as a String, but it's not");
    STAssertNotNil(test_organization.name, @"The modelDetailsOrganization should have a name, but it's not");
    STAssertTrue([test_organization.created_datetime isKindOfClass:[NSString class]], @"The modelDetailsOrganization should have an created_datetime as a String, but it's not");
    STAssertNotNil(test_organization.created_datetime, @"The modelDetailsOrganization should have a created_datetime, but it's not");
    STAssertTrue([test_organization.address isKindOfClass:[NSString class]], @"The modelDetailsOrganization should have an address as a String, but it's not");
    STAssertNotNil(test_organization.address, @"The modelDetailsOrganization should have an address, but it's not");
    STAssertTrue([test_organization.email isKindOfClass:[NSString class]], @"The modelDetailsOrganization should have an email as a String, but it's not");
    STAssertNotNil(test_organization.email, @"The modelDetailsOrganization should have an email, but it's not");
}


/*   TEST OF PET PARSER */
-(void)test_constructor{
    PetParser *test_petParser = [[PetParser alloc] init];
    STAssertNotNil(test_petParser, @"A petParser should have been created but it's not");
}
/*
 -(void)test_createNSDateWithYearMonthDay{
 PetParser *petParser = [[PetParser alloc] init];
 
 NSDate *test_date = [petParser createNSDateWithYear:2012 andMonth:02 atDay:04];
 STAssertNotNil(test_date, @"A NSDate should have been created from the string but it's not");
 
 STAssertTrue([test_date isKindOfClass:[NSDate class]], @"The date should be NSDate type but it's not");
 //STAssertEquals(@"2012-02-04", test_date.description, @"The date contents should be '2012-02-04' but it's not, it's %@",test_date.description);
 }
 -(void)test_createNSDateFromString{
 PetParser *petParser = [[PetParser alloc] init];
 NSString *date_string = [[NSString alloc] init];
 date_string = @"2012-02-04";
 
 NSDate *test_date = [petParser createNSDateFromString:date_string];
 STAssertNotNil(test_date, @"A NSDate should have been created from the string but it's not");
 STAssertTrue([test_date isKindOfClass:[NSDate class]], @"The date should be NSDate type but it's not");
 STAssertEquals(@"2012-02-04", test_date.description, @"The date contents should be '2012-02-04' but it's not, it's %@",test_date.description);
 }
 */
-(void)test_random{
    PetParser *petParser = [[PetParser alloc] init];
    Pet *test_pet = [petParser random];
    STAssertNotNil(test_pet, @"A pet should have been built from the random method here but it's not");
    
    //test of Videos contents
    STAssertNotNil(test_pet.pet_currentVideo, @"The pet should have a video but it has not");
}
-(void)test_next{
    //PetParser *petParser = [[PetParser alloc] init];
    //Pet *test_pet = [petParser next];
    //STAssertNotNil(test_pet, @"A pet should have been built from the next method here but it's not");
}







- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in PetRouletteTests");
}

@end
