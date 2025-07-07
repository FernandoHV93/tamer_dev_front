import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../provider/brand_voice_provider.dart';
import '../provider/brand_form_provider.dart';

class BrandVoiceTable extends StatelessWidget {
  const BrandVoiceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<BrandVoiceProvider, BrandFormProvider>(
      builder: (context, brandProvider, formProvider, _) {
        final brands = brandProvider.savedBrands;
        return Container(
          margin: const EdgeInsets.only(top: 32),
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF23262F),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saved Brand Voices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: const Color(0xFF35373F),
                      ),
                      child: DataTable(
                        headingRowColor:
                            MaterialStateProperty.all(const Color(0xFF23262F)),
                        dataRowColor:
                            MaterialStateProperty.all(const Color(0xFF23262F)),
                        columnSpacing: 32,
                        columns: const [
                          DataColumn(
                              label: Expanded(
                                  child: Text('Brand Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('Tone of Voice',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('Key Values',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('Audience',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('Actions',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                        ],
                        rows: brands.isEmpty
                            ? [
                                DataRow(cells: [
                                  DataCell(Text('No brands saved',
                                      style: TextStyle(color: Colors.white54))),
                                  DataCell(Container()),
                                  DataCell(Container()),
                                  DataCell(Container()),
                                  DataCell(Container()),
                                ])
                              ]
                            : brands.map((brand) {
                                return DataRow(cells: [
                                  DataCell(Text(brand.brandName,
                                      style: const TextStyle(
                                          color: Colors.white))),
                                  DataCell(Text(brand.toneOfVoice,
                                      style: const TextStyle(
                                          color: Colors.white))),
                                  DataCell(Wrap(
                                    spacing: 6,
                                    children: brand.keyValues
                                        .map((kv) => Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: const Color(0x803A7BFF),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                kv,
                                                style: const TextStyle(
                                                  color: Color(0xFF3A7BFF),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )),
                                  DataCell(Text(brand.targetAudience,
                                      style: const TextStyle(
                                          color: Colors.white))),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/images/icons/edit.svg',
                                          width: 20,
                                          height: 20,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.blueAccent,
                                              BlendMode.srcIn),
                                        ),
                                        tooltip: 'Edit',
                                        onPressed: () {
                                          formProvider.setEditingBrand(brand);
                                        },
                                      ),
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/images/icons/delete.svg',
                                          width: 20,
                                          height: 20,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.redAccent,
                                              BlendMode.srcIn),
                                        ),
                                        tooltip: 'Delete',
                                        onPressed: () {
                                          brandProvider.removeBrand(brand);
                                        },
                                      ),
                                    ],
                                  )),
                                ]);
                              }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
