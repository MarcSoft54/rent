
import'package:go_router/go_router.dart';

import '../acceuil.dart';
import '../initial.dart';
import '../login.dart';
import '../main.dart';
import '../profit/editProfile.dart';
import '../profit/uploadArticle.dart';
import '../signIn.dart';
import '../view/profit.dart';


final GoRouter router = GoRouter(
  // initialLocation: "/home/:id",
    routes: [
      GoRoute(
          path: "/home/:id",
          builder: ((context, state)=> Home(
            id: state.pathParameters['id'],
          ))
      ),
      GoRoute(
          path: "/profit/:id",
          builder: ((context, state)=> Profit(
            id: state.pathParameters["id"],
          ))
      ),
      GoRoute(
          path: "/login",
          builder: ((context, state)=>const Log())
      ),
      GoRoute(
          path: "/sign_in",
          builder: ((context, state)=> Sign())
      ),
      GoRoute(
          path: "/upload/:id",
          builder: ((context, state)=> UploadFile(
            id: state.pathParameters["id"],
          ))
      ),
      GoRoute(
          path: "/first",
          builder: ((context, state)=> const MyApp())
      ),
      GoRoute(
          path: "/",
          builder: ((context, state)=> const Init())
      ),
      GoRoute(
          path: "/edit_profile/:id",
          builder: ((context, state)=> EditProfil(
              id: state.pathParameters["id"]))
      )

    ]);

