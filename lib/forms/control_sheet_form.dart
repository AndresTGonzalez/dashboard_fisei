import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/providers/individual_sheet_provider.dart';
import 'package:dashboard_fisei/services/select_laboratory_service.dart';
import 'package:dashboard_fisei/services/select_subject_service.dart';
import 'package:dashboard_fisei/services/select_teacher_service.dart';
import 'package:dashboard_fisei/utils/selector_static_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ControlSheetForm extends StatelessWidget {
  const ControlSheetForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectLaboratoryService()),
        ChangeNotifierProvider(create: (_) => SelectTeacherService()),
        ChangeNotifierProvider(create: (_) => SelectSubjectService()),
        ChangeNotifierProvider(create: (_) => IndividualSheetProvider()),
      ],
      child: const _Dialog(),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectLaboratoryService =
        Provider.of<SelectLaboratoryService>(context);
    final selectTeacherService = Provider.of<SelectTeacherService>(context);
    final selectSubjectService = Provider.of<SelectSubjectService>(context);
    final individualSheetProvider =
        Provider.of<IndividualSheetProvider>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Hoja de control individual',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.carreras.map((carr) {
                        return DropdownMenuItem(
                          value: carr.id,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              carr.carrera,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectSubjectService.selectCarrer = value as int;
                        individualSheetProvider.carrera = SelectorStaticOptions
                            .carreras
                            .firstWhere((carr) => carr.id == value)
                            .carrera;
                        selectSubjectService
                            .getSubjects(selectSubjectService.selectCarrer);
                      },
                      decoration: _dropdownStyle(label: 'Carrera'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.14,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.niveles.map((level) {
                        return DropdownMenuItem(
                          value: level.nivel,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              level.nivel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        individualSheetProvider.nivel = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Nivel'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.parallels.map((parallel) {
                        return DropdownMenuItem(
                          value: parallel.parallel,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.044,
                            child: Text(
                              parallel.parallel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        individualSheetProvider.paralelo = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Paralelo'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items:
                          selectLaboratoryService.selectLaboratories.map((lab) {
                        return DropdownMenuItem(
                          value: lab.laboratory,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              lab.laboratory,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        individualSheetProvider.laboratorio = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Laboratorio'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items: selectTeacherService.teachers.map((teacher) {
                        return DropdownMenuItem(
                          value: teacher.nombre,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              teacher.nombre,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        individualSheetProvider.docente = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Docente'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items: selectSubjectService.selectSubjects.map((sub) {
                        return DropdownMenuItem(
                          value: sub.subject,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              sub.subject,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: selectSubjectService.selectCarrer == 0
                          ? null
                          : (value) {
                              // schedulesService.actividadId = value as int;
                              individualSheetProvider.materia = value as String;
                            },
                      decoration: _dropdownStyle(label: 'Materia'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.hours.map((hour) {
                        return DropdownMenuItem(
                          value: hour.hour,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: Text(
                              hour.hour,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        individualSheetProvider.ingreso = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Inicio'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.hours.map((hour) {
                        return DropdownMenuItem(
                          value: hour.hour,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: Text(
                              hour.hour,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        individualSheetProvider.salida = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Fin'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButtonFormField(
                  items: SelectorStaticOptions.auxiliares
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
                  onChanged: (value) {
                    individualSheetProvider.auxiliar = value as String;
                  },
                  decoration: _dropdownStyle(label: 'Auxiliar'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'La fecha de la hoja de control se asignará automáticamente al día de hoy.',
                  style: GoogleFonts.openSans(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
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
            await individualSheetProvider.generateSheet();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          color: AppColors.green,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Guardar',
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
