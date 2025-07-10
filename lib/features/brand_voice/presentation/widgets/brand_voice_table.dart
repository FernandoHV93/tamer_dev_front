import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/brand_voice_entity.dart';

class BrandVoiceTable extends StatelessWidget {
  final List<BrandVoice> brands;
  final bool isLoading;
  final String? error;
  final void Function(BrandVoice brand) onEdit;
  final Future<void> Function(BrandVoice brand) onDelete;
  final VoidCallback? onCreateFirst;

  const BrandVoiceTable({
    super.key,
    required this.brands,
    required this.isLoading,
    required this.error,
    required this.onEdit,
    required this.onDelete,
    this.onCreateFirst,
  });

  @override
  Widget build(BuildContext context) {
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
          if (isLoading)
            const Center(
                child: CircularProgressIndicator(color: Color(0xFF3A7BFF))),
          if (!isLoading && error == null)
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
                          ? [] // No mostrar filas vacías, mostrar el estado vacío personalizado
                          : brands.map((brand) {
                              return DataRow(cells: [
                                DataCell(Text(brand.brandName,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(Text(brand.toneOfVoice,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(Wrap(
                                  spacing: 6,
                                  children: brand.keyValues
                                      .map((kv) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0x803A7BFF),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              kv,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 152, 186, 255),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                          ))
                                      .toList(),
                                )),
                                DataCell(Text(brand.targetAudience,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/images/icons/edit.svg',
                                        width: 20,
                                        height: 20,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.blueAccent, BlendMode.srcIn),
                                      ),
                                      tooltip: 'Edit',
                                      onPressed: () => onEdit(brand),
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/images/icons/delete.svg',
                                        width: 20,
                                        height: 20,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.redAccent, BlendMode.srcIn),
                                      ),
                                      tooltip: 'Delete',
                                      onPressed: () => onDelete(brand),
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
          // Estado vacío personalizado
          if (!isLoading && brands.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/flag.svg',
                    width: 80,
                    height: 80,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF3A7BFF),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No Brand Voices Yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Create your first brand voice to establish a consistent tone across all your content.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: onCreateFirst,
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Create Your First Brand Voice',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A7BFF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
