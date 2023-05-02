class Basket {
  final String? name;
  final String? type;

  Basket({this.name, this.type});
  @override
  String toString() {
    // TODO: implement toString
    return "$type:$name";
  }
}
