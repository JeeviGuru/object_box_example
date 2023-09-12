import 'package:flutter/material.dart';
import 'package:keep_notes_lite/main.dart';
import 'package:keep_notes_lite/model_class/user_model.dart';
import 'package:keep_notes_lite/pages/action_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isselected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    objectbox.store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                    //border: Border.all(),
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 54, 53, 53)),
                child: Row(
                  children: [
                    _buildbox(),
                    const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    _buildbox(),
                    const Text(
                      'Search your notes',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isselected = !isselected;
                        });
                      },
                      child: Icon(
                        isselected
                            ? Icons.view_agenda_outlined
                            : Icons.grid_view_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    _buildbox(),
                    const SizedBox(
                      height: 30,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'https://i.pinimg.com/736x/d3/61/ae/d361aec23365b0b940aaab2e93ff5d8b.jpg',
                        ),
                      ),
                    ),
                    _buildbox(),
                  ],
                ),
              ),
            ),
            StreamBuilder<List<UserModel>>(
                stream: objectbox.getDats(),
                builder: (context, snapshot) {
                  return isselected
                      ? ListView.builder(
                          itemCount: snapshot.data?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final user = snapshot.data;
                            if (snapshot.hasError) {
                              return Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.white),
                              );
                            }
                            return Column(
                              children: [
                                Card(
                                  color: Colors.grey.shade900,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey.shade600,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      user?.elementAt(index).title ?? 'No data',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      user?.elementAt(index).content ??
                                          'No content',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          objectbox.deleteUser(
                                            user?.elementAt(index).id ?? 2,
                                          );
                                        },
                                        child: const Icon(Icons.delete,
                                            color: Colors.white)),
                                  ),
                                ),
                              ],
                            );
                          })
                      : GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // childAspectRatio: 16 / 9,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 70,
                            mainAxisSpacing: 20,
                          ),
                          itemCount:
                              snapshot.hasData ? snapshot.data?.length ?? 2 : 0,
                          itemBuilder: (BuildContext context, int index) {
                            final user = snapshot.data;
                            if (snapshot.hasError) {
                              return Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.white),
                              );
                            }
                            return Card(
                              color: Colors.grey.shade900,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey.shade600,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  user?.elementAt(index).title ?? 'no data',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  user?.elementAt(index).content ??
                                      'No content',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: GestureDetector(
                                    onTap: () {
                                      objectbox.deleteUser(
                                        user?.elementAt(index).id ?? 2,
                                      );
                                    },
                                    child: const Icon(Icons.delete,
                                        color: Colors.white)),
                              ),
                            );
                          },
                        );
                }),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 45,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 54, 53, 53),
          ),
          child: Row(
            children: [
              _buildbox(),
              const Icon(
                Icons.check_box_outlined,
                color: Colors.white,
              ),
              _buildbox(),
              const Icon(
                Icons.brush_outlined,
                color: Colors.white,
              ),
              _buildbox(),
              const Icon(
                Icons.mic_none,
                color: Colors.white,
              ),
              _buildbox(),
              const Icon(
                Icons.photo_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 45,
        width: 45,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: const Color.fromARGB(255, 54, 53, 53),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ActionPage()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  SizedBox _buildbox() {
    return const SizedBox(
      width: 20,
    );
  }
}
// Widget _gridview(){
//   return SizedBox(
//     height:150,
//     child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,

//     ), itemBuilder: (BuildContext context,int index))
//   );
// }