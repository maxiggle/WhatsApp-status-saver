import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/features/getStatus/bloc/status_provider_bloc.dart';
import 'package:status_saver/widgets/detailed_image_view.dart';

class ImageGridView extends StatefulWidget {
  const ImageGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StatusProviderBloc>(context)
        .add(const GetImageStatus('.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusProviderBloc, StatusProviderState>(
      builder: (context, state) {
        final len = state.images.length;
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: len,
              itemBuilder: (BuildContext ctx, index) {
                final image = state.images[index] as File;
                final listImages = state.images.map((e) => e as File).toList();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => DetailedImageView(
                              image: image,
                              allImages: listImages,
                            )),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}
