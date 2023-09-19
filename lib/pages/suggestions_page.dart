import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/services/suggestions_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => SuggestionsService(),
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
    final suggestionsService = Provider.of<SuggestionsService>(context);
    return suggestionsService.isLoading
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
                      _Search(suggestionsService: suggestionsService),
                      const Spacer(),
                    ],
                  ),
                ),
                _DataTable(suggestionsService: suggestionsService),
              ],
            ),
          );
  }
}

class _Search extends StatelessWidget {
  const _Search({
    super.key,
    required this.suggestionsService,
  });

  final SuggestionsService suggestionsService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged: (value) {
          suggestionsService.search(value);
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
    required this.suggestionsService,
  });

  final SuggestionsService suggestionsService;

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
          DataColumn(label: Text('Título')),
          DataColumn(label: Text('Descripción')),
          DataColumn(label: Text('Aula/Laboratorio')),
        ],
        rows: [
          for (final suggestion in suggestionsService.searchsuggestions)
            DataRow(
              onSelectChanged: (value) {},
              cells: [
                DataCell(Text(suggestion.nombre)),
                DataCell(Text(suggestion.descripcion)),
                DataCell(Text(suggestion.aula)),
              ],
            ),
        ],
      ),
    );
  }
}
