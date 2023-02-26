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
