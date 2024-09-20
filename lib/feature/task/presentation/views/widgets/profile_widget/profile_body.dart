import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/assets/images.dart';
import 'package:to_do_app/feature/authentication/data/firebase_data.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/profile_widget/profile_widget.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  Map<String, dynamic>? userDataFromFirebase;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async{
   User?  user =FirebaseAuth.instance.currentUser;
   if(user != null){
     DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
     setState(() {
         userDataFromFirebase = userDoc.data() as Map<String ,dynamic>;
         print(userDataFromFirebase);
     });
   }
 }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: userDataFromFirebase ==null ?CircularProgressIndicator():Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileWidget(
            text1: 'NAME',
            text2: userDataFromFirebase!['name'] ,
          ),
          SizedBox(height: 10),
          ProfileWidget(
            text1: 'Email',
            text2: userDataFromFirebase!['email'] ,
            icon: SvgPicture.asset(
              ImageStyle.copyIcon,
            ),
            onPressed: () {
              _copyToClipboard(userDataFromFirebase!['email']); // Call the copy function
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  content: Text('Copied to clipboard!'),
                ),
              );
            },
          ),
          SizedBox(height: 10),
          ProfileWidget(
            text1: 'LEVEL',
            text2: userDataFromFirebase!['level'],
          ),
          SizedBox(height: 10),
          ProfileWidget(
            text1: 'YEARS OF EXPERIENCE',
            text2: '${userDataFromFirebase!['yearsOfExperience'] ?? 0} years',
          ),
          SizedBox(height: 10),
          ProfileWidget(
            text1: 'LOCATION',
            text2: userDataFromFirebase!['address'],
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)); // Copy text to clipboard
  }
}
