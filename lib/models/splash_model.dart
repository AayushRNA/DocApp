
class SplashModel{
  final String imageAsset;
  final String title;
  final String description;

  SplashModel(this.imageAsset,this.title,this.description);

}


List<SplashModel> splashList = [
  SplashModel('assets/1.png', 'Start making money!',
      'Do you have something to sell Post your first ad and start making money!'),
  SplashModel('assets/2.png', 'Search your favorite house for rent',
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, '),
  SplashModel('assets/3.png', 'Sale your Unnecessary items',
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
];