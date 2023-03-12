import 'package:flutter/material.dart';
class HomeListTile extends StatefulWidget {
 
   HomeListTile({
    Key? key,required this.title,required this.icn, this.onTap
  }) : super(key: key);
   String title;
  IconData icn;
  final onTap;
  @override
  State<HomeListTile> createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 7),
      child: ListTile(
          onTap: widget.onTap,
          leading: Icon(widget.icn),
          title:  MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text('${widget.title}',style:const TextStyle(
              color: Colors.deepPurple,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400
            ),),
          ),
         
          ),
    );
  }
}