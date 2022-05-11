import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vizmo/models/employee.dart';
import 'package:vizmo/models/sortby.dart';
import 'package:vizmo/pages/detailspage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Employee> _employees;
  late bool _loading;
  late int pageNo;
  late SortBy sortBy;
  late ScrollController _controller;

  @override
  void initState() {
    _employees = [];
    sortBy = SortBy.id;
    pageNo = 1;
    _loading = true;
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          searchAndAddEmployees();
        }
      });
    Employee.getByPage(pageNo, sortBy).then((result) {
      setState(() {
        _employees.addAll(result);
        _loading = false;
        pageNo++;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              showSearchField();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              showSortingOptions();
            },
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_employees.isNotEmpty)
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: _employees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailsPage(employee: _employees[index]);
                          },
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_employees[index].photoUrl),
                    ),
                    title: Text(_employees[index].name),
                    subtitle: Text(_employees[index].email),
                  );
                },
              ),
            ),
          if (_loading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  void updateSort(SortBy sortBy) {
    Navigator.pop(context);
    setState(() {
      this.sortBy = sortBy;
      _employees = [];
      pageNo = 1;
      _loading = true;
    });
    Employee.getByPage(pageNo, sortBy).then((result) {
      setState(() {
        _employees.addAll(result);
        _loading = false;
        pageNo++;
      });
    });
  }

  void showSearchField() async {
    String? result = await showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return SimpleDialog(
          title: const Text("Search"),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          titlePadding: const EdgeInsets.only(right: 15, left: 15, top: 15),
          contentPadding: const EdgeInsets.only(right: 15, left: 15),
          children: [
            TextField(
              controller: controller,
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: "Type here ...",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 15,
                ),
                contentPadding: const EdgeInsets.only(left: 1),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text("Go"),
            )
          ],
        );
      },
    );
    if (result is String && result.isNotEmpty) {
      setState(() {
        _employees = [];
        pageNo = 1;
        _loading = true;
      });
      Employee.search(result).then((result) {
        setState(() {
          _employees.addAll(result);
          _loading = false;
        });
      });
    }
  }

  void showSortingOptions() {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: SortBy.values
              .map(
                (e) => ListTile(
                  onTap: () {
                    updateSort(e);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((e.index + 1).toString() + ". " + e.name),
                      if (sortBy == e) const Icon(Icons.check),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  void searchAndAddEmployees() {
    setState(() {
      _loading = true;
    });
    Employee.getByPage(pageNo, sortBy).then((result) {
      setState(() {
        _employees.addAll(result);
        _loading = false;
        pageNo++;
      });
    });
  }
}
