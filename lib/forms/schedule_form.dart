import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:dashboard_fisei/services/schedules_service.dart';
import 'package:dashboard_fisei/services/select_laboratory_service.dart';
import 'package:dashboard_fisei/services/select_subject_service.dart';
import 'package:dashboard_fisei/utils/selector_static_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScheduleForm2 extends StatelessWidget {
  final int teacherId;
  final SchedulesService schedulesService;

  const ScheduleForm2({
    required this.schedulesService,
    required this.teacherId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => SchedulesService()),
        ChangeNotifierProvider(create: (_) => SelectSubjectService()),
        ChangeNotifierProvider(create: (_) => SelectLaboratoryService()),
      ],
      child: _FormDialog(
        schedulesService: schedulesService,
        teacherId: teacherId,
      ),
    );
  }
}

class _FormDialog extends StatelessWidget {
  final SchedulesService schedulesService;

  final int teacherId;

  _FormDialog({
    required this.teacherId,
    required this.schedulesService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final schedulesService = Provider.of<SchedulesService>(context);
    final selectSubjectService = Provider.of<SelectSubjectService>(context);
    final selectLaboratoryService =
        Provider.of<SelectLaboratoryService>(context);
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Agregar horario',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.days
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: Text(
                                e.day,
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
                        schedulesService.numeroDia = value as int;
                      },
                      decoration: _dropdownStyle(label: 'Día'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.hours
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: Text(
                                e.hour,
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
                        schedulesService.horaInicio = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Hora de inicio'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.hours
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: Text(
                                e.hour,
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
                        schedulesService.horaFin = value as String;
                      },
                      decoration: _dropdownStyle(label: 'Hora de fin'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Carrera y Materia
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.carreras
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.id,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: SizedBox(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    child: Text(
                                      e.carrera,
                                      style: GoogleFonts.openSans(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        selectSubjectService.selectCarrer = value as int;
                        selectSubjectService
                            .getSubjects(selectSubjectService.selectCarrer);
                      },
                      decoration: _dropdownStyle(label: 'Carrera'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items: selectSubjectService.selectSubjects
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Text(
                                  e.subject,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: selectSubjectService.selectCarrer == 0
                          ? null
                          : (value) {
                              schedulesService.actividadId = value as int;
                            },
                      decoration: _dropdownStyle(label: 'Materia'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Laboratorio y Paralelo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items: SelectorStaticOptions.parallels
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: Text(
                                e.parallel,
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
                        schedulesService.paraleloId = value as int;
                      },
                      decoration: _dropdownStyle(label: 'Paralelo'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: DropdownButtonFormField(
                      items: selectLaboratoryService.selectLaboratories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Text(
                                  e.laboratory,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        schedulesService.aulaId = value as int;
                      },
                      decoration: _dropdownStyle(label: 'Laboratorio'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 1,
                color: AppColors.black.withOpacity(0.2),
              ),
              const SizedBox(height: 20),
              // Aqui va el boton y el puesto
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: MaterialButton(
                        onPressed: () {
                          schedulesService.isPosition =
                              !schedulesService.isPosition;
                        },
                        color: schedulesService.isPosition
                            ? AppColors.vine
                            : AppColors.green,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          schedulesService.isPosition
                              ? 'Deshabilitar puesto'
                              : 'Habilitar puesto',
                          style: GoogleFonts.openSans(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  schedulesService.isPosition
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: TextFormField(
                            enabled: schedulesService.isPosition,
                            onChanged: (value) {
                              schedulesService.numeroPuesto = value;
                            },
                            decoration: _dropdownStyle(label: 'Puesto'),
                          ),
                        )
                      : const SizedBox(),
                ],
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
            if (await schedulesService.addSchedule(
              aulaId: schedulesService.aulaId,
              docenteId: teacherId,
              actividadId: schedulesService.actividadId,
              paraleloId: schedulesService.paraleloId,
              horaInicio: schedulesService.horaInicio,
              horaFin: schedulesService.horaFin,
              numeroPuesto: schedulesService.numeroPuesto,
              numeroDia: schedulesService.numeroDia,
            )) {
              await schedulesService.getSchedulesByTeacher(teacherId);
              Navigator.of(context).pop();
            } else {
              // Mostrar error
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Error al agregar el horario',
                    style: GoogleFonts.openSans(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  backgroundColor: AppColors.black,
                ),
              );
            }
            // Actualiza la lista de horarios
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
