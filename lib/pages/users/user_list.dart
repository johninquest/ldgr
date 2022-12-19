import 'package:flutter/material.dart';
import '../../firebase/firestore.dart';
import '../../services/preprocessor.dart';
import '../../services/router.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../shared/snackbar_messages.dart';
import '../../shared/custom_widgets.dart';
import '../../styles/colors.dart';
import 'add_user.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _fsQuery =
        FirestoreService().getSubCollectionBasic('users', 'user_list');
    return Scaffold(
      appBar: AppBar(
        title: Text('User list'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fsQuery,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              List resData = snapshot.data as List;
              return TableOfUsers(userList: resData);
            } else {
              return WaitingForResponse();
            }
          }),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: Tooltip(
          message: 'Add new user',
          child: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: myTeal,
              size: 40.0,
            ),
            onPressed: () =>
                PageRouter().navigateToPage(AddUserPage(), context),
          )),
    );
  }
}

class TableOfUsers extends StatefulWidget {
  final List userList;
  const TableOfUsers({Key? key, required this.userList}) : super(key: key);

  @override
  State<TableOfUsers> createState() => _TableOfUsersState();
}

class _TableOfUsersState extends State<TableOfUsers> {
  @override
  Widget build(BuildContext context) {
    List itemsInUserList = widget.userList;
    return ListView.builder(
        itemCount: itemsInUserList.length,
        itemBuilder: (context, index) {
          String _userId = itemsInUserList[index]['user_id'] ?? '';
          String _userName = itemsInUserList[index]['name'] ?? '';
          String _userRole = itemsInUserList[index]['role'] ?? '';
          return Card(
            child: ExpansionTile(
              initiallyExpanded: false,
              leading: Text(
                _userName,
                style: TextStyle(fontWeight: FontWeight.bold, color: myBlue),
              ),
              title: Text(
                '',
              ),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
                  padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                      ),
                      Text(
                        _userName,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
                  padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'UserId',
                      ),
                      Text(
                        _userId,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  margin: EdgeInsets.only(top: 1.0, bottom: 2.0),
                  padding: EdgeInsets.only(top: 1.0, bottom: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Role',
                      ),
                      Text(
                        Capitalize().word(_userRole),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: showDelete(_userRole),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (_) => _deleteDialog(_userId, _userName)),
                      child: Text('DELETE'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myRed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _deleteDialog(String userLoginId, String userName) {
    return AlertDialog(
      title: Icon(
        Icons.warning,
        color: myRed,
        size: 40.0,
      ),
      content: Text(
        'Delete ? \n"$userName"',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: myBlue, fontSize: 20.0),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'NO',
                style: TextStyle(color: myRed, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
                onPressed: () {
                  FirestoreService().removeAppUser(userLoginId).then((val) {
                    SnackBarMessage().customSuccessMessage(
                        'Deleted "$userName" successfully \u{2713}', context);
                    PageRouter().navigateToPage(UserListPage(), context);
                  }).catchError(
                      (e) => SnackBarMessage().generalErrorMessage(context));
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: myGreen, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

showDelete(String role) {
  if (role == 'employee') {
    return true;
  } else {
    return false;
  }
}
