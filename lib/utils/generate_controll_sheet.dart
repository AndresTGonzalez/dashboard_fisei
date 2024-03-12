import 'package:dashboard_fisei/models/sheet.dart';
import 'package:dashboard_fisei/utils/selector_static_options.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateControllSheet {
  static Future generateControllSheet({
    String carrera = '',
    String laboratorio = '',
    String docente = '',
    String auxiliar = '',
    String periodo = '',
    String nivel = '',
    String ingreso = '',
    String salida = '',
    String materia = '',
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.merriweatherRegular();
    final fontBold = await PdfGoogleFonts.merriweatherBold();
    final ByteData image = await rootBundle.load('assets/images/escudo.png');
    Uint8List escudo = (image).buffer.asUint8List();
    final ByteData imageFISEI =
        await rootBundle.load('assets/images/fisei.png');
    Uint8List fisei = (imageFISEI).buffer.asUint8List();
    _generatePage(
      fecha: DateTime.now(),
      pdf: pdf,
      font: font,
      escudo: escudo,
      fisei: fisei,
      fontBold: fontBold,
      carrera: carrera,
      laboratorio: laboratorio,
      docente: docente,
      auxiliar: auxiliar,
      periodo: periodo,
      nivel: nivel,
      ingreso: ingreso,
      salida: salida,
      materia: materia,
    );
    final bytes = await pdf.save();
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);
  }

  static Future generateBlock({
    required List<Horario> horarios,
    required String manana,
    required String tarde,
    required DateTime fecha,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.merriweatherRegular();
    final fontBold = await PdfGoogleFonts.merriweatherBold();
    final ByteData image = await rootBundle.load('assets/images/escudo.png');
    Uint8List escudo = (image).buffer.asUint8List();
    final ByteData imageFISEI =
        await rootBundle.load('assets/images/fisei.png');
    Uint8List fisei = (imageFISEI).buffer.asUint8List();

    for (var i = 0; i < horarios.length; i++) {
      var inicio = int.parse(horarios[i].inicio);
      var auxiliar = '';
      if (inicio < 13) {
        auxiliar = manana;
      } else {
        auxiliar = tarde;
      }
      _generatePage(
        fecha: fecha,
        pdf: pdf,
        font: font,
        escudo: escudo,
        fisei: fisei,
        fontBold: fontBold,
        carrera: horarios[i].carrera,
        laboratorio: horarios[i].laboratorio,
        docente: horarios[i].docente,
        auxiliar: auxiliar,
        periodo: SelectorStaticOptions.periodo,
        nivel: horarios[i].nivel,
        ingreso: '${horarios[i].inicio}H00',
        salida: '${horarios[i].fin}H00',
        materia: horarios[i].materia,
      );
    }
    final bytes = await pdf.save();
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);
  }

  static void _generatePage({
    required DateTime fecha,
    pw.Document? pdf,
    pw.Font? font,
    Uint8List? escudo,
    Uint8List? fisei,
    pw.Font? fontBold,
    String carrera = '',
    String laboratorio = '',
    String docente = '',
    String auxiliar = '',
    String periodo = '',
    String nivel = '',
    String ingreso = '',
    String salida = '',
    String materia = '',
  }) {
    return pdf!.addPage(
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
                _header(font, carrera, escudo!, fisei!),
                _details(
                  fecha: fecha,
                  font: font,
                  fontBold: fontBold,
                  availableWidth: availableWidth,
                  carrera: carrera,
                  laboratorio: laboratorio,
                  docente: docente,
                  auxiliar: auxiliar,
                  periodo: periodo,
                  nivel: nivel,
                  ingreso: ingreso,
                  salida: salida,
                  materia: materia,
                ),
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
                for (var i = 0; i < 20; i++)
                  _tableRow(
                    index: i,
                    font: font,
                  ),
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

  static pw.Row _tableRow({
    int index = 0,
    dynamic font,
  }) {
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

  static pw.Container _details({
    required DateTime fecha,
    dynamic font,
    dynamic fontBold,
    double availableWidth = 0.0,
    String carrera = '',
    String laboratorio = '',
    String docente = '',
    String auxiliar = '',
    String periodo = '',
    String nivel = '',
    String ingreso = '',
    String salida = '',
    String materia = '',
  }) {
    // DateTime now = DateTime.now();

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
                  font: fontBold,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: availableWidth / 3.75,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  laboratorio.toUpperCase(),
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
                'DOCENTE: ',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: fontBold,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: 177,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  docente.toUpperCase(),
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
                  font: fontBold,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: availableWidth / 5,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  auxiliar.toUpperCase(),
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
                'PERIODO ACADÉMICO ${periodo.toUpperCase()}',
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
                  font: fontBold,
                  color: PdfColors.black,
                ),
              ),
              pw.Container(
                width: availableWidth / 3.5,
                height: 15,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  nivel.toUpperCase(),
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
                'FECHA: ${fecha.day} del ${SelectorStaticOptions.meses[fecha.month - 1]} de ${fecha.year}',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  font: fontBold,
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
                        font: fontBold,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: availableWidth / 3.25 - 50,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        ingreso.toUpperCase(),
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
                        font: fontBold,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: availableWidth / 3.25 - 50,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        salida.toUpperCase(),
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
                        font: fontBold,
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
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      'MATERIA: ',
                      style: pw.TextStyle(
                        fontSize: 6.5,
                        font: fontBold,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      width: 100,
                      height: 15,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        materia.toUpperCase(),
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
                        font: fontBold,
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
                    fontSize: 7,
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
