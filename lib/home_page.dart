import 'dart:convert';

import 'package:demo/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'second_demo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List<Meta> _metas = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse(
        "https://fkcbsxxja7.execute-api.ap-south-1.amazonaws.com/alpha/get-AII_Startup-select");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> list = data['meta'];
      final List<Meta> metas = list.map((dynamic item) {
        return Meta.fromJson(item);
      }).toList();
      setState(() {
        _metas = metas;
      });
    } else {
      throw Exception('Failed to load data');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        title: const Text("Demo"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NextDemo(),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Next"),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: _metas.length,
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const AspectRatio(
                            aspectRatio: 15 / 7.8,
                            child: Image(
                              image: NetworkImage(
                                "https://images.ctfassets.net/hrltx12pl8hq/4plHDVeTkWuFMihxQnzBSb/aea2f06d675c3d710d095306e377382f/shutterstock_554314555_copy.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Text(
                            _metas[index].startupName.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            getName(index),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              launch(_metas[index].startupWebsite.toString());
                            },
                            child: const Text("Know More"),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      top: MediaQuery.of(context).size.height * 0.07,
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 34,
                          backgroundImage: NetworkImage(
                            "https://images.ctfassets.net/hrltx12pl8hq/4plHDVeTkWuFMihxQnzBSb/aea2f06d675c3d710d095306e377382f/shutterstock_554314555_copy.jpg",
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  String getName(int index) {
    var name = "";
    jsonDecode(
      _metas[index].startupFounderDetails.toString(),
      reviver: (key, value) {
        if (key == "full_name") {
          name = value.toString();
        }
      },
    );
    return name;
  }
}
