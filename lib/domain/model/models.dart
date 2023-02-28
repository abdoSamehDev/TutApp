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

//login models
class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  int status;
  String message;
  Customer? customer;
  Contacts? contacts;

  Authentication(this.status, this.message, this.customer, this.contacts);
}

class ForgotPassword {
  int status;
  String message;
  String code;

  ForgotPassword(this.status, this.message, this.code);
}

class Service {
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}

class BannerAd {
  int id;
  String link;
  String title;
  String image;

  BannerAd(this.id, this.link, this.title, this.image);
}

class Store {
  int id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  int status;
  String message;
  HomeData? data;

  HomeObject(this.status, this.message, this.data);
}
