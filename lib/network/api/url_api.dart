class BASEURL {
  static String apiRegister = "http://localhost/medhealth_db/register_api.php";
  static String apiLogin = "http://localhost/medhealth_db/login_api.php";
}

void main() {
  print(BASEURL.apiRegister);
  print(BASEURL.apiLogin);
}

