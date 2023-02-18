import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';

class SAllJobsPage extends StatefulWidget {
  const SAllJobsPage({Key? key, required this.searchEdit}) : super(key: key);

  static const String routeName = "/sallJobs-page";

  final TextEditingController searchEdit;

  @override
  State<SAllJobsPage> createState() => _SAllJobsPageState();
}

class _SAllJobsPageState extends State<SAllJobsPage> {
  final OtherService otherService = OtherService();
  List<JobModel>? _allJobs;

  getWorkingJobs() async {
    print("search word");
    print(widget.searchEdit.text);
    _allJobs = await otherService.getStudioJobs(
        context: context,
        search:
            widget.searchEdit.text.isNotEmpty ? widget.searchEdit.text : "");
    print(_allJobs);
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> getStudioJobDetail_Studio(jobId) async {
    await otherService.getStudioJobDetail_Studio(
        context: context, jobId: jobId);
  }

  @override
  void initState() {
    getWorkingJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _allJobs == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _allJobs!.isEmpty
              ? const Center(
                  child: Text("No data found"),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _allJobs!.length,
                    itemBuilder: (context, index) {
                      JobModel data = _allJobs![index];
                      return InkWell(
                        onTap: () async {
                          print(data.id);
                          circularProgressIndicatorNew(context);
                          await getStudioJobDetail_Studio(data.id);
                          // await Future.delayed(Duration(seconds: 1));
                          // Navigator.pop(context);
                          // Navigator.pushNamed(context, SActorProfilePage.routeName);
                          // await getJobDetails(data.id);
                          // await Future.delayed(Duration(seconds: 1));
                          // Navigator.pushNamed(
                          //     context, );
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
                                      child: Image.network(
                                        data.images[0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    data.jobType,
                                    style: const TextStyle(
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  data.description,
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
