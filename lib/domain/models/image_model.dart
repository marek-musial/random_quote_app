class ImageModel {
  ImageModel({
    required this.imageUrl,
  });

  final String imageUrl;

  ImageModel.fromJson(List<dynamic> json) : imageUrl = json[0];
}
