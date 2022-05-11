import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            )),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://fiverr-res.cloudinary.com/t_profile_original,q_auto,f_auto/attachments/profile/photo/870024e9fcb8ffb231de33ed839ce6dd-1648889487066/7959932e-ab07-457b-a43a-b8922e32c9f5.jpeg"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Pratham Sarankar",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mail_outline, color: Colors.blue),
              const SizedBox(width: 5),
              Text(
                "developer.pratham@gmail.com",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: const [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 25,
                ),
                SizedBox(width: 5),
                Text(
                  "From",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  "India",
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: const [
                Icon(
                  Icons.phone,
                  size: 25,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  "Phone no.",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  "+91 - 9893333654",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: const [
                Icon(
                  Icons.person,
                  size: 25,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  "Member Since",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  "14/10/2019",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: const [
                Icon(
                  Icons.cake,
                  size: 25,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  "Birthday",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  "24/11/2002",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
