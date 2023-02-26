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
      this?.code.orEmpty() ?? Constants.empty
    );
  }
}
