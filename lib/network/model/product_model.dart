class CategoryWithProduct {
  final String idCategory;
  final String category;
  final String image;
  final String status;
  final List<ProductModel> product;

  CategoryWithProduct(
      {required this.idCategory,
      required this.category,
      required this.image,
      required this.status,
      required this.product});

  factory CategoryWithProduct.fromJson(Map<String, dynamic> data) {
  var list = data['product'] as List? ?? [];
  List<ProductModel> listProduct = 
    list.map((e) => ProductModel.fromJson(e)).toList();
  return CategoryWithProduct(
    idCategory: data['idCategory']?.toString() ?? '',
    category: data['category']?.toString() ?? '',
    image: data['image']?.toString() ?? '',
    status: data['status']?.toString() ?? '',
    product: listProduct,
  );
}

}

class ProductModel {
  final String idProduct;
  final String idCategory;
  final String nameProduct;
  final String description;
  final String imageProduct;
  final String price;
  final String status;
  final String createdAt;

  ProductModel(
      {required this.idProduct,
      required this.idCategory,
      required this.nameProduct,
      required this.description,
      required this.imageProduct,
      required this.price,
      required this.status,
      required this.createdAt});
      
  factory ProductModel.fromJson(Map<String, dynamic> data) {
  return ProductModel(
    idProduct: data['id_product']?.toString() ?? '',
    idCategory: data['id_category']?.toString() ?? '',
    nameProduct: data['name']?.toString() ?? '',
    description: data['description']?.toString() ?? '',
    imageProduct: data['image']?.toString() ?? '',
    price: data['price']?.toString() ?? '',
    status: data['status']?.toString() ?? '',
    createdAt: data['created_at']?.toString() ?? '',
  );
}

}
