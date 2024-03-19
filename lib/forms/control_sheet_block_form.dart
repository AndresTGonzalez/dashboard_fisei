import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:dashboard_fisei/providers/control_sheet_provider.dart';
import 'package:dashboard_fisei/utils/generate_controll_sheet.dart';
import 'package:dashboard_fisei/utils/selector_static_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ControlSheetBlockForm extends StatelessWidget {
  const ControlSheetBlockForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ControlSheetProvider()),
      ],
      child: _Dialog(),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controlSheetProvider = Provider.of<ControlSheetProvider>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Generar hojas de control por bloque',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      scrollable: true,
      content: Form(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  items: SelectorStaticOptions.bloques
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.name,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controlSheetProvider.blok = value as int;
                    controlSheetProvider.manana = '';
                    controlSheetProvider.tarde = '';
                  },
                  decoration: _dropdownStyle(label: 'Bloque'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextFormField(
                  controller: controlSheetProvider.dateinput,
                  readOnly: true,
                  decoration: _dropdownStyle(label: 'Fecha'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      controlSheetProvider.date = pickedDate;
                    } else {}
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButtonFormField(
                  items: controlSheetProvider.blok == 1
                      ? SelectorStaticOptions.auxiliares
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList()
                      : SelectorStaticOptions.auxiliares
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: controlSheetProvider.blok == 0
                      ? null
                      : (value) {
                          controlSheetProvider.manana = value as String;
                        },
                  decoration: _dropdownStyle(label: 'Auxiliar en la mañana'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButtonFormField(
                  items: controlSheetProvider.blok == 1
                      ? SelectorStaticOptions.auxiliares
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList()
                      : SelectorStaticOptions.auxiliares
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: controlSheetProvider.blok == 0
                      ? null
                      : (value) {
                          controlSheetProvider.tarde = value as String;
                        },
                  decoration: _dropdownStyle(label: 'Auxiliar en la tarde'),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        // Puedes agregar botones o acciones en el modal
        TextButton(
          child: Text(
            'Cerrar',
            style: GoogleFonts.openSans(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          onPressed: () {
            // Cierra el modal
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          onPressed: () async {
            controlSheetProvider.getSchedules(blok: controlSheetProvider.blok);
          },
          color: AppColors.green,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Generar hojas de control',
            style: GoogleFonts.openSans(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }

  InputDecoration _dropdownStyle({String? label}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.black,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      labelText: label,
      labelStyle: GoogleFonts.openSans(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}
