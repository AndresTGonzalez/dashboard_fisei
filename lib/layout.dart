import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/pages/pages.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColors.vine,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_fisei.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              'Horarios FISEI',
              style: GoogleFonts.nunito(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              openSideMenuWidth: MediaQuery.of(context).size.width * 0.13,
              compactSideMenuWidth: 60,
              displayMode: SideMenuDisplayMode.auto,
              itemHeight: 40,
              itemOuterPadding:
                  const EdgeInsets.only(top: 10, left: 10, right: 10),
              selectedColor: Colors.white,
              unselectedTitleTextStyle: GoogleFonts.openSans(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              unselectedIconColor: Colors.white,
              selectedTitleTextStyle: GoogleFonts.openSans(
                color: AppColors.vine,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              selectedIconColor: AppColors.vine,
              itemBorderRadius: const BorderRadius.all(Radius.circular(10)),
              backgroundColor: AppColors.vine,
            ),
            items: [
              SideMenuItem(
                title: 'Inicio',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                tooltipContent: "Inicio",
              ),
              SideMenuItem(
                title: 'Horarios',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.schedule),
                tooltipContent: "Inicio",
              ),
              SideMenuItem(
                title: "Docentes",
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.supervisor_account),
                tooltipContent: "Docentes",
              ),
              SideMenuItem(
                title: 'Materias',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.book),
                tooltipContent: "Materias",
              ),
              SideMenuItem(
                title: 'Aulas/Laboratorios',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.desktop_windows),
                tooltipContent: "Aulas",
              ),
              SideMenuItem(
                title: 'Sugerencias',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.inbox_rounded),
                tooltipContent: "Sugerencias",
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomePage(),
                SchedulesPage(),
                TeachersPage(),
                SubjectsPage(),
                LaboratoriesPage(),
                SuggestionsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
