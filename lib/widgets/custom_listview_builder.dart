import 'package:flutter/material.dart';

class CustomListviewBuilder extends StatefulWidget {
  const CustomListviewBuilder({super.key});

  @override
  State<CustomListviewBuilder> createState() => _CustomListviewBuilderState();
}

class _CustomListviewBuilderState extends State<CustomListviewBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return ListView.builder(
    //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
    //   itemCount: ,
    //   itemBuilder: (BuildContext context, int index){
    //     return Container(
    //       height: 50,
    //       child: Center(child: Text('Entry ${entries[index]}')),
    //     );
    //   },
    // );
  }
}
