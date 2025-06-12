import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body_inspected_website.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/start_inspection_dialog.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:provider/provider.dart';

class Performance extends StatefulWidget {
  const Performance({super.key});

  @override
  State<Performance> createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  String selectedOption = 'Entire Website';
  bool isHovered = false;
  bool isWebsiteInspected = false;

  @override
  Widget build(BuildContext context) {
    final sessionProvider = SessionProvider.of(context);
    return Consumer<WebsiteController>(
        builder: (context, websiteController, child) {
      final Website? selectedWebsite = websiteController.selectedWebsite;
      if (isWebsiteInspected) {
        final inspectedWebsite = websiteController.inspectedWebsites.last;
        return ContentBodyInspectedWebsite(inspectedWebsite: inspectedWebsite);
      }
      return Center(
        child: Container(
          constraints: const BoxConstraints(
              maxWidth: 500, minWidth: 400 // Ancho máximo// Alto máximo
              ),
          child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 204, 204, 204), width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(children: [
                          Image.asset(
                            'assets/images/icons/worldwide.png',
                            height: 75,
                            width: 75,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Website Inspection",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Start analyzing your website's content and ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "performance ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Selected Website:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 38, 38, 38))),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 244, 249, 252),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color.fromARGB(255, 204, 204, 204),
                            width: 0.8,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/icons/worldwide.svg',
                              height: 20,
                              width: 20,
                              color: const Color.fromARGB(255, 92, 92, 92),
                            ),
                            SizedBox(width: 6),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedWebsite?.name ?? '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(selectedWebsite?.url ?? '',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(
                                              255, 126, 126, 126))),
                                ]),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Inspection Type',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 38, 38, 38))),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Checkbox(
                          value: selectedOption == 'Entire Website',
                          onChanged: (value) {
                            if (value == true) {
                              setState(() {
                                selectedOption = 'Entire Website';
                              });
                            }
                          },
                          activeColor: const Color.fromARGB(255, 7, 77, 255),
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const Text('Entire Website',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ]),
                      Row(children: [
                        Checkbox(
                          value: selectedOption == 'Blog/Articles Only',
                          onChanged: (value) {
                            if (value == true) {
                              setState(() {
                                selectedOption = 'Blog/Articles Only';
                              });
                            }
                          },
                          activeColor: const Color.fromARGB(255, 7, 77, 255),
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const Text(
                          'Blog/Articles Only',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: isHovered
                                ? const Color.fromARGB(
                                    255, 5, 60, 200) // Color más oscuro
                                : const Color.fromARGB(
                                    198, 3, 56, 189), // Color normal
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          onHover: (hovering) {
                            setState(() {
                              isHovered =
                                  hovering; // Cambia el estado al pasar el mouse
                            });
                          },
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => StartInspectionDialog(
                                        onStartInspection: () async {
                                      await websiteController.websiteInspection(
                                          sessionProvider.sessionID,
                                          sessionProvider.userID,
                                          selectedWebsite!);

                                      isWebsiteInspected = true;

                                      Navigator.of(context).pop();
                                    }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/icons/search.svg',
                                height: 40,
                                width: 40,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Start Website Inspection',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white)),
                            ],
                          ))
                    ]),
              )),
        ),
      );
    });
  }
}
