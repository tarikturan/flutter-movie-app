import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_casts_bloc.dart';
import 'package:movieapp/model/cast.dart';
import 'package:movieapp/model/cast_response.dart';
import 'package:movieapp/style/theme.dart' as Style;

class Casts extends StatefulWidget {
  final int id;
  Casts({Key key, @required this.id}) : super(key: key);

  @override
  _CastsState createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;
  _CastsState(this.id);
  @override
  void initState() {
    super.initState();
    castBloc.getCasts(id);
  }

  @override
  void dispose() {
    super.dispose();
    castBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "KADRO",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<CastResponse>(
          stream: castBloc.subject.stream,
          builder: (context, AsyncSnapshot<CastResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildCastsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(Style.Colors.secondColor),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildCastsWidget(CastResponse data) {
    List<Cast> casts = data.casts;
    return Container(
      height: 140.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10.0, right: 8.0),
            width: 100.0,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: casts[index].img != null
                                ? NetworkImage(
                                    "https://image.tmdb.org/t/p/w300/${casts[index].img}")
                                : NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    casts[index].name,
                    maxLines: 2,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(casts[index].character,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 7.0,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
