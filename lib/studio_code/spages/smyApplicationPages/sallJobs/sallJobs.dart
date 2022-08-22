import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';

class SAllJobsPage extends StatelessWidget {
  const SAllJobsPage({Key? key}) : super(key: key);

  static const String routeName = "/sallJobs-page";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: applicationAppliedData.length,
          itemBuilder: (context, index) {
            List<String> data = applicationAppliedData[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, data[3]);
              },
              child: SizedBox(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: screenWidth * 0.0635,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              data[2],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          data[0],
                          style: const TextStyle(
                            fontFamily: fontFamily,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        data[1],
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: fontFamily,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFF979797),
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
