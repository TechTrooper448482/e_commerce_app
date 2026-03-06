/// Domain entity for a single promo banner on the discovery home screen.
class BannerEntity {
  const BannerEntity({
    required this.imageUrl,
    this.title,
    this.subtitle,
  });

  final String imageUrl;
  final String? title;
  final String? subtitle;
}
