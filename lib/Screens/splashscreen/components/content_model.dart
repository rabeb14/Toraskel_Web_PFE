class SplashscreenContent {
  String image;
  String title;
  String discription;

  SplashscreenContent({this.image, this.title, this.discription});
}

List<SplashscreenContent> contents = [
  SplashscreenContent(
    title: 'Recyclage',
    image: 'assets/images/splash1.json',
    discription: "N'hésitez pas à stocker, trier et valoriser vos déchets avec ToRaskel" 
  
  ),
  SplashscreenContent(
    title: 'Cadeaux',
    image: 'assets/images/splash2.json',
    discription: "Recyclez vos dépôts et recevez plein de cadeaux "
    
  ),
  SplashscreenContent(
    title: 'Scanner',
    image: 'assets/images/splash3.json',
    discription: "Scannez vos déchets pour les trier"
    
  ),
];