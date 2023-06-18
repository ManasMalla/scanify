class Document {
  final DateTime date;
  final String name;
  final String image;
  final List<String> tags;
  const Document(this.date, this.name, this.image, {this.tags = const []});
}
