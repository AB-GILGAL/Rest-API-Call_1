import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API Call"),
        centerTitle: true,
        backgroundColor: Colors.teal[900],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
        final user = users[index];
        final title = user["name"]["title"];
        final fName = user["name"]["first"];
        final lName = user["name"]["last"];
        final img = user["picture"]["thumbnail"];
        final location = user["location"]["timezone"]["description"];
        final age = user["dob"]["age"];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(img)),
          title: Text("$title $fName $lName"),
          subtitle: Text(location),
          trailing: CircleAvatar(
            backgroundColor: Colors.teal[900],
            radius: 15,
            child: Text(age.toString())),
        );
      },),
      floatingActionButton: FloatingActionButton
      (
        onPressed: fetchUsers,
        child: const Icon(Icons.person_add_alt_sharp),
        ),
    );
  }
  void fetchUsers ()async{
          final response = await http.get(Uri.parse("https://randomuser.me/api/?results=30"));
          final body = jsonDecode(response.body);
          setState(() {
            users = body["results"];
          });
        }
}
 