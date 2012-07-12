//
//  MapViewController.m
//  Real Time Life
//
//  Created by Ádamo Morone on 17/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "Event.h"
#import "EventDetailViewController.h"
#import "CheckInViewController.h"
#import "JSON.h"
#import "AppDelegate.h"


@interface MapViewController ()

@end

@implementation MapViewController

@synthesize checkIn;
@synthesize mapView;
@synthesize eventDetail;
@synthesize eventArray;

@synthesize locationManager;
@synthesize startLocation;
@synthesize zoomLocation;
@synthesize refresh;
@synthesize resetLocation;
@synthesize panGesture;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
     
    [super viewDidLoad];
    
    
    [self.checkIn setAction:@selector(CheckIn:)];
    
    
    //Faz o setup das coordenads
    [self ResetUserLocation: self];
    
    
    [self RefreshScreen: self];
    
	//Seta o delegate do mapView para a classe.
    mapView.delegate=(id)self;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(ShowButton)];
    self.panGesture.delegate = (id)self;
    
    
    [self.mapView addGestureRecognizer:self.panGesture];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshScreen:) name:@"CheckinComplete" object:nil];

}




- (void)ShowButton
{
    if(refresh.alpha == 0.0){
        [UIView animateWithDuration:0.25 animations:^{refresh.alpha = 1.0;}];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {   
    return YES;
}


-(IBAction)ResetUserLocation:(id)sender{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
    locationManager.distanceFilter = kCLDistanceFilterNone; 
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    self.zoomLocation = [location coordinate];
    
     MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.zoomLocation , 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
     MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion]; 
    [mapView setRegion:adjustedRegion animated:YES]; 
    
}

- (void) LoadCoordinationSetup{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
    locationManager.distanceFilter = kCLDistanceFilterNone; 
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    self.zoomLocation = [location coordinate];
    
    
    //Determina uma área ao redor do ponto que setei acima. É usado para determinar o "zoom" que vai iniciar o sistema.
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.zoomLocation , 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.zoomLocation , 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion]; 
    [mapView setRegion:adjustedRegion animated:YES]; 
    
    
    
}





#pragma mark MKMapViewDelegate


//Método que lê todos os Annotations que foram associados ao mapa.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)ann
{
    
	// Se for a locação do usuário retorna nulo e não troca nada.
    if ([ann isKindOfClass:[MKUserLocation class]])
        return nil;
	
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView* pinView = [[MKAnnotationView alloc] initWithAnnotation:ann reuseIdentifier:AnnotationIdentifier];
    
    //Seta se vc quer que o pino caia com animação.
    //Esta propriedade não existe para MKAnnotationView. Funciona apenas para MKPinAnnotationView.
    //TODO: Pesquisar se existe forma de fazer.
	//pinView.animatesDrop=YES;
    
    //Seta se o pino pode ser clicável ou não.
	pinView.canShowCallout=YES;
    
    
    
    
    //Cria o botão de detalhe.
    //Esse comando é para o botão de info.
    //[UIButton buttonWithType:UIButtonTypeInfoLight];
    //Esse comando é para o botão azul.
    //[UIButton buttonWithType:UIButtonTypeDetailDisclosure]
    
    //Cria o RightButton
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    //[rightButton setTag:ann.idUser forState:UIControlStateNormal];
    
    //[rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    
	pinView.rightCalloutAccessoryView = rightButton;
    
    
    //Joga o RightButton para a direita da caixinha do PinView
	pinView.rightCalloutAccessoryView = rightButton;
    
    
    /*
     Aqui fica o set do pin atual.
     Minha sugestão é que seja customizado um PIN para cada tipo de dado que for postado.
     Ex: Imagem, o pin é vermelho - Video, o pin é verde - Ambos, pin branco etc.
     */
    
    pinView.image = [UIImage imageNamed:@"event.png"];
    
    
    
    //Seta imagem de profile para o pin 
    //COMENTÁRIO: Não acho que seja muito necessária esta imagem (que precisa ser reajustada, no caso abaixo).
    //A imagem pode aparecer no momento quem o usuário clica no "More Info".
	UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile.png"]];
	pinView.leftCalloutAccessoryView = profileIconView;
    
    
	return pinView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier: @"eventDetailSegue" sender: view.annotation];
}


//Método chamado antes de rodar todos os SEGUE
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"eventDetailSegue"]) {
        EventDetailViewController *vc = [segue destinationViewController];
        Event *view = (Event *) sender;
        vc.event = view;
    }else if([[segue identifier] isEqualToString:@"checkInSegue"]){
        CheckInViewController *checkin = [segue destinationViewController];
        checkin.Location = self.zoomLocation;
    }
}


-(IBAction)CheckIn:(id)sender
{
    [self performSegueWithIdentifier: @"checkInSegue" sender: sender];
}


-(IBAction)LookForUpdates:(id)sender{
       [UIView animateWithDuration:0.25 animations:^{refresh.alpha = 0.0;}];
    
    [self performSelectorInBackground:@selector(RefreshScreen:) withObject:self];
       //[self RefreshScreen: self];
}

-(IBAction)RefreshScreen:(id)sender
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    for (int i =0; i < [mapView.annotations count]; i++) { 
        if ([[mapView.annotations objectAtIndex:i] isKindOfClass:[Event class]]) {                      
            [mapView removeAnnotation:[mapView.annotations objectAtIndex:i]]; 
        } 
    }
    
    
    //##############################################
    //TUDO ABAIXO DEVE SER SUBSTITUÍDO POR UMA CLASSE COM REQUISIÇÃO
    //AO BANCO DE DADOS ETC.   
    
    self.eventArray = [[NSMutableArray alloc] init];
    
    SBJSON *parser = [[SBJSON alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://timelive.herokuapp.com/all_updates.json"]];
    
    //Faz a requisição e pega um JSON como um objeto do tipo NSData
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //Retorna o JSON como um NSString do NSData que pegamos anteriormente
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    //Faz parse do JSON em objeto
    NSArray *statuses = [parser objectWithString:json_string error:nil];
    
    
    
    
    //Para cada objeto encontrado
    for (NSDictionary *status in statuses)
    {
        
        Event* event=[[Event alloc] init];
        CLLocationCoordinate2D theCoordinate;
        
        theCoordinate.latitude = [[status objectForKey:@"geo_latitude"] doubleValue];
        theCoordinate.longitude = [[status objectForKey:@"geo_longitude"] doubleValue];
        
        event.coordinate=theCoordinate;
        event.title=[status objectForKey:@"message"];
        event.subtitle=[[status objectForKey:@"user"] objectForKey:@"name"];
        event.idUser=[[[status objectForKey:@"user"] objectForKey:@"name"] intValue];
        event.idUpdate = [[status objectForKey:@"id"] intValue];
        
        [self.eventArray addObject:event];
        
    }
    
    
    //Adiciona os events no mapa
    for (id <MKAnnotation> event in self.eventArray) {
        [mapView addAnnotation:event]; 
    }
    
    UIBarButtonItem* temp=[[UIBarButtonItem alloc] init];
	temp.title=@"Back";
	self.navigationItem.backBarButtonItem=temp;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}




- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setCheckIn:nil];
    [self setRefresh:nil];
    [self setResetLocation:nil];
    [self setRefresh:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
