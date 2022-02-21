# TheFirstProject : A different Learning Management System

## Team :

- [Asim Ayman](https://www.github.com/asimayman)
- [Kareem Ahmed](https://www.github.com/kareemahmed22)
- [Mariam Youssef](https://www.github.com/mariamyoussefwiliam)
- [Mirette Atef](https://www.github.com/mirette3)
- [Ahmed Emad](https://www.github.com/omda07)
- [Youssef El Gebaly](https://www.github.com/youssefelgebaly)


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# About LMS 
E-learning application that allows the learner to participate in multiple courses and tracks that provide communication between the learner and the author
# Getting started
Rerequisites:
- [Git]() 
- [Flutter SDK ](https://docs.flutter.dev/get-started/install)
- [Android Studio IDE](https://developer.android.com/studio?gclid=EAIaIQobChMIkfj3ttT89QIVh9V3Ch2IdgxkEAAYASAAEgI_7_D_BwE&gclsrc=aw.ds)
  - Java-home 
- [Npm](https://www.npmjs.com/)
- [Node JS](https://nodejs.org/en/)
- [MongoDB](https://www.mongodb.com/cloud/atlas/lp/try2?utm_content=rlsavisitor&utm_source=google&utm_campaign=gs_emea_rlsamulti_search_core_brand_atlas_desktop_rlsa&utm_term=mongodb&utm_medium=cpc_paid_search&utm_ad=e&utm_ad_campaign_id=14412646455&adgroup=131761126492&gclid=EAIaIQobChMI7_6M4dP89QIVj-J3Ch0KAQWuEAAYASAAEgKETvD_BwE)
- [Visual studio code IDE](https://code.visualstudio.com/docs/?dv=linux64_deb)


# How To Work 
1- Go to your local workspace directory 
```sh
$ cd ~/workspace
```
2-Clone your project to your device.
```sh
$ git clone https://github.com/omarokasha1/TheFirstProject.git
```
3- Next, go into the just created directory.
```sh
$ cd TheFirstProject-master/
```
## Import project to the Android Studio IDE
1. Open Android Studio IDE.
- `File` → `Open` → `Choosing the project from the device` 
2. Click project to import to Android Studio
3. Add flutter SDK for the project 
 - `File` → `settings` → `Languages & Frameworks` → `Flutter`→ `Add SDK file`  
4. Adding a package dependency to an app
 ```sh
$ flutter pub get  
```
5. Run Flutter in  emulator
```sh
$ flutter run
```
## Import Backend project to Visual studio code IDE
1. Open Visual studio code IDE.
- `File` → `Open` → `Choosing the project from the device` 
2. Click project to import to  Visual studio code

#### Run the project on a local Server
In the command line, run cd  to change directories to the folder we just cloned from GitHub.
```sh
$ cd ~/workspace
```
- add those lines in `package.js` file
```sh
 "scripts": {
    "start": "nodemon server.js"
  },
```
run npm start which will start the local server.
```sh
$ npm start
```
# License
- Open-source software
