import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/features/getStatus/bloc/status_provider_bloc.dart';



class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatusProviderBloc()..add(const GetStatus('.mp4')),
      child: const _VideoView(),
    );
  }
}

class _VideoView extends StatelessWidget {
  const _VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusProviderBloc, StatusProviderState>(
      builder: (context, state) {
        final len = state.images.length;
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: len,
            itemBuilder: (BuildContext ctx, index) {
              final videos = state.images[index] as File;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text('data'),
              );
            });
      },
    );
  }
}
