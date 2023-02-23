import 'package:flutter/material.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* first time run huda loading bata data aauxa 
    hamro mathi ko data variable empty hunx
    But choose_location bata aauda hamro data variablema setState bata
    value rakhiyeko cha */
    final parameters= ModalRoute.of(context)!.settings.arguments ;
    data = data.isNotEmpty ? data : jsonDecode(jsonEncode(parameters));
    String bgImage = data['isDaytime'] ? 'day.png': 'night.png';
    Color? bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async{
                    dynamic result =  await Navigator.pushNamed(context, '/location');
                    setState(() {
                      try {
                        data = {
                          'time' : result['time'],
                          'location' : result['location'],
                          'isDaytime' : result['isDaytime'],
                          'flag' : result['flag'],
                        };
                      }
                      catch(e) {
                        data = {};
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.edit_location),
                  label: const Text('Edit Location'),
                ),
                const SizedBox(height: 20.0),
                Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: const TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  data ['time'],
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
