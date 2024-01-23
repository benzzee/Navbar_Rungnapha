import 'dart:convert';

import 'package:budbfjksbksf/course.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    FirstPage(),
    SecondPage(),
    ProductPage(),
  ];
  void onTapChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTapChanged,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorite "),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: "Course"),
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: ClipOval(
                child: Image.network(
                  'https://scontent-bkk1-2.xx.fbcdn.net/v/t1.6435-9/182956579_484795606170762_5425145279058721356_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=dd63ad&_nc_eui2=AeEkjY2fECh-5KuEqOW5Mpvc7YghxHwGBbTtiCHEfAYFtLaiJWwHXLVG6HbHjRbDTGv_Jvr2kIxKgiJxzPG8CGu2&_nc_ohc=Flh3kylW96MAX882RqS&_nc_ht=scontent-bkk1-2.xx&oh=00_AfA3_L9J9OIWoH1CSWxjMqFX8q6iV9V-ql2FpPW12cl0oA&oe=65D56A14',
                  width: 200,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0), // ระยะห่างระหว่างรูปภาพกับข้อความ
            const Text(
              'นางสาวรุ่งนภา เอี่ยมชูกุล',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            const Text(
              'ชื่อเล่น : เบนซ์  อายุ : 19 ปี',
            ),
            const Text(
              'รหัสประจำตัวนักศึกษา : 65309010012',
            ),
            const Text(
              'สาขาวิชา : เทคโนโลยีสารสนเทศ ชั้น : ปวส.2',
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Center(
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                child: Image.network(
                  'https://scontent.fbkk14-1.fna.fbcdn.net/v/t39.30808-6/409407481_355082280542593_5814863274891461302_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeHjF1rLC__SA0S3NwMglpQIKFh4Qh43aFQoWHhCHjdoVEGZ2NY13qzVcLTtM6kQkWQPl_rgDNrUDlSwzrPWA20-&_nc_ohc=G1dn3MiCqDIAX97mMi3&_nc_ht=scontent.fbkk14-1.fna&oh=00_AfBCtiwoM4k8VhfCP40T7QSpRCh1ijxi73msbSNA9FIeDQ&oe=65B46239',
                  width: 400,
                  height: 400,
                ),
              ),
              const SizedBox(height: 5.0),
              const Text(
                'I like play game ♥',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Course> courses = [];

  Future<void> fetchCourses() async {
    try {
      //Start Reading Data
      var url = "https://api.codingthailand.com/api/course";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        courses =
            data.map((courseData) => Course.fromJson(courseData)).toList();
        setState(() {});
      } else {
        print("Error : $response.statusCode");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Courses")),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: courses.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(courses[index].title),
          subtitle: Text(courses[index].detail),
          leading: ConstrainedBox(
            constraints: const BoxConstraints(
                maxHeight: 80, minHeight: 80, maxWidth: 80, minWidth: 80),
            child: Image.network(
              courses[index].picture,
              fit: BoxFit.fill,
            ),
          ),
          onTap: () {
            int id = courses[index].id;
            Get.toNamed("/detail/:$id");
          },
        ),
      ),
    );
  }
}
