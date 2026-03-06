part of 'discovery_banner_section.dart';

class DiscoveryBannerSectionState extends State<DiscoveryBannerSection> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeProvider>();
    provider.addListener(_syncPageFromProvider);
  }

  @override
  void dispose() {
    context.read<HomeProvider>().removeListener(_syncPageFromProvider);
    super.dispose();
  }

  void _syncPageFromProvider() {
    final provider = context.read<HomeProvider>();
    if (widget.controller.hasClients &&
        provider.currentBannerIndex != widget.controller.page?.round()) {
      widget.controller.animateToPage(
        provider.currentBannerIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer2<DiscoveryDataProvider, HomeProvider>(
      builder: (context, discovery, home, _) {
        final banners = discovery.banners;
        if (banners.isEmpty) return const SizedBox.shrink();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: widget.controller,
                itemCount: banners.length,
                onPageChanged: home.setBannerIndex,
                itemBuilder: (context, index) => DiscoveryBannerSlide(
                  banner: banners[index],
                  theme: theme,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == home.currentBannerIndex ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: i == home.currentBannerIndex
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
