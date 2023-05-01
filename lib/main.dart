import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_saver/features/save_image/cubit/save_image_to_device_cubit.dart';
import 'package:status_saver/status_saver_home.dart';

import 'features/getStatus/bloc/status_provider_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StatusProviderBloc()
            ..add(
              const GetStatus('.mp4'),
            ),
        ),
        BlocProvider(
          create: (context) => StatusProviderBloc()
            ..add(
              const GetStatus('.jpg'),
            ),
        ),
        BlocProvider(
          create: (context) => SaveImageToDeviceCubit(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: const StatusSaverHome()),
    );
  }
}
