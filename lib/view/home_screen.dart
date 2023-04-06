import 'package:flutter/material.dart';
import 'package:mvvm_tech_brothers/data/response/status.dart';
import 'package:mvvm_tech_brothers/model/movies_model.dart';
import 'package:mvvm_tech_brothers/utils/routes/routes_name.dart';
import 'package:mvvm_tech_brothers/view_model/home_view_model.dart';
import 'package:mvvm_tech_brothers/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(

              onTap: () {
                userPreference.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: Center(child: Text("Logout"))
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, _) {
            switch(value.moviesList.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());

              case Status.ERROR:
                return Center(child: Text(value.moviesList.message.toString()));

              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.moviesList.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Text(value.moviesList.data!.data![index].id.toString()),
                        title: Text(value.moviesList.data!.data![index].firstName.toString()),
                        subtitle: Text(value.moviesList.data!.data![index].lastName.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            Text("233"),
                            Icon(Icons.star),
                          ],
                        ),
                      ),
                    );
                  }
                );
            }
            return Container();
          }
        )
      ),
    );
  }
}
