import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dioPack;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:translator/translator.dart';
import '../../controller/credentialcontroller.dart';

class TextToTextPage extends StatefulWidget {
  @override
  _TextToTextPageState createState() => _TextToTextPageState();
}

class _TextToTextPageState extends State<TextToTextPage> {
  GoogleTranslator translator = GoogleTranslator();
  String inputText = '';
  bool _loading = false;
  String _selectedLanguageCode = '';
  String _translatedText = '';
  String _detectedLanguage = '';
  TextEditingController translateController = TextEditingController();

  List<String> _languagesCode = [
    'af',
    'ar',
    'bn',
    'bg',
    'zh-CN',
    'zh-TW',
    'hr',
    'cs',
    'da',
    'nl',
    'en',
    'et',
    'fi',
    'fr',
    'de',
    'el',
    'he',
    'hi',
    'hu',
    'id',
    'ga',
    'it',
    'ja',
    'ko',
    'lv',
    'lt',
    'ms',
    'mt',
    'no',
    'fa',
    'pl',
    'pt',
    'pa', // Punjabi
    'ro',
    'ru',
    'sd',
    'sk',
    'sl',
    'es',
    'sw',
    'sv',
    'ta',
    'te',
    'th',
    'tr',
    'uk',
    'ur',
    'vi',
    'cy',
    'xh',
    'yo',
    'zu',
  ];

  List<String> _languagesNames = [
    'Afrikaans',
    'Arabic',
    'Bengali',
    'Bulgarian',
    'Chinese (Simplified)',
    'Chinese (Traditional)',
    'Croatian',
    'Czech',
    'Danish',
    'Dutch',
    'English',
    'Estonian',
    'Finnish',
    'French',
    'German',
    'Greek',
    'Hebrew',
    'Hindi',
    'Hungarian',
    'Indonesian',
    'Irish',
    'Italian',
    'Japanese',
    'Korean',
    'Latvian',
    'Lithuanian',
    'Malay',
    'Maltese',
    'Norwegian',
    'Persian',
    'Polish',
    'Portuguese',
    'Punjabi',
    'Romanian',
    'Russian',
    'Sindhi',
    'Slovak',
    'Slovenian',
    'Spanish',
    'Swahili',
    'Swedish',
    'Tamil',
    'Telugu',
    'Thai',
    'Turkish',
    'Ukrainian',
    'Urdu',
    'Vietnamese',
    'Welsh',
    'Xhosa',
    'Yoruba',
    'Zulu',
  ];

  Future<void> translate() async {
    setState(() {
      _loading = true;
    });

    try {
      String detectedLanguage = await detectLanguage(inputText);
      if (detectedLanguage.isEmpty) {
        detectedLanguage = 'en';
      }

      if (_selectedLanguageCode == "pa") {
        String translationText = 'Convert the following into Pakistani pure Punjabi Nastaliq transcript, just respond result. \'$inputText\'';
        translateController.text = await CredentialController().apiTranslator(translationText);
        setState(() {
          _translatedText = translationText;
        });
      } else {
        Translation translation = await translator.translate(inputText, from: detectedLanguage, to: _selectedLanguageCode);
        translateController.text = translation.text ?? '';
        setState(() {
          _translatedText = translation.text ?? 'Translation Error';
        });
      }
    } catch (e) {
      log('Translation error: $e');
      setState(() {
        _translatedText = 'Translation Error';
      });
    }

    setState(() {
      _loading = false;
    });
  }

  Future<String> detectLanguage(String text) async {
    try {
      var options = dioPack.Options(
        headers: {
          'content-type': 'application/json',
          'X-RapidAPI-Key': '10b1b38e9emsh30892ae316ac916p157a32jsn04973525bcd7',
          'X-RapidAPI-Host': 'chatgpt-best-price.p.rapidapi.com',
        },
      );

      var data = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': text}
        ]
      };

      dioPack.Response response = await dio.post(
        'https://chatgpt-best-price.p.rapidapi.com/v1/chat/completions',
        data: data,
        options: options,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.data);
        String detectedLanguage = responseData['choices'][0]['message']['language'];
        return detectedLanguage;
      } else {
        throw Exception('Language detection failed');
      }
    } catch (error) {
      log('Language detection error: $error');
      throw Exception('Language detection failed');
    }
  }


  void onChangedText(String text) async {
    setState(() {
      inputText = text;
    });

    String detectedLanguage = await detectLanguage(inputText);
    setState(() {
      _detectedLanguage = detectedLanguage;
    });
  }

  void reset(BuildContext context) {
    setState(() {
      inputText = '';
      translateController.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate Text'),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: translateController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Enter Text...',
                border: OutlineInputBorder(),
              ),
              onChanged: onChangedText,
            ),
            SizedBox(height: 16.0),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: _detectedLanguage),
              decoration: InputDecoration(
                labelText: 'Detected Language',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 14.0),
            DropdownButtonFormField<String>(
              value: _selectedLanguageCode.isNotEmpty
                  ? _selectedLanguageCode
                  : null,
              hint: Text('Select Language'),
              items: List.generate(
                _languagesCode.length,
                    (index) => DropdownMenuItem(
                  value: _languagesCode[index],
                  child: Text(_languagesNames[index]),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedLanguageCode = value!;
                });
              },
              // Style the dropdown button
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xff0371b2),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (inputText.isNotEmpty &&
                        _selectedLanguageCode.isNotEmpty) {
                      await translate();
                    }
                  },
                  child: Text('Translate'),
                ),
                ElevatedButton(
                  onPressed: () {
                    reset(context);
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _loading
                ? Center(child: CircularProgressIndicator())
                : _translatedText.isNotEmpty
                ? Text(
              'Translated Text: $_translatedText',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
