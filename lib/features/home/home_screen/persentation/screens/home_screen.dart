import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/features/home/widgets/appointment_options_bottom_sheet.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/app_styles.dart';
import '../../../../../core/strings/images.dart';
import '../../../data/models/service_model.dart';
import '../../../data/models/sub_services_model.dart';
import '../../../widgets/home_base_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ServiceModel> _services = [];
  final List<SubServices> _subServices = [];

  @override
  initState() {
    getSubServices();
    getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: getBody(),
    );
  }

  buildAppBar() {
    return CustomHomeAppBar(
      isSearchableAppBar: false,
      goodMorningText: AppLocalizations.of(context)!.good_morning,
      leadingIcon: Image.asset(
        appIcon,
        width: appBarIconWidth,
        height: appBarIconHeight,
      ),
      isTwoLineTitle: true,
    );
  }

  getBody() {
    return Container(
      color: whiteColor,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _services.length,
          padding: const EdgeInsetsDirectional.only(top: 22, start: 27, end: 27),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _services[index].name,
                          style: AppStyles.headlineStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: _services[index]
                      .subServices
                      .map((item) => DropdownMenuItem<SubServices>(
                            value: item,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    showBottomSheet(context: context, builder: (context)=> const AppointmentsBottomSheet());
                  },
                  icon: SvgPicture.asset(arrowRightIcon),
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: whiteColor,
                  ),
                  buttonElevation: 2,
                  itemHeight: 45,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: (MediaQuery.of(context).size.width - 54),
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: whiteColor,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                ),
              ),
            );
          }),
    );
  }

  void getServices() {
    _services.add(ServiceModel(1, "Cardiology", _subServices));
    _services.add(ServiceModel(2, "Ear, nose and throat", _subServices));
    _services.add(ServiceModel(3, "Gastroenterology", _subServices));
    _services.add(ServiceModel(4, "Elderly Services Department", _subServices));
    _services.add(ServiceModel(5, "Gynecology", _subServices));
    _services.add(ServiceModel(6, "Cardiology", _subServices));
    _services.add(ServiceModel(7, "Ear, nose and throat", _subServices));
    _services.add(ServiceModel(8, "Gastroenterology", _subServices));
  }

  void getSubServices() {
    _subServices.add(SubServices(1, "Echocardiography"));
    _subServices.add(SubServices(2, "Interventional Cardiology"));
    _subServices.add(SubServices(3, "Pediatric cardiology"));
    _subServices.add(SubServices(4, "Cardiac examination"));
    _subServices.add(SubServices(5, "Heart disorders"));
    _subServices.add(SubServices(6, "Echocardiography"));
    _subServices.add(SubServices(7, "Interventional Cardiology"));
    _subServices.add(SubServices(8, "Pediatric cardiology"));
    _subServices.add(SubServices(9, "Cardiac examination"));
    _subServices.add(SubServices(10, "Heart disorders"));
  }
}
