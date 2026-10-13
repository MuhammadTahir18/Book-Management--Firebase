
class BookModel {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final double price;

  const BookModel({
    this.id='',
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
  });
}
