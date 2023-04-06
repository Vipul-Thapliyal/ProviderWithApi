class AppUrl {
  static var baseUrl = "https://reqres.in"; // Base Url

  static var moviesBaseUrl = "https://reqres.in"; // Movies Base Url


  static var loginEndPoint = baseUrl + "/api/login"; // If user already have an account then Login user
  static var registerEndPoint = baseUrl + "/api/register"; // If user dont have an account then register User

  static var moviesListEndPoint = moviesBaseUrl + "/api/users?page=2";
}