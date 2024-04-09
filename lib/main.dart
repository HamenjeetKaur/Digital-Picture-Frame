import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PictureFrame(),
  ));
}

class PictureFrame extends StatefulWidget {
  @override
  _PictureFrameState createState() => _PictureFrameState();
}

class _PictureFrameState extends State<PictureFrame> {
  List<String> imageUrls = [
    'assets/img.jpg',
    'assets/img_1.jpg',
    'assets/img_2.jpg',
    'assets/img_3.jpg',
  ];
  int currentImageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        currentImageIndex = (currentImageIndex + 1) % imageUrls.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Picture Frame by Hamen'),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 450,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 10.0,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  _timer?.cancel();
                  _startTimer();
                  setState(() {
                    currentImageIndex = (currentImageIndex + 1) % imageUrls.length;
                  });
                },
                child: Image.asset(
                  imageUrls[currentImageIndex],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Center(
                      child: Text('Error loading image'),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 250,
            top: 250,
            bottom: 250,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _timer?.cancel();
                _startTimer();
                setState(() {
                  currentImageIndex = (currentImageIndex - 1) % imageUrls.length;
                  if (currentImageIndex < 0) {
                    currentImageIndex = imageUrls.length - 1;
                  }
                });
              },
            ),
          ),
          Positioned(
            right: 250,
            top: 250,
            bottom: 250,
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _timer?.cancel();
                _startTimer();
                setState(() {
                  currentImageIndex = (currentImageIndex + 1) % imageUrls.length;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
