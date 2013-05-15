//
//  VideosTableViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 05/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "TestViewController.h"
#import "SingleVideoViewController.h"
#import "CustomCell.h"
#import "Video.h"
//#import "PSYouTubeView.h"
#import "LBYouTubePlayerController.h"
#import "VideosTableViewController.h"

@interface VideosTableViewController ()

@property (strong, nonatomic) LBYouTubePlayerController *player;

//URL pour voir la premiere image d'une video
//http://img.youtube.com/vi/FMVVDm1mwvM/0.jpg

@property (strong, nonatomic) NSArray *video_list;

@end

@implementation VideosTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.current_pet){
        self.video_list = self.current_pet.pet_videoList;
    }
    else {
        // Pop-up
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"PROBLEM"
                              message: @"There is no pet we can display details"
                              delegate: nil
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK",nil];
        [alert show];
    }


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(self.current_pet){
        return self.current_pet.pet_videoList.count;
    }
    else return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us have the image of the video
 URL pour voir la premiere image d'une video
 http://img.youtube.com/vi/FMVVDm1mwvM/0.jpg
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToImageYouTubeURL:(NSString*)urlTarget{
    
    NSArray *youtube_url_Array = [urlTarget componentsSeparatedByString:@"/"];
    
        
    //Initialization of a NSMutableString
    NSMutableString *url_final = [[NSMutableString alloc] init];
    
    //We get the last element of the array wich contains the identifier of the video
    url_final = [youtube_url_Array lastObject];
    
    //If the url string contains 'watch?v='
    if ([url_final hasPrefix:@"watch?v="]){
            NSArray *identifier = [url_final componentsSeparatedByString:@"="];
            url_final = [identifier lastObject];
    }
    //We concatenate withthe missing part of the url
    url_final = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", url_final];
    return url_final;
}

/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us to change any url to the second format, with '/watch?v=' instead of 'embed'
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToGoodFormat:(NSString*)urlTarget{
    NSArray *youtube_url_Array = [urlTarget componentsSeparatedByString:@"/"];
    
    int indice=-2; //To be sure it can not be to 0
    
    //Initialization of a NSMutableString
    NSMutableString *url_final = [[NSMutableString alloc] init];
    
    //We get the first element of the array
    url_final = youtube_url_Array[0];
    
    //For each element
    for (int i = 1 ; i < youtube_url_Array.count ; i++){
        
        //We get the content of the element
        NSString *part = [youtube_url_Array objectAtIndex:i];
        
        //If the url string contains 'embed' instead of 'watch?v='
        if ([part isEqualToString:@"embed"]){
            //we keep the indice
            indice = [youtube_url_Array indexOfObject:part];
            //we concatenate with 'watch?v=' instead of '/embed/' element
            url_final = [NSString stringWithFormat:@"%@/watch?v=", url_final];
        }
        else{
            //if we are after the embed part, the identifier of the you tube video
            if([youtube_url_Array indexOfObject:part] == indice+1) {
                //we concatenate the identifier to 'watch?v='
                url_final = [NSString stringWithFormat:@"%@%@", url_final, part];
            }
            else{
                //else we concatenate as it was before
                url_final = [NSString stringWithFormat:@"%@/%@", url_final, part];
            }
        }
    }
    return url_final;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil){        
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    NSString *url_final = [self convertYouTubeURLToImageYouTubeURL:[[self.video_list objectAtIndex:indexPath.row] video_url]];
     NSURL *youTubeURL = [NSURL URLWithString:url_final];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:youTubeURL];
    cell.myImageView.image = [UIImage imageWithData:imageData];
    
    //for(int i = 0 ; i<10000 ; i++){
        
    //}
    
    cell.primaryLabel.text = [NSString stringWithFormat:@"VIDEO NUMERO %ld", (long)indexPath.row+1];
    cell.secondaryLabel.text = self.current_pet.pet_name;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*//TEST
    //Really short video -> for test
    NSURL *test_youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=wXw6znXPfy4"];
    self.player = [[LBYouTubePlayerController alloc] initWithYouTubeURL:test_youTubeURL quality:LBYouTubeVideoQualityLarge];

    
    self.player.delegate = self;
    self.player.view.frame = CGRectMake(0.0f, 0.0f, 200.0f, 200.0f);
    self.player.view.center = self.view_video.center;
    [self.view_video addSubview:self.player.view];
    */
     
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    
    /* TEST
    TestViewController *test = [[TestViewController alloc] initWithNibName:@"Nib name" bundle:nil];
    
    //transform the url of the current pet if it is needed to the good way
    NSString *url_final = [self convertYouTubeURLToGoodFormat:[[self.video_list objectAtIndex:indexPath.row] video_url]];
    
    //NSLog(@"L'URL FINAL EST LE SUIVANT : %@", url_final);
    NSURL *youTubeURL = [NSURL URLWithString:url_final];
    
    test.url_video = youTubeURL;
    
    [self.navigationController pushViewController:test animated:YES];
    */
   
     
}
/*
 Method called when an action on one of the button is made
 @param segue corespond to the link between the button and the target view
 @param id correspond to the sender button
 
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //We identify what kind of link is concerned
    if ([segue.identifier isEqualToString:@"playVideoPush"]){
        
        //We get the target view controller
        //SingleVideoViewController *singleVideoViewController = [segue destinationViewController];
       
        TestViewController *singleVideoViewController = [segue destinationViewController];
        
        
       NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        //We send the details we want : here we give the url video
        if (self.current_pet){
            
            //transform the url of the current pet if it is needed to the good way
            NSString *url_final = [self convertYouTubeURLToGoodFormat:[[self.video_list objectAtIndex:indexPath.row] video_url]];
            
            //NSLog(@"L'URL FINAL EST LE SUIVANT : %@", url_final);
            NSURL *youTubeURL = [NSURL URLWithString:url_final];
            
            singleVideoViewController.url_video = youTubeURL;
        }
    }
}*/

@end
