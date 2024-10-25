## Description:

A Standalone Swift & Kotlin demo application for watchOS & wearOS.

![screenshot](https://raw.githubusercontent.com/BenhurKulzer/Smartwatch-Project/refs/heads/main/server/assets/video.gif)

```(gRPC Conn - On feat/grpc branch...)```

## Lets Rock:

How to clone the repo & run the mocked server:

```
git clone https://github.com/BenhurKulzer/Smartwatch-Project.git smartwatch
cd smartwatch

cd server && node server.js
```

### Running on a wearOS device:
- Open the project `wearOS` project using Android Studio.
- Check if you have the wearOS virtual device installed in your Android Studio.

- go to `app/src/main/res/xml/network_security_config.xml` and change for your personal IP Address.

- go to `app/src/main/java/com/example/wearbear/viewmodel/LocationViewModel.kt` and change the line 46 for your personal IP Address.

- go to `/app/src/main/java/com/example/wearbear/viewmodel/SummaryViewModel.kt` and change the line 21 for your personal IP Address.


- Click on `Run` to install and run your application!

### Running on a watchOS device:
- Open the project by the `.xcodeproj` file using xCode.
- Check if you have the watchOS virtual device installed in your xCode.
- Click on `Run` to install and run your application!

### Running on a TizenOS device:
Work in progress..
