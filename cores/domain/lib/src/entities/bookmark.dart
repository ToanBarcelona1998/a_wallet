final class BookMark {
  final int id;
  final String logo;
  final String name;
  final String? description;
  final String url;

  const BookMark({
    required this.id,
    required this.logo,
    required this.name,
    this.description,
    required this.url,
  });
}
