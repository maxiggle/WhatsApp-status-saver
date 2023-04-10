import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/cubit/status_provider_cubit.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatusProviderCubit(),
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
    return BlocBuilder<StatusProviderCubit, StatusProviderState>(
      builder: (context, state) {
        context.read<StatusProviderCubit>().getStatus('.jpg');
        final len = context.read<StatusProviderCubit>().getImages;

        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: len.length,
            itemBuilder: (BuildContext ctx, index) {
              final images =
                  context.read<StatusProviderCubit>().getImages[index];
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                  
                ),
                child: FileImage(File(images.path)),
              );
            });
      },
    );
  }
}
// List.generate(
//               context.read<StatusProviderCubit>().getImages.length, (index) {
           
//             return GestureDetector(
//               child: Container(
//                 color: Colors.green,
//                 child: Image.file(images),
//               ),
//             );
//           }),