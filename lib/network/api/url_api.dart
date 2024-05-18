class BASEURL {
  static String apiRegister = "http://localhost/medhealth_db/register_api.php";
  static String apiLogin = "http://localhost/medhealth_db/login_api.php";
  static String apiGetProductWithCategory = "http://localhost/medhealth_db/get_product_with_category.php";
  static String apiGetProduct = "http://localhost/medhealth_db/get_product.php";
}

void main() {
  print(BASEURL.apiRegister);
  print(BASEURL.apiLogin);
}

