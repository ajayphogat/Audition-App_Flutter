import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sdesignationPage.dart';
import 'package:flutter/material.dart';

class SDancerProfilePage extends StatefulWidget {
  const SDancerProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/sdancerProfile-page";

  @override
  State<SDancerProfilePage> createState() => _SDancerProfilePageState();
}

class _SDancerProfilePageState extends State<SDancerProfilePage> {
  late TextEditingController _searchEdit;

  @override
  void initState() {
    super.initState();
    _searchEdit = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchEdit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: simpleAppBar(
          screenHeight, screenWidth, context, _searchEdit, "Dancer Profiles"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight - (screenHeight * 0.153),
              child: ListView.builder(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                itemCount: actorProfileData.length,
                itemBuilder: (context, index) {
                  var data = actorProfileData[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SDesignationPage.routeName);
                    },
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.08,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.10,
                          bottom: screenHeight * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListTile(
                        minLeadingWidth: screenWidth * 0.15,
                        leading: CircleAvatar(
                          radius: screenHeight * 0.03,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                data[1],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          data[0],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
