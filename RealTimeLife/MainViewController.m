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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Seta o delegate do mapView para a classe.
    mapView.delegate=self;
    
    //##############################################
    //TUDO ABAIXO DEVE SER SUBSTITUÍDO POR UMA CLASSE COM REQUISIÇÃO
    //AO BANCO DE DADOS ETC.   
    
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
    myAnnotation1.idUser = 1;
	
	MyAnnotation* myAnnotation2=[[MyAnnotation alloc] init];
	
	myAnnotation2.coordinate=theCoordinate2;
	myAnnotation2.title=@"Acho certo sorvete com bacon!";
	myAnnotation2.subtitle=@"Bruno Assis";
    myAnnotation1.idUser = 2;
	
	MyAnnotation* myAnnotation3=[[MyAnnotation alloc] init];
	
	myAnnotation3.coordinate=theCoordinate3;
	myAnnotation3.title=@"Vai tomar no cú, fdp!";
	myAnnotation3.subtitle=@"Ádamo Morone";
    myAnnotation1.idUser = 3;
	
	MyAnnotation* myAnnotation4=[[MyAnnotation alloc] init];
	
	myAnnotation4.coordinate=theCoordinate4;
	myAnnotation4.title=@"Viv le Zé";
	myAnnotation4.subtitle=@"Mauricio Vaglio";
    myAnnotation1.idUser = 1;
	
    
    
    //Adiciona os annotation no mapa
	[mapView addAnnotation:myAnnotation1];
	[mapView addAnnotation:myAnnotation2];
	[mapView addAnnotation:myAnnotation3];
	[mapView addAnnotation:myAnnotation4];
   //##############################################
	
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
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
	// Se for a locação do usuário retorna nulo e não troca nada.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
	
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    
    MKAnnotationView* pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    
    //Seta se vc quer que o pino caia com animação.
    //Esta propriedade não existe para MKAnnotationView. Funciona apenas para MKPinAnnotationView.
    //TODO: Pesquisar se existe forma de fazer.
	//pinView.animatesDrop=YES;
    
    //Seta se o pino pode ser clicável ou não.
	pinView.canShowCallout=YES;
    
    
    //Cria o botão de detalhe: Setinha azul.
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
	[rightButton addTarget:self
					action:@selector(showDetails:)
		  forControlEvents:UIControlEventTouchUpInside];
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
	UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile-avatar.gif"]];
	pinView.leftCalloutAccessoryView = profileIconView;
    
    
	return pinView;
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
