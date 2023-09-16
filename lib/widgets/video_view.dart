import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/features/getStatus/bloc/status_provider_bloc.dart';
import 'package:status_saver/widgets/detailed_video_view.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

late VideoPlayerController _controller;

class _VideoViewState extends State<VideoView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StatusProviderBloc>(context)
        .add(const GetVideoStatus('.mp4'));
    final state = context.read<StatusProviderBloc>().state;
    final allVideos = state.videos.map((e) => e as File).toList();
    final idx = allVideos[];
    _controller = VideoPlayerController.file(idx)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusProviderBloc, StatusProviderState>(
      builder: (context, state) {
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
              itemCount: state.videos.length,
              itemBuilder: (BuildContext ctx, index) {
                final videos = state.videos[index] as File;
                final listVideos = state.videos.map((e) => e as File).toList();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => DetailedVideoView(
                              video: videos,
                              allVideos: listVideos,
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
                      child: _controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                          : Container(),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}
