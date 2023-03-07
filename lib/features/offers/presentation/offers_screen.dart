import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medical_valley/core/app_colors.dart';
import 'package:medical_valley/core/app_styles.dart';
import 'package:medical_valley/core/medical_injection.dart';
import 'package:medical_valley/core/widgets/custom_app_bar.dart';
import 'package:medical_valley/features/home/history/data/clinic_model.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_bloc.dart';
import 'package:medical_valley/features/offers/presentation/presentation/bloc/offers_state.dart';
import 'package:medical_valley/features/offers/widgets/offers_options_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class OffersScreen extends StatefulWidget {
 final int serviceId , categoryId ;
  const OffersScreen({
    required this.categoryId ,
    required this.serviceId,
    Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  OffersBloc offersBloc = getIt.get<OffersBloc>();
  BehaviorSubject<int> sortOption = BehaviorSubject();

  @override
  void initState() {
    offersBloc.getOffers(OffersEvent(1, 10 , widget.serviceId  , widget.categoryId));
    optionDisplayed.sink.add(false);
    sortOption.sink.add(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>optionDisplayed.sink.add(false),
      child: Scaffold(
        appBar:  MyCustomAppBar(
          header: AppLocalizations.of(context)!.request_price,
          leadingIcon: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),
        ),
        body: BlocBuilder<OffersBloc, OffersState>(
          bloc: offersBloc,
          builder: (context, state) {
            if(state is OffersStateLoading){
              return CircularProgressIndicator();
              }

              return SizedBox();
            /*Stack(
                children: [
                  Column(
                    children: [
                      FilterView(
                          onSortTapped  : (){
                            optionDisplayed.sink.add(!optionDisplayed.value);
                          }
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,

                          physics: const BouncingScrollPhysics(),
                          padding:  EdgeInsets.only(bottom: 128.h, ),
                          itemCount: state.clinics?.items?.length,
                          itemBuilder: (BuildContext context, int index) {

                            return OfferCard(state.clinics!.items![index]);
                          },

                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 30.h,
                    right: 0,
                    child: StreamBuilder<bool>(
                        stream: optionDisplayed.stream,
                        builder: (context, snapshot) {
                          return optionDisplayed.value
                              ? Visibility(
                            visible: optionDisplayed.value,
                            child: Container(
                              padding: smallPaddingAll,
                              margin: smallPaddingH,
                              height: 195.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  border: Border.all(width: .2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: StreamBuilder<int>(
                                  stream: sortOption.stream,
                                  builder: (context, snapshot) {
                                    return Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: AppInitializer.sortChoicesOffers
                                          .map((e) => Padding(
                                        padding: smallPaddingAll,
                                        child: GestureDetector(
                                          onTap: () {
                                            sortOption.sink
                                                .add(
                                                AppInitializer.sortChoicesOffers
                                                    .indexOf(
                                                    e));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(AppInitializer.sortChoicesOffers[AppInitializer.sortChoicesOffers.indexOf(e)].sortOption),
                                              sortOption
                                                  .value ==
                                                  AppInitializer.sortChoicesOffers
                                                      .indexOf(
                                                      e)
                                                  ? const Icon(Icons
                                                  .radio_button_checked)
                                                  : const Icon(Icons
                                                  .circle_outlined)
                                            ],
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                    );
                                  }),
                            ),
                          )
                              : SizedBox(
                            height: 140.h,
                          );
                        }),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: bigPaddingV,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(AppLocalizations.of(context)!.negotiate_again  , style: AppStyles.baloo2FontWith500WeightAnd25Size.copyWith(color: whiteColor) ,),
                    ),
                  ),
                ],
              )*/
            }
        ),
      ),
    );
  }
}
class OfferCard extends StatelessWidget {
  final Items items;

  const OfferCard(this.items,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      margin: const EdgeInsets.symmetric(horizontal: 12 ,vertical: 8),
      decoration: BoxDecoration(
          color: whiteColor ,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0xffF2F2F2),
                offset: Offset(2,2),
                blurRadius: 3,
                spreadRadius: 2
            )
          ]
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 12 ,right: 12,top: 12,bottom: 12),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text( "${items.timeAgo.toString()} ${items.timeUnit.toString()}" , style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color:Colors.grey.shade300 ),
                            image: DecorationImage(
                              image: NetworkImage(items.image!),
                            )
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star , color: Color(0xffEB8B17),size: 16,),
                          Text(" ${items.rate}", style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack.copyWith(color: const Color(0xffD8D7D9)),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width:16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items.clinicName ?? "", style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,),
                      const SizedBox(height:2),
                      Row(
                        children: [
                          const Icon(Icons.location_pin, color: primaryColor,),
                          Text(items.distance.toString() , style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,),
                          Text(" ${items.distanceUnit}" , style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack,),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height:8),
                          Container(
                            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8)),                      alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text("${items.price} RS", style: AppStyles.baloo2FontWith400WeightAnd18SizeAndBlack.copyWith(color: whiteColor,fontSize: 14),),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width:16),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                    flex: Random(5).nextInt(10),
                    child: OffersOptionsButton(ButtonType.negotiate, AppLocalizations.of(context)!.negotiate_again)),
                const SizedBox(height: 4,),
                Expanded(
                    flex: Random(5).nextInt(10),
                    child: OffersOptionsButton(ButtonType.book, AppLocalizations.of(context)!.book)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
/*
return PagedListView<int, CategoryModel>(
                pagingController: pagingController,
                padding:
                const EdgeInsetsDirectional.only(top: 22, start: 27, end: 27),
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, CategoryModel item, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name ?? "",
                                  style: AppStyles.headlineStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: item.services!
                              .map((item) => DropdownMenuItem<Services>(
                            value: item,
                            child: RadioListTile(
                                activeColor: blackColor,
                                value: index,
                                groupValue: value,
                                onChanged: (newValue) {
                                  Navigator.pop(context);
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          AppointmentsBottomSheet(
                                            onBookRequest: (int id)async{
                                              if (id == 1 || id  == 2 ){
                                                String user = LocalStorageManager.getUser();
                                                Map<String,dynamic > result = jsonDecode(user) ;
                                                bookRequestBloc.requestBook(BookRequestModel(
                                                    serviceId: item.id!,
                                                    categoryId: item.categoryId!,
                                                    bookingTypeId: id,
                                                    userId: result["id"]
                                                ));
                                              }
                                            }, onScheduledPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (c)=>  CalenderScreen(services: item,)));
                                          },
                                          ));
                                },
                                title: Text(
                                  item.englishName!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ))
                              .toList(),
                          onChanged: (value) {},
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
                  },
                ),
              )
 */