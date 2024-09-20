import 'package:flutter/cupertino.dart';
import 'package:to_do_app/core/assets/styles.dart';
import 'package:to_do_app/feature/task/presentation/views/widgets/task_home_widget/tabbar_widget.dart';

class TaskHomeBody extends StatelessWidget {
  const TaskHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text("My Tasks",style: Styles.text9,),
             SizedBox(height: 10,),
             TabbarWidget()
           ],
      ),
    );
  }
}
