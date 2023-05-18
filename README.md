# weather_app

This is a one page Weather update Application.
This app will wants to know your current location and 
give you the weather update from your current location.
The all data comes from API.
You can also see the previous weather update history.

This application is for Android and iOS.

## Commands:

project create: flutter create -t skeleton -a java -i swift --org com.meraj project_app
clear the codebase: flutter clean
getting all: glutter pub get

This project is running on latest flutter version 3.10.1

## Project Structure
lib
-> src
  -> constsnts
  -> db
  -> localization
  -> modules
    -> home
      -> api
        -> weather.api.dart
      -> componets
        -> weather.item.dart
      -> function
        -> location.function.dart
      -> model
      -> provider
      -> view
        -> home.view.dart
    -> router
    -> setting
  -> theme
  -> utils
  -> app.dart
  
-> main.dart
