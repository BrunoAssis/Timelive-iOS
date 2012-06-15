//
//  ViewController.m
//  RealTimeLife
//
//  Created by Ádamo Morone on 14/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"



@interface ViewController ()

@end

@implementation ViewController

@synthesize mapView;

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	NSLog(@"welcome into the map view annotation");
    
	// Se for a locação do usuário retorna nulo e não troca nada.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
	
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
	MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
									 initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    
    //Seta se vc que que o pino caia com animação.
	pinView.animatesDrop=YES;
    
    //Seta se o pino pode ser clicável ou não.
	pinView.canShowCallout=YES;
    
    //Deixa o pino roxinho
	//pinView.pinColor=MKPinAnnotationColorPurple;
    
    //Cria o botão de detalhe: Setinha azul.
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
	[rightButton addTarget:self
					action:@selector(showDetails:)
		  forControlEvents:UIControlEventTouchUpInside];
	pinView.rightCalloutAccessoryView = rightButton;
    
    
    //Seta imagem de profile para o pin
    /*
     *TODO: Acertar o caminho da imagem.
     */
	UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"../resources/profile.png"]];
	pinView.leftCalloutAccessoryView = profileIconView;
    
    
	return pinView;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Seta o delegate do mapView para a classe.
    mapView.delegate=self;
    
    //Array para carregar todos os pins posteriormente.
    NSMutableArray* annotations=[[NSMutableArray alloc] init];
    
    
    //Seta 4 coordenadas para colocar os pins,
	CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = 37.785309;
    theCoordinate1.longitude = -122.409743;
	
	CLLocationCoordinate2D theCoordinate2;
    theCoordinate2.latitude = 37.786428;
    theCoordinate2.longitude = -122.405441;
	
	CLLocationCoordinate2D theCoordinate3;
    theCoordinate3.latitude = 37.78792;
    theCoordinate3.longitude = -122.407726;
	
	CLLocationCoordinate2D theCoordinate4;
    theCoordinate4.latitude = 37.784987;
    theCoordinate4.longitude = -122.407286;
	
    
    //Cria 4 objetos do tipo annotation e seta coordenada, título e subtítulo
	MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
	
	myAnnotation1.coordinate=theCoordinate1;
	myAnnotation1.title=@"É foda, truta!";
	myAnnotation1.subtitle=@"Mauricio Vaglio.";
	
	MyAnnotation* myAnnotation2=[[MyAnnotation alloc] init];
	
	myAnnotation2.coordinate=theCoordinate2;
	myAnnotation2.title=@"Acho certo sorvete com bacon!";
	myAnnotation2.subtitle=@"Bruno Assis";
	
	MyAnnotation* myAnnotation3=[[MyAnnotation alloc] init];
	
	myAnnotation3.coordinate=theCoordinate3;
	myAnnotation3.title=@"Vai tomar no cú, fdp!";
	myAnnotation3.subtitle=@"Ádamo Morone";
	
	MyAnnotation* myAnnotation4=[[MyAnnotation alloc] init];
	
	myAnnotation4.coordinate=theCoordinate4;
	myAnnotation4.title=@"Viv le Zé";
	myAnnotation4.subtitle=@"Mauricio Vaglio";
	
    
    
    //Adiciona os annotation no mapa
	[mapView addAnnotation:myAnnotation1];
	[mapView addAnnotation:myAnnotation2];
	[mapView addAnnotation:myAnnotation3];
	[mapView addAnnotation:myAnnotation4];
	
	[annotations addObject:myAnnotation1];
	[annotations addObject:myAnnotation2];
	[annotations addObject:myAnnotation3];
	[annotations addObject:myAnnotation4];
    
    NSLog(@"%d",[annotations count]);
    
    
	
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



- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
