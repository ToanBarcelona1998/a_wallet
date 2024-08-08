final class AddBookMarkParameter{
  final String logo;
  final String name;
  final String? description;
  final String url;

  const AddBookMarkParameter({
    required this.logo,
    required this.name,
    this.description,
    required this.url,
  });
}