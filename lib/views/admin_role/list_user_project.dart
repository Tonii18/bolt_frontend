import 'package:bolt_frontend/config/measures/scales.dart';
import 'package:bolt_frontend/config/theme/app_colors.dart';
import 'package:bolt_frontend/services/user_service.dart';
import 'package:flutter/material.dart';

class ListUserProject extends StatefulWidget {
  const ListUserProject({super.key});

  @override
  State<ListUserProject> createState() => _ListUserProjectState();
}

class _ListUserProjectState extends State<ListUserProject> {
  late Future<List<dynamic>> _users;

  @override
  void initState() {
    super.initState();
    _users = UserService().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final size = Scales.size(context);
    final width = size.width;
    final scale = Scales.scale(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: scale * 30,
          vertical: scale * 30,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.lightBlack),
                  ),
                  Text(
                    'Añade participantes',
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 1),
              Divider(color: AppColors.lightGrey),
              SizedBox(height: scale * 15),

              Text(
                'Lista de usuarios',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontSize: scale * 20,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),

              SizedBox(height: scale * 15),

              FutureBuilder<List<dynamic>>(
                future: _users,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No users found');
                  } else {
                    final users = snapshot.data!;
                    if (users.isEmpty) {
                      return Text('No users available');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        if(user['role'] == 'ROLE_ADMIN'){
                          return SizedBox.shrink();
                        }
                        return ListTile(
                          title: Text(user['fullName'] ?? 'No Name'),
                          subtitle: Text(user['email'] ?? 'No Email'),
                          trailing: Icon(
                            Icons.add_circle_outline,
                            color: AppColors.blueWater,
                          ),
                          onTap: () {
                            // Acción al seleccionar un usuario
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
