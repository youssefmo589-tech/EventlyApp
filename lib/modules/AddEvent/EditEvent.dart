import 'package:eventlyapp/core/services/snackBarServices.dart';
import 'package:eventlyapp/core/utilities/Widgets/AppButton.dart';
import 'package:eventlyapp/modules/AddEvent/EventData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../category data source/CategoryDataSource.dart';
import '../../core/provider/settingsProvider.dart';
import '../../core/themes/AppColors.dart';
import '../../core/utiles/firebasecloudservice.dart';
import '../../core/utilities/Widgets/Field.dart';
import '../../core/utilities/Widgets/SelectionDateTime.dart';
import '../Home/TabBarItem.dart';

class EditEvent extends StatefulWidget {
  final EventData event;

  const EditEvent({super.key, required this.event});

  State<EditEvent> createState() {
    return _EditeventState();
  }
}

class _EditeventState extends State<EditEvent> {
  final titlecontroller = TextEditingController();

  final descreptioncontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  TimeOfDay ? _selectedTime;


  DateTime? _selecteddatetime;

  int _selectedindex = 0;

  void initState() {
    super.initState();
    titlecontroller.text = widget.event.title;
    descreptioncontroller.text = widget.event.descreption;
    _selecteddatetime = widget.event.selecteddatetime;
    _selectedTime = widget.event.selectedtime;
  }

  Widget build(BuildContext context) {
    // final event =
    // ModalRoute.of(context)?.settings.arguments as EventData ;
    final provider = Provider.of<settingProvider>(context);
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 65,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(
                  color: provider.isDark()
                      ? AppColors.primaryLight
                      : AppColors.lightgray,
                ),
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark()
                    ? AppColors.backgrounddark
                    : AppColors.white,
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: provider.isDark()
                        ? AppColors.white
                        : AppColors.primaryLight,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Edit event",
          style: theme.titleMedium?.copyWith(
            color: provider.isDark() ? AppColors.white : AppColors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 193,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: provider.isDark()
                          ? AppColors.darkblue
                          : AppColors.lightgray,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        provider.isDark()
                            ? CategoryDataSource
                                  .Categories[_selectedindex]
                                  .darkimage
                            : CategoryDataSource
                                  .Categories[_selectedindex]
                                  .image,
                      ),
                    ),
                  ),
                ),
                DefaultTabController(
                  length: CategoryDataSource.Categories.length,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        _selectedindex = index;
                      });
                    },
                    isScrollable: true,
                    indicator: BoxDecoration(),
                    dividerHeight: 0,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    tabs: CategoryDataSource.Categories.map(
                      (item) => TabBarItem(
                        item: item,
                        isselected:
                            _selectedindex ==
                                CategoryDataSource.Categories.indexOf(item)
                            ? true
                            : false,
                      ),
                    ).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: theme.titleMedium?.copyWith(
                            color: provider.isDark()
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        CustomeField(
                          hinttext: 'Event Title',
                          controller: titlecontroller,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter title";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description ",
                        style: theme.titleMedium?.copyWith(
                          color: provider.isDark()
                              ? AppColors.white
                              : AppColors.black,
                          fontSize: 16,
                        ),
                      ),
                      CustomeField(
                        hinttext: 'Event Description....',
                        maxlines: 5,
                        controller: descreptioncontroller,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter description";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SelectionDateTime(
                  onTap: () {
                    _selecteEventDate(context);
                  },
                  selecteddatetime: _selecteddatetime,
                  timebehav: _selectTime,
                  selectedtime: _selectedTime,

                ),
              ],
            ),
          ),

          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              text: "Update event",
              ontap: () async {
                widget.event.selectedtime = _selectedTime;
                widget.event.title = titlecontroller.text;
                widget.event.descreption = descreptioncontroller.text;
                widget.event.selecteddatetime = _selecteddatetime;
                widget.event.categoryId =
                    CategoryDataSource.Categories[_selectedindex].id;
                if (_formkey.currentState!.validate()) {
                  if (_selecteddatetime != null) {
                    bool isupdated = await FirebaseCloudService.update(
                      widget.event,
                    );
                    EasyLoading.show();
                    if (isupdated) {
                      Navigator.pop(context);
                      AppSnackBar.success("updated successed");
                      EasyLoading.dismiss();
                    } else {
                      AppSnackBar.error("updated failed");
                      EasyLoading.dismiss();
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selecteEventDate(BuildContext context) async {
    _selecteddatetime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {});
  }

  void _selectTime(BuildContext context) async
  {
    _selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    setState(() {

    });
  }
}
