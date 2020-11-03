class Posts {
  final int id;
  final int user_id;
  final String name;
  final String details;
  final String price;
  final String image;
  final String tmp_name;
  final String rate;

  Posts({this.id, this.user_id, this.name, this.details , this.price , this.image , this.tmp_name , this.rate});

  factory Posts.formJson(Map <String, dynamic> json){

    return new Posts(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      price: json['price'],
      image: json['image'],
      tmp_name: json['tmp_name'],
      rate: json['rate'],
    );
  }
}