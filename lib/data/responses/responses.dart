import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.name, this.id, this.numOfNotifications);

  //from Json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone, this.email, this.link);

  //from Json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);

}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

  //from Json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "code")
  String? code;

  ForgotPasswordResponse(this.code);

  //from Json
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}


@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "image")
  String? image;

  ServiceResponse(this.id, this.title, this.image);

  //from Json
  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "link")
  String? link;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "image")
  String? image;

  BannerResponse(this.id, this.link, this.title, this.image);

  //from Json
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "image")
  String? image;

  StoreResponse(this.id, this.title, this.image);

  //from Json
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServiceResponse>? services;

  @JsonKey(name: "banners")
  List<BannerResponse>? banners;

  @JsonKey(name: "stores")
  List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  //from Json
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "data")
  HomeDataResponse? data;


  HomeResponse(this.data);

  //from Json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}