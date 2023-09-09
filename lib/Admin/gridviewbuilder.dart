import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  GridItem({required this.title, required this.color, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: color,
          ) ,
          height: MediaQuery.of(context).size.height*0.15, // Change the height to 80 (or any desired value)
          width: MediaQuery.of(context).size.width*0.4, // Change the height to 80 (or any desired value)

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 48.0,
                color: Colors.white,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}