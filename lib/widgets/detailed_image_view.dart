import 'dart:io';
// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/features/getStatus/bloc/status_provider_bloc.dart';

class DetailedImageView extends StatefulWidget {
  final File? image;
  final List<File> allImages;

  const DetailedImageView({Key? key, this.image, required this.allImages})
      : super(key: key);

  @override
  State<DetailedImageView> createState() => DetailedImageViewState();
}

class DetailedImageViewState extends State<DetailedImageView> {
  late int _currentIndex;

  // ignore: unused_field
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _context = context; // Capture the context
    _currentIndex = widget.allImages.indexOf(widget.image!);
    if (_currentIndex == -1) {
      // Handle the case where the image is not found in allImages
      _currentIndex = 0; // You may choose a different default behavior
    }
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
                              .add(SaveStatus(_currentIndex));
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
