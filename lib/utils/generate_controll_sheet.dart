import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateControllSheet {
  static Future generateControllSheet() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.merriweatherRegular();
    final fontBold = await PdfGoogleFonts.merriweatherBold();

    final ByteData image = await rootBundle.load('assets/images/escudo.png');
    Uint8List escudo = (image).buffer.asUint8List();
    final ByteData imageFISEI =
        await rootBundle.load('assets/images/fisei.png');
    Uint8List fisei = (imageFISEI).buffer.asUint8List();

    const String carrera = 'Ingeniería en Sistemas';

    for (var i = 0; i < 10; i++) {
      _generatePage(pdf, font, carrera, escudo, fisei, fontBold);
    }

    final bytes = await pdf.save();
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);
  }

  static void _generatePage(pw.Document pdf, pw.Font font, String carrera,
      Uint8List escudo, Uint8List fisei, pw.Font fontBold) {
    return pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        margin:
            const pw.EdgeInsets.only(left: 50, top: 5, right: 10, bottom: 5),
        build: (pw.Context context) {
          final availableWidth = context.page.pageFormat.availableWidth + 60;
          return pw.Container(
            width: double.infinity,
            height: double.infinity,
            child: pw.Column(
              children: [
                _header(font, carrera, escudo, fisei),
                _details(font, availableWidth, carrera),
                pw.Container(
                  width: double.infinity,
                  child: pw.Text(
                    'REGISTRO DE PRÁCTICAS DE LABORATORIO',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 7,
                      font: fontBold,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                _tableHeaders(
                  font,
                ),
                for (var i = 0; i < 20; i++) _tableRow(i, font),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          '________________________',
                          style: pw.TextStyle(
                            fontSize: 7,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          'FIRMA DEL DOCENTE',
                          style: pw.TextStyle(
                            fontSize: 7,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          '________________________',
                          style: pw.TextStyle(
                            fontSize: 7,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          'FIRMA DEL RESPONSABLE',
                          style: pw.TextStyle(
                            fontSize: 7,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static pw.Row _tableHeaders(
    dynamic font,
  ) {
    return pw.Row(
      children: [
        pw.Container(
          width: 25,
          height: 10,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 0.5,
            ),
          ),
          child: pw.Text(
            '#MAQ',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              font: font,
              color: PdfColors.black,
              fontSize: 7,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Container(
          width: 210,
          height: 10,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 0.5,
            ),
          ),
          child: pw.Text(
            'NÓMINA DE ESTUDIANTES',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              font: font,
              color: PdfColors.black,
              fontSize: 7,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Container(
          width: 125,
          height: 10,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 0.5,
            ),
          ),
          child: pw.Text(
            'OBSERVACIONES',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              font: font,
              color: PdfColors.black,
              fontSize: 7,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Row _tableRow(int index, dynamic font) {
    return pw.Row(
      children: [
        pw.Container(
          width: 25,
          height: 20,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 0.5,
            ),
          ),
          child: pw.Text(
            '${index + 1}',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              font: font,
              color: PdfColors.black,
              fontSize: 7,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Column(
          children: [
            pw.Container(
              width: 210,
              height: 10,
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 0.5,
                ),
              ),
            ),
            pw.Container(
              width: 210,
              height: 10,
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 0.5,
                ),
              ),
            ),
          ],
        ),
        pw.Container(
          width: 125,
          height: 20,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Container _details(
      dynamic font, double availableWidth, String carrera) {
    DateTime now = DateTime.now();

    return pw.Container(
      width: availableWidth,
      height: 78,
      child: pw.Column(
        children: [
          pw.Row(
            children: [
              pw.Text(
                'LABORATORIO: ',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: font,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: availableWidth / 3,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  'Lab. Robótica y Redes Industriales'.toUpperCase(),
                  maxLines: 2,
                  overflow: pw.TextOverflow.clip,
                  style: pw.TextStyle(
                    fontSize: 6.5,
                    font: font,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(width: 5),
              pw.Text(
                'DOCENTE: ',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: font,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: 146,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  'CARLOS NUÑEZ',
                  maxLines: 2,
                  overflow: pw.TextOverflow.clip,
                  style: pw.TextStyle(
                    fontSize: 6.5,
                    font: font,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Text(
                'AUXILIAR DE LABORATORIO: ',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: font,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: availableWidth / 3.5,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  'ALEXANDRA BARRIONUEVO',
                  maxLines: 2,
                  overflow: pw.TextOverflow.clip,
                  style: pw.TextStyle(
                    fontSize: 6.5,
                    font: font,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.Text(
                'PERIODO ACADÉMICO ABRIL-AGOSTO 2021',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: font,
                  color: PdfColors.black,
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Text(
                'NIVEL: ',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: font,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: availableWidth / 3.5,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  'Primero A',
                  maxLines: 2,
                  overflow: pw.TextOverflow.clip,
                  style: pw.TextStyle(
                    fontSize: 6.5,
                    font: font,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(width: 20),
              pw.Text(
                'FECHA: ${now.day}/${now.month}/${now.year}',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: font,
                  color: PdfColors.black,
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                height: 15,
                width: availableWidth / 3.25,
                child: pw.Row(
                  // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'H.INGRESO: ',
                      style: pw.TextStyle(
                        fontSize: 6.5,
                        font: font,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: availableWidth / 3.25 - 50,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        '07:00',
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                          fontSize: 6.5,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                height: 15,
                width: availableWidth / 3.25,
                child: pw.Row(
                  children: [
                    pw.Text(
                      'H.SALIDA: ',
                      style: pw.TextStyle(
                        fontSize: 6.5,
                        font: font,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: availableWidth / 3.25 - 50,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        '07:00',
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                          fontSize: 6.5,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                height: 15,
                width: availableWidth / 3.25,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'H.PRÁCTICAS: ',
                      style: pw.TextStyle(
                        fontSize: 6.5,
                        font: font,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: availableWidth / 3.25 - 50,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        '____________________',
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                          fontSize: 6.5,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.Row(
            children: [
              pw.Container(
                height: 15,
                width: availableWidth / 2.5,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'MATERIA: ',
                      style: pw.TextStyle(
                        fontSize: 6.5,
                        font: font,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: 125,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'Fundamentos de la Ingeniería de Software',
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                          fontSize: 6.5,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                height: 15,
                width: availableWidth / 2.5,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'TEMA DE LA PRÁCTICA: ',
                      style: pw.TextStyle(
                        fontSize: 6.5,
                        font: font,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: 127,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        '_________________________________________________',
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                          fontSize: 6.5,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Container _header(
    dynamic font,
    String carrera,
    Uint8List escudo,
    Uint8List fisei,
  ) {
    return pw.Container(
      width: double.infinity,
      height: 40,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Container(
            width: 50,
            height: 40,
            child: pw.Image(
              pw.MemoryImage(escudo),
              fit: pw.BoxFit.contain,
            ),
          ),
          // Aqui va el Encabezado
          pw.Container(
            width: 200,
            height: 40,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'UNIVERSIDAD TÉCNICA DE AMBATO',
                  style: pw.TextStyle(
                    fontSize: 10,
                    font: font,
                    color: PdfColors.black,
                  ),
                ),
                pw.Text(
                  'FISEI',
                  style: pw.TextStyle(
                    fontSize: 9,
                    font: font,
                    color: PdfColors.black,
                  ),
                ),
                pw.Text(
                  'CARRERA DE ${carrera.toUpperCase()}',
                  style: pw.TextStyle(
                    fontSize: 9,
                    font: font,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 50,
            height: 40,
            child: pw.Image(
              pw.MemoryImage(fisei),
              fit: pw.BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
