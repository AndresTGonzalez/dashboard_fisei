import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:dashboard_fisei/forms/complementary_form.dart';
import 'package:dashboard_fisei/forms/schedule_form.dart';
import 'package:dashboard_fisei/services/schedules_service.dart';
import 'package:dashboard_fisei/services/select_teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SchedulesPage extends StatelessWidget {
  const SchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SchedulesService()),
        ChangeNotifierProvider(create: (_) => SelectTeacherService()),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final selectTeachersService = Provider.of<SelectTeacherService>(context);
    final schedulesService = Provider.of<SchedulesService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButtonFormField(
                      items: selectTeachersService.teachers.map((teacher) {
                        return DropdownMenuItem(
                          value: teacher.id,
                          child: Text(
                            teacher.nombre,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        schedulesService.selectedTeacherId = value as int;
                        schedulesService.docenteId = value;
                      },
                      decoration: _dropdownStyle(label: 'Profesor'),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: schedulesService.selectedTeacherId != 0
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ComplementaryForm(
                                      schedulesService: schedulesService,
                                      teacherId:
                                          schedulesService.selectedTeacherId,
                                    );
                                  },
                                );
                              }
                            : null,
                        color: AppColors.black,
                        disabledColor: Colors.black26,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          // color: AppColors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: AppColors.white,
                              ),
                              Text(
                                'Complementario',
                                style: GoogleFonts.openSans(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      MaterialButton(
                        onPressed: schedulesService.selectedTeacherId != 0
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ScheduleForm2(
                                      schedulesService: schedulesService,
                                      teacherId:
                                          schedulesService.selectedTeacherId,
                                    );
                                  },
                                );
                              }
                            : null,
                        color: AppColors.vine,
                        disabledColor: Colors.black26,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          // color: AppColors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: AppColors.white,
                              ),
                              Text(
                                'Horario',
                                style: GoogleFonts.openSans(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Aqui inicia la tabla
            _DataTableSchedules(schedulesService: schedulesService),
          ],
        ),
      ),
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

class _DataTableSchedules extends StatelessWidget {
  const _DataTableSchedules({
    required this.schedulesService,
  });

  final SchedulesService schedulesService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: DataTable(
          showCheckboxColumn: false,
          columnSpacing: 20,
          headingTextStyle: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          dividerThickness: 0.2,
          dataTextStyle: GoogleFonts.openSans(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          columns: const [
            DataColumn(label: Text('Materia')),
            DataColumn(label: Text('Carrera')),
            DataColumn(label: Text('Nivel')),
            DataColumn(label: Text('Dia')),
            DataColumn(label: Text('Inicio')),
            DataColumn(label: Text('Fin')),
            DataColumn(label: Text('Laboratorio')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: schedulesService.schedules.map((schedule) {
            return DataRow(
              cells: [
                DataCell(Text(schedule.actividad)),
                DataCell(Text(schedule.carrera)),
                DataCell(Text('${schedule.nivel}')),
                DataCell(Text(schedule.diaSemana)),
                DataCell(Text(schedule.horaInicio)),
                DataCell(Text(schedule.horaFin)),
                DataCell(Text(schedule.aulaPuestoInfo)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Eliminar'),
                              content: const Text(
                                  '¿Está seguro que desea eliminar este horario?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    await schedulesService
                                        .deleteSchedule(schedule.id);
                                    Navigator.of(context).pop();
                                  },
                                  color: AppColors.vine,
                                  child: const Text(
                                    'Eliminar',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.vine,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList()),
    );
  }
}
