import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SInviteFriendsPage extends StatefulWidget {
  const SInviteFriendsPage({Key? key}) : super(key: key);

  static const String routeName = "/sinvite-page";

  @override
  State<SInviteFriendsPage> createState() => _SInviteFriendsPageState();
}

class _SInviteFriendsPageState extends State<SInviteFriendsPage> {
  late TextEditingController searchEdit;

  @override
  void initState() {
    super.initState();
    searchEdit = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchEdit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: indexAppBar(screenHeight, screenWidth, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: screenWidth * 0.90,
                    height: screenHeight * 0.045,
                    padding: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: searchEdit,
                      decoration: InputDecoration(
                        hintText: "Search here....",
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          fontFamily: fontFamily,
                          color: placeholderTextColor,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "asset/images/illustration/bytesize_search.svg",
                            color: placeholderTextColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              searchEdit.text = "";
                            },
                            icon: const Icon(
                              MyFlutterApp.gridicons_cross,
                              size: 20,
                              color: placeholderTextColor,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.788,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.02,
                ),
                findChildIndexCallback: (keyy) {
                  final valueKey = keyy as ValueKey;
                  final index = inviteFriendsData
                      .indexWhere((element) => element == valueKey.value);
                  if (index == -1) return null;
                  return index;
                },
                itemCount: inviteFriendsData.length,
                itemBuilder: (context, index) {
                  List<String> data = inviteFriendsData[index];
                  return NewLIstTile(key: ValueKey(data), item: data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewLIstTile extends StatefulWidget {
  const NewLIstTile({Key? key, required this.item}) : super(key: key);

  final List<String> item;

  @override
  State<NewLIstTile> createState() => _NewLIstTileState();
}

class _NewLIstTileState extends State<NewLIstTile>
    with AutomaticKeepAliveClientMixin {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    super.build(context);
    return Container(
      width: screenWidth,
      height: screenHeight * 0.07,
      margin: EdgeInsets.only(bottom: screenHeight * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  widget.item[0],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: screenWidth * 0.08),
              Text(widget.item[1]),
            ],
          ),
          IconButton(
            icon: selected
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.add_circle_outline_outlined,
                    color: Colors.green,
                  ),
            onPressed: () {
              setState(() {
                selected = !selected;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
