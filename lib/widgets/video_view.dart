import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/cubit/status_provider_cubit.dart';

class VideoView extends StatelessWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusProviderCubit, StatusProviderState>(
      builder: (context, state) {
        context.read<StatusProviderCubit>().getStatus('.mp4');
        final len = context.read<StatusProviderCubit>().getVideos;

        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: len.length,
            itemBuilder: (BuildContext ctx, index) {
              final videos =
                  context.read<StatusProviderCubit>().getImages[index];
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.file(videos),
              );
            });
      },
    );
  }
}
