import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/services/teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.vine,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onChanged: (value) {
                teachersService.search(value);
              },
              cursorColor: AppColors.vine,
              decoration: const InputDecoration(
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search),
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
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: DataTable(
              showCheckboxColumn: false,
              columnSpacing: 20,
              headingTextStyle: GoogleFonts.openSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              dividerThickness: 0.7,
              dataTextStyle: GoogleFonts.openSans(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: [
                for (final teacher in teachersService.searchTeachers)
                  DataRow(
                    onSelectChanged: (value) {},
                    cells: [
                      DataCell(Text('${teacher.identification}')),
                      DataCell(Text(teacher.name)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
