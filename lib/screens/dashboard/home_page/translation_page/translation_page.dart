import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../res/components/background_widget.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({Key? key}) : super(key: key);

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  TextEditingController textController = TextEditingController();

  String translatedText = "";
  String from = "auto"; // user any language likhe → auto detect
  String to = "balochi"; // always translate to Balochi
  bool isLoading = false;

  Future<void> translate() async {
    if (textController.text.isEmpty) return;

    setState(() => isLoading = true);

    const apiKey = "YOUR_GOOGLE_API_KEY";
    final url = Uri.parse("https://translation.googleapis.com/language/translate/v2?key=$apiKey");

    final response = await http.post(url, body: {
      "q": textController.text,
      "source": from, // auto detect
      "target": to, // to baluchi
      "format": "text",
    });

    final data = json.decode(response.body);

    setState(() {
      translatedText = data["data"]["translations"][0]["translatedText"] ?? "No result found.";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Translate to Balochi",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter text:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: textController,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Write any word or sentence...",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(14),
                    prefixIcon: const Icon(Icons.language),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Translate Button
              Center(
                child: ElevatedButton(
                  //onPressed: translate,
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Translate to Balochi",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Result Section
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (translatedText.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Text(
                    translatedText,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
