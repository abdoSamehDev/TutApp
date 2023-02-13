//onBoarding models
class SliderObject {
  String title;
  String body;
  String image;

  SliderObject(this.title, this.body, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int currentIndex;
  int numOfSlides;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSlides);
}
