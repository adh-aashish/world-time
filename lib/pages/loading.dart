import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWordTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url:'Europe/London');
    await instance.getTime();
    // Whether this State object is currently in a tree or not
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupWordTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.blue[900],
          size: 50.0,
        ),
      ), 
    );
  }

}


