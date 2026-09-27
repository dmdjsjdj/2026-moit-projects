import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/advertisement_api.dart';
import '../models/advertisement.dart';
import '../models/advertisement_image.dart';

class AdvertisementBanner extends StatefulWidget {
  final String position;

  const AdvertisementBanner({
    super.key,
    required this.position,
  });

  @override
  State<AdvertisementBanner> createState() =>
      _AdvertisementBannerState();
}

class _AdvertisementBannerState
    extends State<AdvertisementBanner> {

  final AdvertisementApi advertisementApi =
      AdvertisementApi();

  Advertisement? ad;

  bool loading = true;
  bool showContent = false;
  bool impressionSent = false;

  @override
  void initState() {
    super.initState();
    loadAdvertisement();
  }

  // =========================================================
  // 광고 조회
  // =========================================================

  Future<void> loadAdvertisement() async {
    try {
      final result =
          await advertisementApi.getTopAdvertisement(
        position: widget.position,
      );

      if (!mounted) return;

      setState(() {
        ad = result;
        loading = false;
        showContent = false;
      });

      // 광고 노출
      if (result != null) {
        await sendImpression(result);
      }

    } catch (e) {
      debugPrint(
        '${widget.position} 광고 조회 실패: $e',
      );

      if (!mounted) return;

      setState(() {
        loading = false;
        ad = null;
      });
    }
  }

  // =========================================================
  // 광고 노출
  // =========================================================

  Future<void> sendImpression(
    Advertisement advertisement,
  ) async {
    if (impressionSent) return;

    try {
      await advertisementApi.increaseImpression(
        adId: advertisement.adId,
        position: widget.position,
      );

      impressionSent = true;

    } catch (e) {
      debugPrint(
        '광고 노출 처리 실패: $e',
      );
    }
  }

  // =========================================================
  // 광고 클릭
  // =========================================================

  Future<void> handleClick() async {
    final advertisement = ad;

    if (advertisement == null) return;

    try {
      await advertisementApi.increaseClick(
        adId: advertisement.adId,
        position: widget.position,
      );

    } catch (e) {
      debugPrint(
        '광고 클릭 처리 실패: $e',
      );
    }

    // React의 window.location.href 대응
    final landingUrl = advertisement.landingUrl;

    if (landingUrl == null || landingUrl.isEmpty) {
      return;
    }

    final uri = Uri.tryParse(landingUrl);

    if (uri == null) {
      return;
    }

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  // =========================================================
  // 현재 position에 맞는 이미지
  // =========================================================

  AdvertisementImage? getAdImage() {
    final advertisement = ad;

    if (advertisement == null) {
      return null;
    }

    for (final image in advertisement.imageList) {
      if (image.imageType == widget.position) {
        return image;
      }
    }

    return null;
  }

  // =========================================================
  // 광고 높이
  // =========================================================

  double getAdHeight() {
    switch (widget.position) {
      case 'MAIN':
        return 400;

      case 'MEETUP_LIST_BANNER':
        return 300;

      case 'MEETUP_LIST_SIDEBAR':
        return 500;

      case 'MEETUP_DETAIL_SIDEBAR':
        return 500;

      default:
        return 300;
    }
  }

  @override
  Widget build(BuildContext context) {

    // 광고 조회 중
    if (loading) {
      return SizedBox(
        height: getAdHeight(),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 광고 없음
    if (ad == null) {
      return const SizedBox.shrink();
    }

    final advertisement = ad!;
    final adImage = getAdImage();

    final imageUrl = adImage != null
        ? 'https://moit-j.duckdns.org${adImage.imageUrl}'
        : null;

    final isPremium =
        advertisement.adGrade == 'PREMIUM';

    return MouseRegion(
      // =====================================================
      // PC / Web hover
      // =====================================================

      onEnter: (_) {
        if (isPremium) {
          setState(() {
            showContent = true;
          });
        }
      },

      onExit: (_) {
        if (isPremium) {
          setState(() {
            showContent = false;
          });
        }
      },

      child: GestureDetector(
        onTap: () {

          // 모바일에서는 hover가 없으므로
          // 첫 번째 터치 → 내용 표시
          if (isPremium && !showContent) {
            setState(() {
              showContent = true;
            });

            return;
          }

          // 두 번째 터치 → 광고 이동
          handleClick();
        },

        child: Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          clipBehavior: Clip.antiAlias,

          child: Stack(
            children: [

              // =================================================
              // 광고 이미지
              // =================================================

              if (imageUrl != null)
                Image.network(
                  imageUrl,

                  width: double.infinity,
                  height: getAdHeight(),

                  fit: BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) {
                    return SizedBox(
                      height: getAdHeight(),
                      child: const Center(
                        child: Text(
                          '이미지를 불러오지 못했습니다.',
                        ),
                      ),
                    );
                  },
                )
              else
                SizedBox(
                  height: getAdHeight(),
                  child: const Center(
                    child: Text(
                      '현재 진행 중인 광고가 없습니다.',
                    ),
                  ),
                ),

              // =================================================
              // PREMIUM 광고
              // =================================================

              if (isPremium)
                Positioned(
                  top: 16,
                  left: 16,

                  // React
                  // max-width: 80%
                  right: 16,

                  child: Align(
                    alignment: Alignment.topLeft,

                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width *
                                0.8,
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          // =====================================
                          // 제목
                          // =====================================

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.black
                                  .withValues(alpha: 0.55),

                              borderRadius:
                                  BorderRadius.circular(6),
                            ),

                            child: Text(
                              advertisement.title,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),

                          // =====================================
                          // 내용
                          // =====================================

                          AnimatedSize(
                            duration:
                                const Duration(
                              milliseconds: 300,
                            ),

                            curve: Curves.ease,

                            child: AnimatedOpacity(
                              duration:
                                  const Duration(
                                milliseconds: 300,
                              ),

                              opacity:
                                  showContent ? 1 : 0,

                              child: showContent
                                  ? Container(
                                      margin:
                                          const EdgeInsets
                                              .only(
                                        top: 4,
                                      ),

                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 14,
                                        vertical: 10,
                                      ),

                                      constraints:
                                          const BoxConstraints(
                                        maxHeight: 250,
                                      ),

                                      decoration:
                                          const BoxDecoration(
                                        color:
                                            Color.fromRGBO(
                                          0,
                                          0,
                                          0,
                                          0.65,
                                        ),

                                        borderRadius:
                                            BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(6),
                                          bottomRight:
                                              Radius.circular(6),
                                        ),
                                      ),

                                      child: SingleChildScrollView(
                                        child: Text(
                                          advertisement
                                                  .content ??
                                              '',

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.white,
                                            height: 1.6,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}