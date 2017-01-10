# RappiTest-iOS-Cocoapods

This is an application for test purposes. The app have three views:

- The first view contains a list of five categories of iOS application togheter with ten applications for each category. This view is named "Categories".
- The second view is shown from the categories view when user tap "See All Apps" button. This view will present all applications for the selected category. This view is named "Apps".
- A third view is show when user tap on any application from both views "Categories" or "Apps". This view show the summary of the selected application.

All code generated in this app was written by Mario Villamizar Palacio. All code and documentation was written in English.

# Design Requeriments

- [x] The app works in Portrait for iPhone and Landscape for iPad.
- [x] The app can work offline if the data was previously fetched. Notifications are shown for Reachability.
- [x] Apps view is presented as table view for iPhone and collection view for iPad.
- [x] Some animation were added.

# Run Requeriments

- [x] Xcode 7.3.1
- [x] Swift 2.3
- [x] Cocoapods

# About Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

This proccess could take some minutes. Then, to run this project you must execute the following command:


```bash
$ cd ~/Path/To/Folder/Containing/theproject
```


Then, run the following command:

```bash
$ pod install
```

Now you can run the project.

# Helper Libraries

Some libraries with proven functionality are used in the project:

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
- [SDWebImage](https://github.com/rs/SDWebImage)
- [Reachability](https://github.com/tonymillion/Reachability)
- [JFMinimalNotifications](https://github.com/atljeremy/JFMinimalNotifications)
