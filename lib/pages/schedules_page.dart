import 'package:dashboard_fisei/constants/constants.dart';
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
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SchedulesService(),
          ),
          ChangeNotifierProvider(create: (_) => SelectTeacherService()),
        ],
        child: const _Table(),
      ),
    );
  }
}

class _Table extends StatefulWidget {
  const _Table({
    super.key,
  });

  @override
  State<_Table> createState() => _TableState();
}

class _TableState extends State<_Table> {
  bool available = false;
  int teacherId = 0;
  String teacherName = '';

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

  @override
  Widget build(BuildContext context) {
    final schedulesService = Provider.of<SchedulesService>(context);
    final selectTeacherService = Provider.of<SelectTeacherService>(context);
    return schedulesService.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.vine,
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButtonFormField(
                          value: teacherId == 0 ? null : teacherId,
                          items: selectTeacherService.teachers
                              .map(
                                (teacher) => DropdownMenuItem(
                                  value: teacher.id,
                                  child: Text(teacher.nombre),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              available = true;
                            });
                            setState(() {
                              teacherId = value as int;
                            });
                            setState(() {
                              teacherName = selectTeacherService.teachers
                                  .firstWhere(
                                      (teacher) => teacher.id == teacherId)
                                  .nombre;
                            });
                            schedulesService
                                .getSchedulesByTeacher(value as int);
                          },
                          decoration: _dropdownStyle(label: 'Docente'),
                        ),
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: !available
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ScheduleForm();
                                  },
                                );
                              },
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
                                'Nuevo',
                                style: GoogleFonts.openSans(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                available
                    ? _DataTable(schedulesService: schedulesService)
                    : const SizedBox(),
              ],
            ),
          );
  }
}

class _DataTable extends StatelessWidget {
  const _DataTable({
    super.key,
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
        rows: [
          for (final schedule in schedulesService.schedules)
            DataRow(
              onSelectChanged: (value) {},
              cells: [
                DataCell(Text(schedule.actividad)),
                DataCell(Text(schedule.carrera)),
                DataCell(Text('${schedule.nivel} ${schedule.paralelo}')),
                DataCell(Text(schedule.diaSemana)),
                DataCell(Text('${schedule.horaInicio}:00')),
                DataCell(Text('${schedule.horaFin}:00')),
                DataCell(Text(schedule.aulaPuestoInfo)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Eliminar',
                        onPressed: () {
                          //Dialogo para mostrar confirmacion de eliminar
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
                                  onPressed: () async {},
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
                        icon: const Icon(Icons.delete),
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
}
