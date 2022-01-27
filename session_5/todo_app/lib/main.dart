import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Task List'),
    );
  }
}

//My home page stateless widget
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                      fontSize: 24,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            const TaskView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 1, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            labelPadding: const EdgeInsets.only(left: 32, right: 32),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.pink,
                width: 2,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            controller: _tabController,
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Tasks'),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                constraints: const BoxConstraints(minHeight: 50),
                height: MediaQuery.of(context).size.height * 0.71,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Task $index'),
                            trailing: const Icon(Icons.check_circle_outline),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
