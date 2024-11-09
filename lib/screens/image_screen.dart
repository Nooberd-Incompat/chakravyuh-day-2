import 'package:flutter/material.dart';

class ImageGridScreen extends StatefulWidget {
  const ImageGridScreen({super.key, required this.title});
  final String title;

  @override
  _ImageGridScreenState createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  // List of images and corresponding text messages
  final List<Map<String, String>> imageData = [
    {"image": "assets/images/abhimanyu.jpg", "text": "This is image 1"},
    {"image": "assets/images/arjun.jpeg", "text": "This is image 2"},
    {"image": "assets/images/bheem.jpg", "text": "This is image 3"},
    {"image": "assets/images/bhishma.jpg", "text": "This is image 4"},
    {"image": "assets/images/draupadi.jpg", "text": "This is image 5"},
    {"image": "assets/images/dronacharya.jpg", "text": "This is image 6"},
    {"image": "assets/images/duryodhan.jpg", "text": "13BS6"}, // Image 7
    {"image": "assets/images/dusanan.jpg", "text": "This is image 8"},
    {"image": "assets/images/karna.jpeg", "text": "This is image 9"},
    {"image": "assets/images/krishna.jpg", "text": "This is image 10"},
    {"image": "assets/images/kunti.png", "text": "This is image 11"},
    {"image": "assets/images/shakuni.jpg", "text": "This is image 12"},
  ];

  // List to track opacity and tapped states of all images
  List<double> _imageOpacity = List.generate(12, (_) => 1.0);
  List<bool> tappedStates = List.generate(12, (_) => false);
  double _imageSize = 200.0; // For image 7 shrinking
  bool _isTappedImage7 = false; // Track if image 7 is tapped

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns for the grid
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: imageData.length,
          itemBuilder: (context, index) {
            final imageInfo = imageData[index];
            
            // Check if the tapped image is image 7
            bool isSeventhImage = index == 6;

            return GestureDetector(
              onTap: () {
                // Apply opacity effect for all images
                setState(() {
                  _imageOpacity[index] = 0.3; // Reduce opacity on tap
                  tappedStates[index] = true; // Mark image as tapped
                });

                // Reset opacity after 0.2 seconds for all images except the 7th
                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    if (!isSeventhImage) {
                      _imageOpacity[index] = 1.0; // Restore opacity for other images
                      tappedStates[index] = false; // Reset tapped state
                    }
                  });
                });

                if (isSeventhImage) {
                  setState(() {
                    _isTappedImage7 = true; // Image 7 is tapped, start shrinking
                  });

                  // Shrink the image size gradually
                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {
                      _imageSize = 200.0; // Shrink the image 7
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      _imageSize = 170.0; // Shrink the image 7
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 300), () {
                    setState(() {
                      _imageSize = 150.0; // Shrink the image 7 further
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 400), () {
                    setState(() {
                      _imageSize = 120.0; // Shrink the image 7 further
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 400), () {
                    setState(() {
                      _imageSize = 100.0; // Shrink the image 7 further
                    });
                  });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _imageSize = 70.0; // Shrink the image 7
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _imageSize = 50.0; // Shrink the image 7 completely
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _imageSize = 30.0; // Shrink the image 7 completely
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _imageSize = 0.0; // Shrink the image 7 completely
                    });
                  });

                  Future.delayed(const Duration(milliseconds: 600), () {
                    setState(() {
                      _imageSize = 300.0; // Shrink the image 7 completely
                    });
                  });



                  // After image 7 shrinks completely, show the alphabet
                  Future.delayed(const Duration(milliseconds: 600), () {
                    setState(() {
                      _isTappedImage7 = false; // Display the alphabet after shrinking
                    });
                  });
                }
              },
              child: Stack(
                alignment: Alignment.center, // Center the text on the image
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300), // Animation duration
                    curve: Curves.easeInOut,
                    child: AnimatedOpacity(
                      opacity: _imageOpacity[index], // Apply opacity change
                      duration: const Duration(milliseconds: 300),
                      child: Image.asset(
                        imageInfo["image"]!,
                        width: isSeventhImage ? _imageSize : 200.0, // Shrinking logic for image 7
                        height: isSeventhImage ? _imageSize : 200.0, // Shrinking logic for image 7
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Display the text with background if tapped
                  if (tappedStates[index] && index != 6)
                    Container(
                      color: Colors.black.withOpacity(0.5), // Background for text
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        imageInfo["text"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  // Show the alphabet after shrinking for image 7
                  if (isSeventhImage && _imageSize == 0.0)
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "b@1#", // Alphabet to show after image disappears
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
