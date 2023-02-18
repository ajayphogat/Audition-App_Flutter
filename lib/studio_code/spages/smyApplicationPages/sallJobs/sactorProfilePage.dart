import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sdesignationPage.dart';
import 'package:flutter/material.dart';

class SActorProfilePage extends StatefulWidget {
  const SActorProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/sactorProfile-page";

  @override
  State<SActorProfilePage> createState() => _SActorProfilePageState();
}

class _SActorProfilePageState extends State<SActorProfilePage> {
  final OtherService otherService = OtherService();
  late TextEditingController _searchEdit;

  Future<void> getArtistData(userID, jobId) async {
    await otherService.artistProfileData(
        context: context, userID: userID, jobId: jobId);
  }

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

    List<dynamic> args =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    List<dynamic> newArgs = args[0];
    String jobId = args[1];
    return Scaffold(
      appBar: simpleAppBar(
          screenHeight, screenWidth, context, _searchEdit, "Artist Profiles"),
      body: newArgs.isEmpty
          ? const Center(
              child: Text(
                "No data found",
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight - (screenHeight * 0.153),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      itemCount: newArgs.length,
                      itemBuilder: (context, index) {
                        var data = newArgs[index];
                        return InkWell(
                          onTap: () async {
                            print(data["_id"]);
                            circularProgressIndicatorNew(context);
                            await getArtistData(data["_id"], jobId);
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
                              leading: Container(
                                width: (screenHeight * 0.06),
                                height: (screenHeight * 0.06),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: data["profilePic"].isEmpty
                                      ? Container(
                                          color: Colors.black,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: data["profilePic"],
                                          fadeOutDuration:
                                              const Duration(milliseconds: 500),
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              title: Text(
                                data["fname"],
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
