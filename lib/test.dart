// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   List events = [
//     {
//       "title": "Flutter Devs Meetup",
//       "category": "Meetup",
//       "date": "June 20, 2025 at 6:00:00 PM UTC+10",
//       "description":
//           "Monthly catch-up for Flutter developers to share progress and challenges.",
//       "host": "Flutter AU",
//       "location": "Melbourne, VIC",
//       "coordinates": "[37.8136° S, 144.9631° E]",
//       "imageUrl": "https://example.com/flutter_meetup.jpg",
//       "capacity": 40,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "AI Founders Meetup",
//       "category": "Meetup",
//       "date": "July 10, 2025 at 5:00:00 PM UTC+10",
//       "description":
//           "Discussing opportunities and challenges of launching AI startups.",
//       "host": "StartupHub",
//       "location": "Online",
//       "coordinates": "[0° N, 0° E]",
//       "imageUrl": "https://example.com/ai_meetup.jpg",
//       "capacity": 60,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "Sydney Tech Talks",
//       "category": "Meetup",
//       "date": "August 5, 2025 at 7:00:00 PM UTC+10",
//       "description":
//           "Tech entrepreneurs share stories from their startup journey.",
//       "host": "TechCircle",
//       "location": "Sydney, NSW",
//       "coordinates": "[33.8688° S, 151.2093° E]",
//       "imageUrl": "https://example.com/tech_talks.jpg",
//       "capacity": 70,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "Women in Tech Meetup",
//       "category": "Meetup",
//       "date": "June 25, 2025 at 6:30:00 PM UTC+10",
//       "description":
//           "A supportive space for women in the startup and tech space to connect.",
//       "host": "SheTech",
//       "location": "Brisbane, QLD",
//       "coordinates": "[27.4698° S, 153.0251° E]",
//       "imageUrl": "https://example.com/women_tech.jpg",
//       "capacity": 50,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "Build Your First App with Flutter",
//       "category": "Workshop",
//       "date": "June 18, 2025 at 10:00:00 AM UTC+10",
//       "description":
//           "A hands-on session to create your first mobile app using Flutter.",
//       "host": "CodeCamp",
//       "location": "Online",
//       "coordinates": "[0° N, 0° E]",
//       "imageUrl": "https://example.com/flutter_workshop.jpg",
//       "capacity": 100,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "Intro to Firebase for Startups",
//       "category": "Workshop",
//       "date": "July 5, 2025 at 9:00:00 AM UTC+10",
//       "description":
//           "Learn Firebase backend tools and services for your startup app.",
//       "host": "Firebase Devs",
//       "location": "Adelaide, SA",
//       "coordinates": "[34.9285° S, 138.6007° E]",
//       "imageUrl": "https://example.com/firebase_workshop.jpg",
//       "capacity": 30,
//       "attendees": [],
//       "price": "20",
//       "rating": "0",
//     },
//     {
//       "title": "MVP Bootcamp for Startups",
//       "category": "Workshop",
//       "date": "June 28, 2025 at 1:00:00 PM UTC+10",
//       "description":
//           "Rapidly prototype your MVP using low-code tools and frameworks.",
//       "host": "StartupSprint",
//       "location": "Perth, WA",
//       "coordinates": "[31.9505° S, 115.8605° E]",
//       "imageUrl": "https://example.com/mvp_bootcamp.jpg",
//       "capacity": 40,
//       "attendees": [],
//       "price": "15",
//       "rating": "0",
//     },
//     {
//       "title": "Cloud DevOps Essentials",
//       "category": "Workshop",
//       "date": "July 15, 2025 at 10:00:00 AM UTC+10",
//       "description":
//           "Deploying scalable startup applications using AWS and Docker.",
//       "host": "DevOps Academy",
//       "location": "Online",
//       "coordinates": "[0° N, 0° E]",
//       "imageUrl": "https://example.com/devops.jpg",
//       "capacity": 80,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "StartupFest 2025",
//       "category": "Conference",
//       "date": "August 20, 2025 at 9:00:00 AM UTC+10",
//       "description":
//           "Annual tech startup conference with 50+ speakers and investors.",
//       "host": "StartupFest",
//       "location": "Sydney, NSW",
//       "coordinates": "[33.8688° S, 151.2093° E]",
//       "imageUrl": "https://example.com/startupfest.jpg",
//       "capacity": 500,
//       "attendees": [],
//       "price": "99",
//       "rating": "0",
//     },
//     {
//       "title": "AI Summit 2025",
//       "category": "Conference",
//       "date": "September 1, 2025 at 10:00:00 AM UTC+10",
//       "description": "Exploring AI, ML, and ethics in next-gen tech solutions.",
//       "host": "TechAI Global",
//       "location": "Melbourne, VIC",
//       "coordinates": "[37.8136° S, 144.9631° E]",
//       "imageUrl": "https://example.com/ai_summit.jpg",
//       "capacity": 300,
//       "attendees": [],
//       "price": "120",
//       "rating": "0",
//     },
//     {
//       "title": "DevCon Australia",
//       "category": "Conference",
//       "date": "October 10, 2025 at 9:30:00 AM UTC+10",
//       "description":
//           "Australia’s largest developer conference for building modern applications.",
//       "host": "DevCon Org",
//       "location": "Brisbane, QLD",
//       "coordinates": "[27.4698° S, 153.0251° E]",
//       "imageUrl": "https://example.com/devcon.jpg",
//       "capacity": 600,
//       "attendees": [],
//       "price": "150",
//       "rating": "0",
//     },
//     {
//       "title": "Startup Policy & Tech Forum",
//       "category": "Conference",
//       "date": "September 18, 2025 at 10:00:00 AM UTC+10",
//       "description":
//           "Policy makers and startups collaborate on digital regulations.",
//       "host": "TechPolicy AU",
//       "location": "Canberra, ACT",
//       "coordinates": "[35.2809° S, 149.1300° E]",
//       "imageUrl": "https://example.com/policy_forum.jpg",
//       "capacity": 200,
//       "attendees": [],
//       "price": "50",
//       "rating": "0",
//     },
//     {
//       "title": "Hack the Future 2025",
//       "category": "Hackathon",
//       "date": "June 22, 2025 at 8:00:00 AM UTC+10",
//       "description":
//           "48-hour hackathon to build solutions for tomorrow’s problems.",
//       "host": "FutureHack",
//       "location": "Online",
//       "coordinates": "[0° N, 0° E]",
//       "imageUrl": "https://example.com/hack_future.jpg",
//       "capacity": 200,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "GovHack AU",
//       "category": "Hackathon",
//       "date": "July 19, 2025 at 9:00:00 AM UTC+10",
//       "description": "Hack government data to create community solutions.",
//       "host": "GovHack",
//       "location": "Melbourne, VIC",
//       "coordinates": "[37.8136° S, 144.9631° E]",
//       "imageUrl": "https://example.com/govhack.jpg",
//       "capacity": 150,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "Fintech Hackathon 2025",
//       "category": "Hackathon",
//       "date": "August 3, 2025 at 10:00:00 AM UTC+10",
//       "description":
//           "Innovate banking and payments with your fintech solution.",
//       "host": "FinHack AU",
//       "location": "Sydney, NSW",
//       "coordinates": "[33.8688° S, 151.2093° E]",
//       "imageUrl": "https://example.com/fintech.jpg",
//       "capacity": 100,
//       "attendees": [],
//       "price": "0",
//       "rating": "0",
//     },
//     {
//       "title": "Startup Weekend Hackathon",
//       "category": "Hackathon",
//       "date": "June 29, 2025 at 5:00:00 PM UTC+10",
//       "description": "Pitch, build, and launch a startup idea in 54 hours.",
//       "host": "Startup AU",
//       "location": "Adelaide, SA",
//       "coordinates": "[34.9285° S, 138.6007° E]",
//       "imageUrl": "https://example.com/startupweekend.jpg",
//       "capacity": 80,
//       "attendees": [],
//       "price": "10",
//       "rating": "0",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: TextButton(
//             onPressed: () async {
//               for (var data in events) {
//                 await FirebaseFirestore.instance
//                     .collection('events')
//                     .doc()
//                     .set(data);
//                 print('set data success');
//               }

//               // for (var i = 0; i < 1; i++) {
//               //   try {
//               //     await FirebaseFirestore.instance
//               //         .collection('events')
//               //         .doc()
//               //         .set(events[i]);
//               //     print('set data success');
//               //   } on FirebaseException catch (e) {
//               //     print('data set error ${e.message}');
//               //   }
//               // }
//             },
//             child: Text('click me'),
//           ),
//         ),
//       ),
//     );
//   }
// }
