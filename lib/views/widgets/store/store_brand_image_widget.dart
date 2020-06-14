import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreBrandImageWidget extends StatelessWidget {

  final String brandImagePath;

  StoreBrandImageWidget({this.brandImagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CircleAvatar(
          child: Image.network(
            '$brandImagePath',
            width: 50,
            height: 50,
            fit: BoxFit.fill,
            errorBuilder: (context, url, error) => Icon(Icons.error),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
        ),

        width: 75.0,
        height: 75.0,
        padding: const EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.circle,
        )
    );
  }
}
