import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/features/save_image/cubit/save_image_to_device_cubit.dart';

class DetailedImageView extends StatefulWidget {
  final File? image;
  final List<File> allImages;
  const DetailedImageView({super.key, this.image, required this.allImages});

  @override
  State<DetailedImageView> createState() => DetailedImageViewState();
}

class DetailedImageViewState extends State<DetailedImageView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.allImages.indexOf(widget.image!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveImageToDeviceCubit, SaveImageToDeviceState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      .5, // set the height of the image container
                  child: PageView.builder(
                    itemCount: widget.allImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                        widget.allImages[index],
                        fit: BoxFit.contain,
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    controller: PageController(
                      initialPage: _currentIndex,
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
                        onPressed: (() {}),
                        elevation: 0,
                        backgroundColor: const Color(0xff79555B),
                        heroTag: 'btn1',
                        child:
                            const Icon(Icons.share, color: Color(0xffE4D0ED)),
                      ),
                      FloatingActionButton(
                        onPressed: (() {
                          if (context
                                  .read<SaveImageToDeviceCubit>()
                                  .state
                                  .isSaved ==
                              false) {
                            final image = context
                                .read<SaveImageToDeviceCubit>()
                                .onSaveImage(widget.image);
                          } else {
                            Text('Image already exists');
                          }
                        }),
                        elevation: 0,
                        backgroundColor: const Color(0xff79555B),
                        heroTag: 'btn2',
                        child: const Icon(Icons.save_alt_rounded,
                            color: Color(0xffE4D0ED)),
                      ),
                      FloatingActionButton(
                        onPressed: (() {}),
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
