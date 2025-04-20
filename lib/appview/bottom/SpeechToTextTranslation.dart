import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../controller/credentialcontroller.dart';

class VoiceToTextPage extends StatefulWidget {
  @override
  _VoiceToTextPageState createState() => _VoiceToTextPageState();
}

class _VoiceToTextPageState extends State<VoiceToTextPage> {
  late stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _transcription = '';
  String _detectedLanguage = '';
  String _translatedText = '';
  GoogleTranslator translator = GoogleTranslator();
  String _selectedLanguageCode = '';
  List<String> _languagesCode = [
    'af', 'ar', 'bn', 'bg', 'zh-CN', 'zh-TW', 'hr', 'cs', 'da', 'nl', 'en',
    'et', 'fi', 'fr', 'de', 'el', 'he', 'hi', 'hu', 'id', 'ga', 'it', 'ja',
    'ko', 'lv', 'lt', 'ms', 'mt', 'no', 'fa', 'pl', 'pt', 'pa', 'ro', 'ru',
    'sd', 'sk', 'sl', 'es', 'sw', 'sv', 'ta', 'te', 'th', 'tr', 'uk', 'ur',
    'vi', 'cy', 'xh', 'yo', 'zu'
  ];

  List<String> _languagesNames = [
    'Afrikaans', 'Arabic', 'Bengali', 'Bulgarian', 'Chinese (Simplified)',
    'Chinese (Traditional)', 'Croatian', 'Czech', 'Danish', 'Dutch', 'English',
    'Estonian', 'Finnish', 'French', 'German', 'Greek', 'Hebrew', 'Hindi',
    'Hungarian', 'Indonesian', 'Irish', 'Italian', 'Japanese', 'Korean',
    'Latvian', 'Lithuanian', 'Malay', 'Maltese', 'Norwegian', 'Persian',
    'Polish', 'Portuguese', 'Punjabi', 'Romanian', 'Russian', 'Sindhi', 'Slovak',
    'Slovenian', 'Spanish', 'Swahili', 'Swedish', 'Tamil', 'Telugu', 'Thai',
    'Turkish', 'Ukrainian', 'Urdu', 'Vietnamese', 'Welsh', 'Xhosa', 'Yoruba',
    'Zulu',
  ];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  @override
  void dispose() {
    _speechToText.stop();
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) {
          if (status == 'listening') {
            setState(() {
              _isListening = true;
            });
          }
        },
        onError: (error) {
          print('Speech recognition error: $error');
          setState(() {
            _isListening = false;
          });
        },
      );

      if (available) {
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
            });
          },
          localeId: 'en_US',
        );
      }
    } else {
      _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  Future<void> translateText() async {
    setState(() {
      _loading = true;
    });

    try {
      String detectedLanguage = await detectLanguage(_transcription);
      if (detectedLanguage.isEmpty) {
        detectedLanguage = 'en'; // Fallback behavior if language detection fails
      }

      if (_selectedLanguageCode == "pa" || detectedLanguage == "pa") {
        _translatedText = await CredentialController().apiTranslator(_transcription);
      } else {
        Translation translation = await translator.translate(
          _transcription,
          from: detectedLanguage,
          to: _selectedLanguageCode,
        );
        _translatedText = translation.text ?? 'Translation Error';
      }

      setState(() {
        _detectedLanguage = detectedLanguage;
      });
    } catch (e) {
      print('Translation error: $e');
      setState(() {
        _translatedText = 'Translation Error';
      });
    }

    setState(() {
      _loading = false;
    });
  }

  Future<String> detectLanguage(String text) async {
    var url = Uri.parse('https://google-translation-unlimited.p.rapidapi.com/detect');
    var headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'X-RapidAPI-Key': '10b1b38e9emsh30892ae316ac916p157a32jsn04973525bcd7',
      'X-RapidAPI-Host': 'google-translation-unlimited.p.rapidapi.com'
    };
    var body = {
      'q': text,
    };

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        log(data.toString());
        return data["detected_language"];
      } else {
        return "en";
      }
    } catch (error) {
      log('Error: $error');
      throw Exception(error);
    }
  }

  void onChangedText(String text) async {
    setState(() {
      _transcription = text;
    });
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _languagesNames.map((language) {
                return ListTile(
                  title: Text(language),
                  onTap: () {
                    int index = _languagesNames.indexOf(language);
                    setState(() {
                      _selectedLanguageCode = _languagesCode[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: h * .3,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showLanguageSelectionDialog(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _selectedLanguageCode.isEmpty
                                  ? 'Select Language'
                                  : 'Selected Language: ${_languagesNames[_languagesCode.indexOf(_selectedLanguageCode)]}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0e4072),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 60),
                        Text(
                          _detectedLanguage.isNotEmpty
                              ? 'Detected Language: $_detectedLanguage'
                              : '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: w * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          _transcription,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _listen,
                child: Icon(_isListening ? Icons.stop : Icons.mic),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: _isListening ? Colors.red : Colors.blue,
                  padding: EdgeInsets.all(20),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: translateText,
                child: Text('Translate'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _transcription = '';
                    _translatedText = '';
                  });
                },
                child: Text('Reset'),
              ),
              SizedBox(height: 8),
              Container(
                height: h * .25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(
                    _translatedText,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
