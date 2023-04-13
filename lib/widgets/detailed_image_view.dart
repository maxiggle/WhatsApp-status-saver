import 'package:flutter/material.dart';

class DetailedImageView extends StatefulWidget {
  final String? image;
  const DetailedImageView({super.key, this.image});

  @override
  State<DetailedImageView> createState() => _DetailedImageViewState();
}

class _DetailedImageViewState extends State<DetailedImageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.image!),
          ],
        ),
      ),
    );
  }
}
