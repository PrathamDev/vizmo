import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vizmo/models/checkin.dart';
import 'package:vizmo/models/employee.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.employee}) : super(key: key);
  final Employee employee;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late List<Checkin> checkins;

  @override
  void initState() {
    checkins = [];
    Checkin.historyOfEmployee(widget.employee).then((result) {
      setState(() {
        checkins = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.employee.photoUrl),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              widget.employee.name,
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
                widget.employee.email,
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
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 25,
                ),
                const SizedBox(width: 5),
                const Text(
                  "From",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  widget.employee.country,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(fontSize: 18),
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
              children: [
                const Icon(
                  Icons.phone,
                  size: 25,
                  color: Colors.blue,
                ),
                const SizedBox(width: 5),
                const Text(
                  "Phone no.",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  widget.employee.contactNumber,
                  style: const TextStyle(fontSize: 18),
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
              children: [
                const Icon(
                  Icons.person,
                  size: 25,
                  color: Colors.blue,
                ),
                const SizedBox(width: 5),
                const Text(
                  "Member Since",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  formatDateTime(widget.employee.createdAt),
                  style: const TextStyle(fontSize: 18),
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
              children: [
                const Icon(
                  Icons.cake,
                  size: 25,
                  color: Colors.blue,
                ),
                const SizedBox(width: 5),
                const Text(
                  "Birthday",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  formatDateTime(widget.employee.birthday),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            color: Colors.grey.shade800,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "History",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: checkins
                .map(
                  (e) => Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              e.location,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              formatDateTime(e.time),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(e.purpose),
                      ),
                      const Divider(
                        height: 5,
                        thickness: 1,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString();
  }
}
