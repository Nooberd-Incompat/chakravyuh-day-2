import 'package:flutter/material.dart';

class ImageGridScreen extends StatefulWidget {
  const ImageGridScreen({super.key});

  @override
  _ImageGridScreenState createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  final List<Map<String, String>> imageData = [
    {
      "image": "assets/images/abhimanyu.jpg",
      "text":
          "Abhimanyu, the son of Arjuna and Subhadra, learned the intricacies of the Chakravyuha (a complex battle formation) while still in his mother's womb. However, he only learned how to enter it, not exit, which led to his heroic but tragic end."
    },
    {
      "image": "assets/images/arjun.jpeg",
      "text":
          "Arjuna was the most skilled archer among the Pandavas and the favorite student of Dronacharya. He was granted divine weapons by various gods, including the Pashupatastra from Lord Shiva. His focus and dedication are legendary, especially highlighted in the story of shooting the bird's eye during his training."
    },
    {
      "image": "assets/images/bheem.jpg",
      "text":
          "Bheema was a voracious eater and famously defeated many Rakshasas, including the demon Hidimba, whom he later married. Bheema's strength was instrumental in defeating the Kauravas' key warriors, including Duryodhana, in the final mace duel."
    },
    {
      "image": "assets/images/bhishma.jpg",
      "text":
          " Bheeshma took a vow of celibacy, renouncing his claim to the throne, to ensure his father's happiness. His loyalty was unshakable, and he possessed the Ichha Mrityu boon, which allowed him to choose the time of his death, granted to him by his father, King Shantanu."
    },
    {
      "image": "assets/images/draupadi.jpg",
      "text":
          "Draupadi was born from fire and known for her beauty and intelligence. She married all five Pandavas due to a boon given by Lord Shiva, but her love and loyalty were primarily directed towards Arjuna. Her humiliation in the Kaurava court after being disrobed by Dushasana became a key catalyst for the Mahabharata war."
    },
    {
      "image": "assets/images/dronacharya.jpg",
      "text":
          "A highly skilled teacher and warrior, Drona taught both the Pandavas and Kauravas the art of warfare. Despite his affection for Arjuna, Drona sided with the Kauravas due to his loyalty to the throne of Hastinapura. His killing of unarmed soldiers and death by deceit reveal the complexities of his character."
    },
    {"image": "assets/images/duryodhan.jpg", "text": "L"}, // Image 7
    {
      "image": "assets/images/dusanan.jpg",
      "text":
          "Duryodhana's younger brother, Dushasana was known for his unwavering loyalty to him. He was the one who attempted to disrobe Draupadi in the Kaurava court, an act that incited the Pandavas' fury and intensified their desire for revenge. His brutal death at the hands of Bheema was a direct retribution for this deed."
    },
    {
      "image": "assets/images/karna.jpeg",
      "text":
          "Born to Kunti and the sun god Surya, Karna was abandoned and later raised by a charioteer. His loyalty to Duryodhana, despite knowing the Pandavas were his brothers, showed his strong sense of friendship and gratitude. Known for his generosity and courage, Karna was hindered by curses that ultimately led to his downfall."
    },
    {
      "image": "assets/images/krishna.jpg",
      "text":
          "The divine incarnation of Lord Vishnu, Krishna served as the charioteer and guide to Arjuna, imparting the Bhagavad Gita to him on the battlefield. Although he did not wield weapons in the war, his strategic counsel and divine insights were key to the Pandavas' victory."
    },
    {
      "image": "assets/images/kunti.png",
      "text":
          "Mother to the Pandavas, Kunti received a boon to bear children with gods. Despite her hardships, she maintained her composure and ensured her sons remained united. Her decision to reveal Karna's identity only to Yudhishthira added another complex layer to the Mahabharata's family dynamics."
    },
    {
      "image": "assets/images/shakuni.jpg",
      "text":
          "The crafty uncle of the Kauravas, Shakuni harbored a deep-seated grudge against the Kuru dynasty for the suffering of his family. Known for his cunning and strategic manipulation, he orchestrated the dice game that led to the Pandavas' exile and sowed seeds for the ultimate conflict."
    },
  ];

  final List<double> _imageOpacity = List.generate(12, (_) => 1.0);
  double _imageSize = 200.0; // Initial size for image 7
  bool _isTappedImage7 = false; // Track if image 7 is tapped
  String? selectedText; // Track selected image text to display after tap

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: imageData.length,
                itemBuilder: (context, index) {
                  final imageInfo = imageData[index];
                  bool isSeventhImage = index == 6;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedText = imageInfo["text"];
                        if (isSeventhImage) {
                          _isTappedImage7 = true;

                          // Shrinking animation sequence for image 7
                          Future.delayed(const Duration(milliseconds: 100),
                              () => setState(() => _imageSize = 170.0));
                          Future.delayed(const Duration(milliseconds: 200),
                              () => setState(() => _imageSize = 150.0));
                          Future.delayed(const Duration(milliseconds: 300),
                              () => setState(() => _imageSize = 120.0));
                          Future.delayed(const Duration(milliseconds: 400),
                              () => setState(() => _imageSize = 100.0));
                          Future.delayed(const Duration(milliseconds: 500),
                              () => setState(() => _imageSize = 50.0));
                          Future.delayed(const Duration(milliseconds: 600), () {
                            setState(() {
                              _imageSize = 0.0; // Final shrink size
                            });
                          });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetailScreen(
                                imagePath: imageInfo["image"]!,
                                description: imageInfo["text"]!,
                                tag: 'image_$index',
                              ),
                            ),
                          );
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                          tag: 'image_$index',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: AnimatedOpacity(
                                opacity: _imageOpacity[index],
                                duration: const Duration(milliseconds: 300),
                                child: Image.asset(
                                  imageInfo["image"]!,
                                  width: isSeventhImage ? _imageSize : 200.0,
                                  height: isSeventhImage ? _imageSize : 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (isSeventhImage && _imageSize == 0.0)
                          const Text(
                            "L",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Display the selected image's text below the grid when an image is tapped
          if (selectedText != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedText!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          // Single Next button at the bottom center
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Define action for "Next" button here
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imagePath;
  final String description;
  final String tag;

  const ImageDetailScreen({
    super.key,
    required this.imagePath,
    required this.description,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 400.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}