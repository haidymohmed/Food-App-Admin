class Product{
  late String  id ,image , category ;
  String? nameAr , nameEn  , descriptionAr , descriptionEn;
  late double  cale , protein , carb , fat , rate , price;
  late bool needRise , needPasta , needPotatoes ,needSalad ;
  DateTime? date;
  int? quantity = 1;
  Product({
    this.nameEn,
    this.descriptionEn,
    this.descriptionAr,
    this.nameAr,
    required this.date,
    required this.id,
    required this.image,
    required this.category,
    required this.cale,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.rate,
    required this.price,
    required this.needRise,
    required this.needPasta,
    required this.needPotatoes,
    required this.needSalad,
    this.quantity
  });

  toJson(){
    return {
      "id" : id,
      "image" : image,
      "category" : category,
      "cale" : cale,
      "pro" : protein,
      "carb" : carb,
      "fat" : fat,
      "rate" : rate,
      "price" : price,
      "needRise" : needRise,
      "needPasta" : needPasta,
      "needPotatos" : needPotatoes,
      "needSalad" : needSalad,
      "quantity" : quantity,
      "date" : date,
      "descriptionAr" : descriptionAr,
      "descriptionEn" : descriptionEn,
      "nameAr" : nameAr,
      "nameEn" : nameEn,
    };
  }
  Product.fromJason(data){
    id = data['id'];
    image = data['image'];
    category = data['category'];
    cale = data['cale'];
    protein = data['pro'];
    carb = data['carb'];
    fat = data['fat'];
    rate = data['rate'];
    price = data['price'];
    needRise = data['needRise'];
    needPasta = data['needPasta'];
    needPotatoes = data['needPotatos'];
    needSalad = data['needSalad'];
    quantity = data['quantity'];
    descriptionAr = data['descriptionAr'];
    descriptionEn = data['descriptionEn'];
    nameAr = data['nameAr'];
    nameEn = data['nameEn'];
  }
}