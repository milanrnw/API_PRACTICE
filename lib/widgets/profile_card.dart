import 'package:api_practice/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel? profileDetails;
  
  const ProfileCard({
    super.key, this.profileDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100.h,
        width: 300.w,
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID : ${profileDetails?.id}'),
            Text('Email : ${profileDetails?.email}'),
            Text('Username : ${profileDetails?.username}'),
            Text('Password : ${profileDetails?.password}'),
            Text('Firstname : ${profileDetails?.name.firstname}'),
            Text('Lastname : ${profileDetails?.name.lastname}'),
          ],
        ),
      ),
    );
  }
}
