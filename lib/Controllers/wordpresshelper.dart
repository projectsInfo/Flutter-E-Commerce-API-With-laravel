import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;

class WordPressHelper{
// wp.WordPress wordPress;

// adminName and adminKey is needed only for admin level APIs
  static wp.WordPress wordPress = wp.WordPress(
  baseUrl: 'https://wordpressapi.achilles-store.com/',
  authenticator: wp.WordPressAuthenticator.JWT,
  adminName: '',
  adminKey: '',
  );


  loginWordpress(String name, String password){
    Future<wp.User> response = wordPress.authenticateUser(
      username: '$name',
      password: '$password',
    );

    response.then((user) {
      loginWordpress(name , password);
    }).catchError((err) {
      print('Failed to fetch user: $err');
    });
  }

     Future<List<wp.Post>>  posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: 1,
        perPage: 20,
        order: wp.Order.desc,
        orderBy: wp.PostOrderBy.date,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
    );



}