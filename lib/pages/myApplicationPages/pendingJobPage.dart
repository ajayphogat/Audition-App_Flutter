import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:flutter/material.dart';

class PendingJobPage extends StatefulWidget {
  const PendingJobPage({Key? key, required this.searchEdit}) : super(key: key);

  static const String routeName = "/pendingJob-page";
  final TextEditingController searchEdit;

  @override
  State<PendingJobPage> createState() => _PendingJobPageState();
}

class _PendingJobPageState extends State<PendingJobPage> {
  final OtherService otherService = OtherService();
  List<JobModel1>? _appliedJobs;

  getWorkingJobs() async {
    _appliedJobs = await otherService.showWorkingJobs(
      context: context,
      working: "pending",
      search: widget.searchEdit.text.isNotEmpty ? widget.searchEdit.text : "",
    );
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> getJobDetails(String jobId) async {
    await otherService.getJobDetails(context: context, jobId: jobId);
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
      body: (_appliedJobs == null)
          ? const Center(
              child: CircularProgressIndicator(color: greenColor),
            )
          : (_appliedJobs!.isEmpty)
              ? const Center(
                  child: Text("No Data Found"),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _appliedJobs!.length,
                    itemBuilder: (context, index) {
                      JobModel1 data = _appliedJobs![index];
                      return InkWell(
                        onTap: () async {
                          circularProgressIndicatorNew(context);
                          await getJobDetails(data.id.toString());
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: screenWidth * 0.0635,
                                  backgroundImage: NetworkImage(data.images[0]),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    data.studioName,
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
