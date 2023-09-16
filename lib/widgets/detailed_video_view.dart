// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/getStatus/bloc/status_provider_bloc.dart';

class DetailedVideoView extends StatefulWidget {
  final File? video;
  final List<File> allVideos;
  const DetailedVideoView({
    Key? key,
    this.video,
    required this.allVideos,
  }) : super(key: key);

  @override
  State<DetailedVideoView> createState() => _DetailedVideoViewState();
}

class _DetailedVideoViewState extends State<DetailedVideoView> {
  late int _currentIdx;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _context = context;
    _currentIdx = widget.allVideos.indexOf(widget.video!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusProviderBloc, StatusProviderState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: PageView.builder(
                    itemCount: widget.allVideos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                        widget.allVideos[index],
                        fit: BoxFit.contain,
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentIdx = index;
                      });
                    },
                    controller: PageController(
                      initialPage: _currentIdx,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffE4D0ED),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          // Implement share functionality
                        },
                        elevation: 0,
                        backgroundColor: const Color(0xff79555B),
                        heroTag: 'btn1',
                        child:
                            const Icon(Icons.share, color: Color(0xffE4D0ED)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          context
                              .read<StatusProviderBloc>()
                              .add(SaveStatus(_currentIdx));
                        },
                        elevation: 0,
                        backgroundColor: const Color(0xff79555B),
                        heroTag: 'btn2',
                        child: const Icon(Icons.save_alt_rounded,
                            color: Color(0xffE4D0ED)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          // Implement PDF generation or other functionality
                        },
                        elevation: 0,
                        backgroundColor: const Color(0xff79555B),
                        heroTag: 'btn3',
                        child: const Icon(Icons.picture_as_pdf_outlined,
                            color: Color(0xffE4D0ED)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
