class AdvertisementImage {
  final int imageId;
  final int adId;
  final String imageType;
  final String imageUrl;

  AdvertisementImage({
    required this.imageId,
    required this.adId,
    required this.imageType,
    required this.imageUrl,
  });

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) {
    return AdvertisementImage(
      imageId: json['imageId'],
      adId: json['adId'],
      imageType: json['imageType'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}