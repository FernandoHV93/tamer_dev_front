import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContentGaps extends StatefulWidget {
  const ContentGaps({super.key});

  @override
  State<ContentGaps> createState() => _ContentGapsState();
}

class _ContentGapsState extends State<ContentGaps> {
  final TextEditingController _controller = TextEditingController();
  final RegExp _urlRegExp = RegExp(r'^(http|https)://.*');
  List<String> urls = [];
  bool isHovered = false;
  bool _isValid = false;

  bool _isAddButtonHovered = false;
  bool _isDeleteHovered = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validateUrl);
  }

  void _validateUrl() {
    final isValid = _urlRegExp.hasMatch(_controller.text);
    setState(() => _isValid = isValid && _controller.text.isNotEmpty);
  }

  void _addUrl() {
    if (urls.length >= 2 || !_isValid) return;
    setState(() {
      urls.add(_controller.text);
      _controller.clear();
      _isValid = false;
    });
  }

  void _removeUrl(int index) {
    setState(() => urls.removeAt(index));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            'assets/images/icons/target.png',
                            height: 75,
                            width: 75,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Competitor Analysis",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Analyze your competitor's content to find",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text('opportunities', style: TextStyle(fontSize: 18))
                        ]),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text('Competitor Websites (Max. 2)',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0))),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(4),
                            shadowColor: Colors.black26,
                            color: Colors.white,
                            child: TextField(
                                controller: _controller,
                                onSubmitted: (_) => _addUrl(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Color cuando no está enfocado
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  // Borde cuando está enfocado
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 23, 87, 223),
                                        width: 2), // Azul con grosor 2
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  hintText: 'Enter Competitor URL',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 14),
                                )),
                          )),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: _isValid && urls.length < 2
                                    ? (_isAddButtonHovered
                                        ? const Color.fromARGB(
                                            255, 12, 67, 173) // Color hover
                                        : const Color.fromARGB(
                                            255, 23, 87, 223)) // Color normal
                                    : Colors.black38,
                                size: 28,
                              ),
                              onHover: (hovering) {
                                setState(() => _isAddButtonHovered = hovering);
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onPressed:
                                  _isValid && urls.length < 2 ? _addUrl : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 17),
                      ...urls.map((url) => _buildUrlItem(url)),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: urls.isEmpty
                                ? const Color.fromARGB(96, 33, 103, 243)
                                : isHovered
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
                          onPressed: urls.isNotEmpty ? () {} : null,
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
                              Text('Analyze Content Gaps',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white)),
                            ],
                          ))
                    ]))));
  }

  Widget _buildUrlItem(String url) {
    final index = urls.indexOf(url);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('COMPETITOR URL',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
              const SizedBox(height: 4),
              Text(
                url,
                style: const TextStyle(fontSize: 14),
              )
            ]),
          ),
          MouseRegion(
            onEnter: (_) => setState(() => _isDeleteHovered = true),
            onExit: (_) => setState(() => _isDeleteHovered = false),
            child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/icons/delete.svg',
                  height: 25,
                  width: 25,
                  color: _isDeleteHovered
                      ? const Color.fromARGB(255, 255, 34, 34) // Rojo vino
                      : const Color.fromARGB(255, 178, 34, 34),
                ),
                onPressed: () => _removeUrl(index),
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
