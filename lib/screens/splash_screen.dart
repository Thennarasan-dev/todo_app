import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String quote = "Loading...";
  String author = "";
  final List<Map<String, dynamic>> quoteList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuote();
    _navigateToHome();
  }

  // Method to fetch a random quote from API
  Future<void> fetchQuote() async {
    try {
      final response =
      await http.get(Uri.parse('https://zenquotes.io/api/random'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body); // Parse as List
        setState(() {
          quote = data[0]['q'];
          author = '- ${data[0]['a']}';
          quoteList.add({
            'quote': quote,
            'author': author,
          });
        });
      } else {
        setState(() {
          quote = "Failed to load quote";
        });
      }
    } catch (e) {
      setState(() {
        quote = "Error: $e"; // Handle any errors
      });
    }
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    if (mounted && quoteList.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(quoteList: quoteList),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        image: AssetImage('assets/images/logo.png'),
      ),
    );
  }
}
