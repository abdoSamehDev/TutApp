import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/app/extensions.dart';
import 'package:advanced_flutter_arabic/data/responses/responses.dart';
import 'package:advanced_flutter_arabic/domain/model/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.status.orZero() ?? Constants.zero,
      this?.message.orEmpty() ?? Constants.empty,
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgotPasswordMapper on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(
        this?.status.orZero() ?? Constants.zero,
        this?.message.orEmpty() ?? Constants.empty,
        this?.code.orEmpty() ?? Constants.empty);
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(
        this?.id.orZero() ?? Constants.zero,
        this?.link.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();
    List<Banner> banners = (this
                ?.data
                ?.banners
                ?.map((bannerResponse) => bannerResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Banner>()
        .toList();
    List<Store> stores =
        (this?.data?.stores?.map((storeResponse) => storeResponse.toDomain()) ??
                const Iterable.empty())
            .cast<Store>()
            .toList();

    HomeData data = HomeData(services, banners, stores);
    return HomeObject(
      this?.status.orZero() ?? Constants.zero,
      this?.message.orEmpty() ?? Constants.empty,
      data,
    );
  }
}
