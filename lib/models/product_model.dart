class ProductModel {
  String? category;
  String? id;
  String? productName;
  String? detail;
  String? brand;
  int? price;
  int? discountPrice;
  String? serialCode;
  List<dynamic>? imageUrls;
  bool? isSale;
  bool? isPopular;
  bool? isFavourite;

  ProductModel({
    this.category,
    this.id,
    this.productName,
    this.detail,
    this.price,
    this.brand,
    this.discountPrice,
    this.serialCode,
    this.imageUrls,
    this.isSale,
    this.isPopular,
    this.isFavourite,
  });
}
