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
#import "JSON.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize checkIn;
@synthesize mapView;
@synthesize eventDetail;
@synthesize eventArray;

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
    
	//Seta o delegate do mapView para a classe.
    mapView.delegate=(id)self;
    
    
    self.eventArray = [[NSMutableArray alloc] init];
    
    
    //##############################################
    //TUDO ABAIXO DEVE SER SUBSTITUÍDO POR UMA CLASSE COM REQUISIÇÃO
    //AO BANCO DE DADOS ETC.   
    

    
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
        
        //SBJSON *parser2 = [[SBJSON alloc] init];
        //NSArray *userData = [parser2 objectWithString:[status objectForKey:@"user"] error:nil];
            
        Event* event=[[Event alloc] init];
        CLLocationCoordinate2D theCoordinate;
        
        theCoordinate.latitude = [[status objectForKey:@"geo_latitude"] doubleValue];
        theCoordinate.longitude = [[status objectForKey:@"geo_longitude"] doubleValue];
        
        event.coordinate=theCoordinate;
        event.title=[status objectForKey:@"message"];
        event.subtitle=@"Teste"; //[userData objectAtIndex:1];
        event.idUser=[[status objectForKey:@"id"] intValue];
        
        [self.eventArray addObject:event];
        
    }
    
    
    //Adiciona os events no mapa
    for (id <MKAnnotation> event in self.eventArray) {
        [mapView addAnnotation:event]; 
    }
    
    UIBarButtonItem* temp=[[UIBarButtonItem alloc] init];
	temp.title=@"Back";
	self.navigationItem.backBarButtonItem=temp;
}



- (void)viewWillAppear:(BOOL)animated {  
    
    
    //Seta um ponto de latitude e longitude
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.78575;
    zoomLocation.longitude= -122.406374;
    
    
    //Determina uma área ao redor do ponto que setei acima. É usado para determinar o "zoom" que vai iniciar o sistema.
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    
    //Aqui é para trimar a área que selecionamos para caber dentro da tela.
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    
    //Seta o mapa para híbrido.
    //mapView.mapType = MKMapTypeHybrid;
    
    //Associa a região e o zoom ao objeto MAPA.
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
    }
}


-(IBAction)CheckIn:(id)sender
{
    [self performSegueWithIdentifier: @"checkInSegue" sender: sender];
}




- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setCheckIn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
