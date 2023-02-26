class LoginRequest {
  String email;
  String password;

  LoginRequest(
    this.email,
    this.password,
  );
}

class RegisterRequest {
  String username;
  String email;
  String password;
  String countryMobileCode;
  String mobile;
  String profilePic;

  RegisterRequest(
    this.username,
    this.email,
    this.password,
    this.countryMobileCode,
    this.mobile,
    this.profilePic,
  );
}
