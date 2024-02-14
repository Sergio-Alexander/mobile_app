import 'package:flutter/material.dart';
import 'package:mob_dev/router.dart';

//
import 'package:provider/provider.dart';
import 'app_status.dart';
import 'emotion_recorder.dart';
import 'diet_recorder.dart';
import 'workout_recorder.dart';

import 'package:go_router/go_router.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecordingState(),
      child: MyApp(),
    ),
  );
}

//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => RecordingState(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const MobDev(title: 'Flutter Demo Home Page'),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      builder: (context, router) {
        return ChangeNotifierProvider(
          create: (context) => RecordingState(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('My App'),
            ),
            body: router,
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.sentiment_very_satisfied),
                  label: 'Emotion',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fastfood),
                  label: 'Diet',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: 'Workout',
                ),
              ],
              onTap: (index) {
                switch (index) {
                  case 0:
                    GoRouter.of(context).push('/emotion');
                    break;
                  case 1:
                    GoRouter.of(context).push('/diet');
                    break;
                  case 2:
                    GoRouter.of(context).push('/workout');
                    break;
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class MobDev extends StatelessWidget {
  const MobDev({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sergio's Flutter App"),
      ),
      body: const AppRecorders(),
    );
  }
}

class AppRecorders extends StatelessWidget {
  const AppRecorders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            children: const [
              EmotionRecorder(),
              DietRecorder(),
              WorkoutRecorder(),
            ],
          ),
        ),
        StatusWidget(),
      ],
    );
  }
}

// In your widget that shows the status
class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final recordingState = Provider.of<RecordingState>(context);
    return Column(
      children: [
        Text('Last Recorded: ${recordingState.lastRecordingType ?? 'None'}'),
        Text('Last Recording Time: ${recordingState.lastRecordingTime ?? 'Never'}'),
        Text('Recording Points: ${recordingState.recordingPoints}'),
        Text('Dedication Level: ${recordingState.calculateDL()}'),
      ],
    );
  }
}





