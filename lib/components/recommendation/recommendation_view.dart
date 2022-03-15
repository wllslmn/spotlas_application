import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotlas_test/components/common/icon_action.dart';
import 'package:spotlas_test/components/common/image_slider.dart';
import 'package:spotlas_test/components/common/overlay_details.dart';
import 'package:spotlas_test/components/common/tag_list.dart';
import 'package:spotlas_test/components/common/tool_bar.dart';
import 'package:spotlas_test/components/recommendation/bloc/recommendation_view_bloc.dart';
import 'package:spotlas_test/components/recommendation/bloc/recommendation_view_event.dart';
import 'package:spotlas_test/components/recommendation/bloc/recommendation_view_state.dart';
import 'package:spotlas_test/presentation/config/screen_size_config.dart';
import 'package:spotlas_test/presentation/icons/spotlas_icons_icons.dart';
import 'package:spotlas_test/stores/models/recommendation/recommendation.dart';
import 'package:spotlas_test/stores/models/recommendation/tag.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecommendationView extends StatefulWidget {
  final Recommendation recommendation;

  const RecommendationView({Key? key, required this.recommendation}) : super(key: key);

  @override
  State<RecommendationView> createState() => _RecommendationViewState();
}

class _RecommendationViewState extends State<RecommendationView> {
  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return BlocBuilder<RecommendationViewBloc, RecommendationViewState>(builder: (context, state) {
      return SliverList(
        delegate: SliverChildListDelegate([
          buildSpot(context, sizeConfig, state),
          buildToolBar(context, sizeConfig, state),
          buildCaption(context, sizeConfig),
          buildTags(context, sizeConfig, tags: widget.recommendation.recommendationTags),
          buildCreatedAt(context, sizeConfig),
        ]),
      );
    });
  }

  Widget buildSpot(final BuildContext context, final SizeConfig sizeConfig, final RecommendationViewState state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageSlider(
              imageUrls: widget.recommendation.photoUrls,
              hasOverlayDetails: true,
              fallBackImageUrl: widget.recommendation.placeholderLogo,
              onDoubleTap: () => BlocProvider.of<RecommendationViewBloc>(context).add(LikeRecommendation(isLiked: state.isLiked)),
            ),
          ),
          buildOverlayDetails(
            context,
            sizeConfig,
            isTop: true,
            imageUrl: widget.recommendation.authorPhotoUrl,
            title: widget.recommendation.authorUsername,
            desc: widget.recommendation.authorFullName,
            icon: SpotlasIcons.options,
            borderColor: Theme.of(context).primaryColor,
            onActionTap: () {},
          ),
          buildOverlayDetails(
            context,
            sizeConfig,
            isTop: false,
            imageUrl: widget.recommendation.placeLogoUrl,
            title: widget.recommendation.placeName,
            desc: "${widget.recommendation.placeLocationName} · ${widget.recommendation.placeLocationNameO}",
            icon: state.isBookmarked ? SpotlasIcons.star : SpotlasIcons.button_big,
            iconColor: state.isBookmarked ? Theme.of(context).indicatorColor : Theme.of(context).backgroundColor,
            borderColor: Theme.of(context).backgroundColor,
            onActionTap: () => BlocProvider.of<RecommendationViewBloc>(context).add(BookmarkRecommendation(isBookmarked: state.isBookmarked)),
          ),
        ],
      ),
    );
  }

  Widget buildOverlayDetails(
    final BuildContext context,
    final SizeConfig sizeConfig, {
    required final bool isTop,
    required final String imageUrl,
    required final String title,
    required final String desc,
    required final IconData icon,
    final Color? iconColor,
    final double? imageSize,
    required Color borderColor,
    required final Function() onActionTap,
  }) {
    return Positioned(
        top: isTop ? sizeConfig.getVerticalSize("s") : null,
        left: sizeConfig.getVerticalSize("s"),
        right: sizeConfig.getVerticalSize("l"),
        bottom: !isTop ? sizeConfig.getHorizontalSize("s") : null,
        child: OverlayDetails(
          sizeConfig: sizeConfig,
          imageUrl: imageUrl,
          title: title,
          desc: desc,
          icon: icon,
          borderColor: borderColor,
          onActionTap: onActionTap,
          iconColor: iconColor,
          imageSize: imageSize,
          fallBackImage: widget.recommendation.placeholderLogo,
        ));
  }

  Widget buildToolBar(final BuildContext context, final SizeConfig sizeConfig, final RecommendationViewState state) {
    return ToolBar(
      outerPadding: EdgeInsets.symmetric(horizontal: sizeConfig.getHorizontalSize("xxl"), vertical: sizeConfig.getVerticalSize("m")),
      children: [
        IconAction(onTap: () {}, icon: SpotlasIcons.map),
        IconAction(onTap: () {}, icon: SpotlasIcons.comment),
        IconAction(
            onTap: () => BlocProvider.of<RecommendationViewBloc>(context).add(LikeRecommendation(isLiked: state.isLiked)),
            icon: state.isLiked ? SpotlasIcons.heart : SpotlasIcons.like,
            iconColor: state.isLiked ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark),
        IconAction(onTap: () {}, icon: SpotlasIcons.share),
      ],
    );
  }

  Widget buildCaption(final BuildContext context, final SizeConfig sizeConfig) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.getHorizontalSize("s")),
      child: ExpandableText(
        widget.recommendation.description,
        collapseText: "less",
        expandText: "more",
        linkColor: Colors.grey,
        prefixText: widget.recommendation.authorUsername,
        prefixStyle: Theme.of(context).textTheme.bodyText1,
        maxLines: 3,
        style: Theme.of(context).textTheme.bodyText2,
        linkEllipsis: false,
      ),
    );
  }

  Widget buildTags(final BuildContext context, final SizeConfig sizeConfig, {required List<Tag> tags}) {
    if (tags.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: sizeConfig.getVerticalSize("xs")),
        child: TagList(
          tags: tags,
          listPadding: EdgeInsets.symmetric(horizontal: sizeConfig.getHorizontalSize("s")),
          spacerPadding: EdgeInsets.only(right: sizeConfig.getHorizontalSize("xxxs")),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildCreatedAt(final BuildContext context, final SizeConfig sizeConfig) {
    return Padding(
      padding: EdgeInsets.only(top: sizeConfig.getVerticalSize("s"), bottom: sizeConfig.getVerticalSize("l"), left: sizeConfig.getHorizontalSize("s"), right: sizeConfig.getHorizontalSize("s")),
      child: Text(
        timeago.format(widget.recommendation.createdAt),
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
