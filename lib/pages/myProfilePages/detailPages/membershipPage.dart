import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  static const String routeName = "/membership-Page";

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  final AuthService authService = AuthService();

  Future<void> updateUnionMembership() async {
    await authService.updateUnionMembership(
      context: context,
      unionMembership: membershipList,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  final List<String> membershipList = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar1(screenHeight, screenWidth, context, profileData[3],
          updateUnionMembership),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight * 0.60,
            margin: EdgeInsets.only(top: screenHeight * 0.03),
            child: ListView.builder(
              findChildIndexCallback: (key) {
                final valueKey = key as ValueKey;
                final index = membershipData
                    .indexWhere((element) => element == valueKey.value);
                if (index == -1) return null;
                return index;
              },
              itemCount: membershipData.length,
              itemBuilder: (context, index) {
                return ListMember(
                  key: ValueKey(membershipData[index]),
                  item: membershipData[index],
                  listMembership: membershipList,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListMember extends StatefulWidget {
  const ListMember({Key? key, required this.item, required this.listMembership})
      : super(key: key);

  final String item;
  final List<String> listMembership;

  @override
  State<ListMember> createState() => _ListMemberState();
}

class _ListMemberState extends State<ListMember>
    with AutomaticKeepAliveClientMixin {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        isSelected
            ? ListTile(
                title: Text(widget.item),
                trailing: const Icon(Icons.check),
                selected: true,
                onTap: () {
                  isSelected = !isSelected;
                  widget.listMembership.remove(widget.item);
                  setState(() {});
                },
              )
            : ListTile(
                title: Text(widget.item),
                selected: true,
                onTap: () {
                  isSelected = !isSelected;
                  widget.listMembership.add(widget.item);
                  setState(() {});
                },
              ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        // Padding(
        //   padding:
        //       EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         membershipData[index],
        //         style: const TextStyle(
        //           fontSize: 16,
        //           fontFamily: fontFamily,
        //         ),
        //       ),
        //       const Icon(Icons.check),
        //     ],
        //   ),
        // ),
        // const Divider(
        //   thickness: 1,
        //   color: Colors.grey,
        // ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
