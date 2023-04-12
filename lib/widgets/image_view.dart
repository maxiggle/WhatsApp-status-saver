import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/status_provider_bloc.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatusProviderBloc()..add(const GetStatus('.jpg')),
      child: const ImageGridView(),
    );
  }
}

class ImageGridView extends StatefulWidget {
  const ImageGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
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
                  mainAxisSpacing: 10),
              itemCount: len,
              itemBuilder: (BuildContext ctx, index) {
                final image = state.images[index] as File;

                return Container(
                  // alignment: Alignment.center,
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
                );
              });
        }
      },
    );
  }
}
