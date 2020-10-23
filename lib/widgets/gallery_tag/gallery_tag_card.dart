import 'package:epicture/blocs/image.dart';
import 'package:epicture/blocs/image/bloc.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/repositories/image.dart';
import 'package:epicture/router.dart';
import 'package:epicture/utilities/palette.dart';
import 'package:epicture/widgets/bloc/bloc_provider_builder.dart';
import 'package:epicture/widgets/ink/ink_well.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryTagCard extends StatelessWidget {
  final GalleryTagModel galleryTag;

  GalleryTagCard({@required this.galleryTag});

  @override
  Widget build(BuildContext context) {
    return BlocProviderBuilderWidget(
      create: (context) {
        return ImageBloc(ImageRepository())
          ..add(ImageGetEvent(id: galleryTag.coverId));
      },
      builder: (context) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(children: [
            _GalleryTagCardBody(galleryTag: galleryTag),
            InkWellWidget(
              onTap: () {
                AppRouter.navigator.pushNamed("/tag", arguments: galleryTag);
              },
            ),
          ]),
        );
      },
    );
  }
}

class _GalleryTagCardBody extends StatelessWidget {
  const _GalleryTagCardBody({
    @required this.galleryTag,
  });

  final GalleryTagModel galleryTag;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        if (state is ImageGotState) {
          final image = NetworkImage(state.image.url);

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder(
              future: getImageDominantColor(image),
              builder: (context, snapshot) {
                final Color dominantColor = (snapshot.hasData)
                    ? snapshot.data
                    : Colors.black;

                return Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _GalleryTagCardBodyTitle(
                        dominantColor: dominantColor,
                        galleryTag: galleryTag,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: _GalleryTagCardBodyBottom(
                        dominantColor: dominantColor,
                        galleryTag: galleryTag,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else if (state is ImageErrorState) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _GalleryTagCardBodyBottom extends StatelessWidget {
  const _GalleryTagCardBodyBottom({
    @required this.dominantColor,
    @required this.galleryTag,
  });

  final Color dominantColor;
  final GalleryTagModel galleryTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dominantColor,
      child: Center(
        child: Text(
          galleryTag.followers.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _GalleryTagCardBodyTitle extends StatelessWidget {
  const _GalleryTagCardBodyTitle({
    @required this.dominantColor,
    @required this.galleryTag,
  });

  final Color dominantColor;
  final GalleryTagModel galleryTag;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Chip(
        elevation: 10,
        backgroundColor: dominantColor,
        label: Text(
          galleryTag.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
