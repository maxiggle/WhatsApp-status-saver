import 'package:flutter/material.dart';
import 'package:status_saver/widgets/image_view.dart';
import 'package:status_saver/widgets/video_view.dart';

class StatusSaverHome extends StatelessWidget {
  const StatusSaverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('WhatsApp Status Saver'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.image),
                ),
                Tab(
                  icon: Icon(Icons.video_call),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ImageGridView(),
              VideoView(),
            ],
          ),
        ),
      ),
    );
  }
}
