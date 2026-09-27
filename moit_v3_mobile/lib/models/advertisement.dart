import '../models/advertisement_image.dart';

class Advertisement {
  final int adId;
  final int? advertiserId;
  final String? advertiserNickname;

  final String title;
  final String? content;
  final String? landingUrl;

  final String? adGrade;
  final String? status;
  final String? approvalStatus;
  final String? paymentStatus;

  final int? impressions;
  final int? clicks;
  final int? priorityScore;

  final double? totalBudget;

  final List<AdvertisementImage> imageList;

  Advertisement({
    required this.adId,
    this.advertiserId,
    this.advertiserNickname,
    required this.title,
    this.content,
    this.landingUrl,
    this.adGrade,
    this.status,
    this.approvalStatus,
    this.paymentStatus,
    this.impressions,
    this.clicks,
    this.priorityScore,
    this.totalBudget,
    required this.imageList,
  });

  AdvertisementImage? get mainImage {
    for (final image in imageList) {
      if (image.imageType == 'MAIN') {
        return image;
      }
    }

    return null;
  }

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      adId: json['adId'],
      advertiserId: json['advertiserId'],
      advertiserNickname: json['advertiserNickname'],
      title: json['title'] ?? '',
      content: json['content'],
      landingUrl: json['landingUrl'],

      adGrade: json['adGrade'],
      status: json['status'],
      approvalStatus: json['approvalStatus'],
      paymentStatus: json['paymentStatus'],

      impressions: json['impressions'],
      clicks: json['clicks'],
      priorityScore: json['priorityScore'],

      totalBudget: json['totalBudget'] != null
          ? double.tryParse(json['totalBudget'].toString())
          : null,

      imageList: (json['imageList'] as List? ?? [])
          .map(
            (image) => AdvertisementImage.fromJson(
              Map<String, dynamic>.from(image),
            ),
          )
          .toList(),
    );
  }
}