import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/forms/teachers_form.dart';
import 'package:dashboard_fisei/models/teacher.dart';
import 'package:dashboard_fisei/services/teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => TeachersService(),
        child: const _Table(),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final teachersService = Provider.of<TeachersService>(context);
    return teachersService.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.vine,
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _Search(teachersService: teachersService),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => TeachersService(),
                              child: TeacherFormDialog(
                                teachersService: teachersService,
                                teacher: Teacher(
                                  id: 0,
                                  cedula: '',
                                  nombre: '',
                                ),
                              ),
                            ),
                          );
                        },
                        color: AppColors.vine,
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
                _DataTable(teachersService: teachersService),
              ],
            ),
          );
  }
}

class _Search extends StatelessWidget {
  const _Search({
    super.key,
    required this.teachersService,
  });

  final TeachersService teachersService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged: (value) {
          teachersService.search(value);
        },
        cursorColor: AppColors.vine,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Buscar',
          prefixIcon: Icon(
            Icons.search,
            size: 20,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.vine,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.vine,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class _DataTable extends StatelessWidget {
  const _DataTable({
    super.key,
    required this.teachersService,
  });

  final TeachersService teachersService;

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
          DataColumn(label: Text('Cédula')),
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Acciones')),
        ],
        rows: [
          for (final teacher in teachersService.searchTeachers)
            DataRow(
              onSelectChanged: (value) {},
              cells: [
                DataCell(Text(teacher.cedula)),
                DataCell(Text(teacher.nombre)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => TeachersService(),
                              child: TeacherFormDialog(
                                teachersService: teachersService,
                                teacher: teacher,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
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
