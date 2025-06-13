import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartInspectionDialog extends StatelessWidget {
  final VoidCallback onStartInspection;
  const StartInspectionDialog({super.key, required this.onStartInspection});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SizedBox(
        width: 350,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                SvgPicture.asset(
                  'assets/images/icons/warning.svg',
                  height: 30,
                  width: 30,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 5,
                ),
                const Text(
                  'Confirm Website Inspection',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ]),
              const SizedBox(height: 16),
              const Text(
                'This action will consume 1 Inspection Domain token. This process:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              const Text(
                '* Initiates a web crawl of the specified site\n* Token consumption cannot be reversed \n* Please veridy all information before proceeding',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 12,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 190, 114, 7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onStartInspection,
                  child: const Text('Confirm & Start Inspection'),
                )
              ])
            ]),
      ),
    );
  }
}
