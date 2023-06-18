import 'package:collection/collection.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scanify/document.dart';
import 'package:scanify/profile.dart';
import 'package:scanify/scanner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var selectedTag = "";
  @override
  Widget build(BuildContext context) {
    var documents = [
      Document(DateTime(2023, 2, 2), "The Gita For Children",
          "https://m.media-amazon.com/images/I/71t3+JjDtkL._AC_UF1000,1000_QL80_.jpg",
          tags: ["Mythology"]),
      Document(DateTime(2023, 2, 2), "C For Beginners",
          "https://m.media-amazon.com/images/I/51cTUj438SL.jpg",
          tags: ["Programming"]),
      Document(DateTime(2023, 2, 2), "Resume",
          "https://www.my-resume-templates.com/wp-content/uploads/2023/05/student-resume-example.jpg",
          tags: ["Personal"]),
      Document(DateTime(2023, 4, 12), "Physics of the Impossible",
          "https://kbimages1-a.akamaihd.net/4d662d77-31d4-4fd4-b8cd-f2f6fa31633b/353/569/90/False/physics-of-the-impossible.jpgg",
          tags: ["Physics"]),
      Document(DateTime(2023, 4, 5), "Practical UI",
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1672686052i/75519891.jpg"),
      Document(DateTime(2023, 4, 5), "ML with Python",
          "https://www.freetechbooks.com/uploads/1595756320-machine-learning-projects-python%201200x.jpg",
          tags: ["Programming"]),
      Document(DateTime(2023, 4, 5), "The Prgamatic Programmer",
          "https://images-na.ssl-images-amazon.com/images/I/51W1sBPO7tL._SX380_BO1,204,203,200_.jpg",
          tags: ["Programming"]),
      Document(DateTime(2023, 4, 18), "The Vedas and Upanishads",
          "https://m.media-amazon.com/images/I/51BVP67BB1L._AC_UF1000,1000_QL80_.jpg",
          tags: ["Mythology"]),
    ];
    var tags = documents
        .map((e) => e.tags)
        .reduce((value, element) {
          var tempList = value.toList();
          tempList.addAll(element);
          return tempList;
        })
        .toSet()
        .toList();
    var entries = groupBy(
            documents.where((element) =>
                selectedTag != "" ? element.tags.contains(selectedTag) : true),
            (e) => DateFormat("MMMM yyyy").format(e.date))
        .entries
        .toList()
        .reversed
        .toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ScannerPage()));
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF981F2B),
        child: const Icon(
          FeatherIcons.camera,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: kToolbarHeight * 1.8,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0x10981F2B),
                      prefixIcon: const Icon(Icons.search),
                      labelText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                child: FirebaseAuth.instance.currentUser?.photoURL != null
                    ? ClipOval(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            FirebaseAuth.instance.currentUser!.photoURL!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Icon(Icons.account_circle_outlined),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(right: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(FeatherIcons.tag),
                    const SizedBox(
                      width: 16.00,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 36,
                        child: ListView.separated(
                          itemBuilder: (context, chipIndex) {
                            return FilterChip(
                              label: Text(tags[chipIndex]),
                              onSelected: (_) {
                                if (tags[chipIndex] == selectedTag) {
                                  selectedTag = "";
                                } else {
                                  if (_) {
                                    selectedTag = tags[chipIndex];
                                  }
                                }
                                setState(() {});
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0)),
                              selected: tags[chipIndex] == selectedTag,
                            );
                          },
                          separatorBuilder: (_, __) {
                            return const SizedBox(
                              width: 12,
                            );
                          },
                          itemCount: tags.length,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (_, index) {
                    return Flexible(
                        child: ScannedDocumentsGroup(
                            entries[index].key, entries[index].value));
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      height: 24,
                    );
                  },
                  itemCount: entries.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScannedDocumentsGroup extends StatelessWidget {
  final String date;
  final List<Document> documents;
  const ScannedDocumentsGroup(this.date, this.documents, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          date,
          style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.headlineMedium),
        ),
        const SizedBox(
          height: 24,
        ),
        GridView.builder(
          primary: false,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.64,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12),
          itemBuilder: (_, index) {
            return ScanDocumentThumbnail(
              document: documents[index],
            );
          },
          itemCount: documents.length,
        ),
      ],
    );
  }
}

class ScanDocumentThumbnail extends StatelessWidget {
  final Document document;
  const ScanDocumentThumbnail({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            document.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color: const Color(0x30981F2B),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF981F2B),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  document.name,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateFormat("dd MMM yyyy").format(document.date),
                  style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.6), fontSize: 8),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
