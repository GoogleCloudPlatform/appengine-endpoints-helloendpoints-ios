appengine-endpoints-helloworld-ios
=================================

This application is a HelloWorld iOS sample application that connects to a 
HelloWorld Google Cloud Endpoints backend sample.

It relies on a copy of the [Google APIs Client Library for Objective-C][1].

This example also uses ARC. If your application uses ARC you must set the
-fno-objc-arc for the files included in the client library; see the [client
library project ARC notes][8].

## Products
- [App Engine][2]
- [iOS][3]

## Language
- [Objective-C][4]

## APIs
- [Google Cloud Endpoints][5]

## Setup Instructions
1. Clone this git repo locally.
`git clone git@github.com:GoogleCloudPlatform/appengine-endpoints-helloendpoints-ios.git`
1. [Clone a Hello Endpoints Backend sample locally and BUILD it][7]. These
instructions will assume the project was downloaded to
`~/appengine-endpoints-helloendpoints-java-maven` and `mvn clean install` was
used to build.
1. Pull down the Google Client Library Objective-C client library to a subdirectory.
`cd appengine-endpints-helloendpoints-ios/Hello\ Endpoints/`
`svn checkout http://google-api-objectivec-client.googlecode.com/svn/trunk/ google-api-objectivec-client-read-only`
1. Build the ServiceGenerator to generate an Objective-C client library.
`open google-api-objectviec-client-read-only/Source/Tools/ServiceGenerator/ServiceGenerator.xcodeproj`
Hit the play button to build the project. 
1. Generate your custom service files to work with the Google Client Library.
    1. Find the ServiceGenerator binary by opening Project Navigator > Products > ServiceGeneator then copying the location from the inspector on the right side of Xcode. It will typically be something like this:
`/Users/<your_user_id>/Library/Developer/Xcode/DerivedData/ServiceGenerator-<random-guid>/Build/Products/Debug/ServiceGenerator`
    1. Run the ServiceGenerator on your discovery document.
`/Users/<your_user_id>/Library/Developer/Xcode/DerivedData/ServiceGenerator-<random-guid>/Build/Products/Debug/ServiceGenerator \
    ~/appengine-endpoints-helloendpoints-java-maven/target/helloendpoints-1.0-SNAPSHOT/WEB-INF/helloworld-v1-rpc.discovery \
    --outputDir ./API`
1. Open the Project in Xcode
`open Hello\ Endpoints/Hello\ Endpoints.xcodeproj`
1. Build project by hitting the play button in the top left-hand corner.

2. Modify `kMyClientId` and `kMyClientSecret` in `ViewController.m` to include
   the web client ID and client secret you registered in the [APIs Console][6].
3. Modify `GTLServiceHelloworld.m` (line 44) to point to the location where you
   are hosting a Helloworld backend.
4. Run the application.


[1]: http://code.google.com/p/google-api-objectivec-client/
[2]: https://developers.google.com/appengine
[3]: https://developer.apple.com/technologies/ios/
[4]: http://en.wikipedia.org/wiki/Objective-C
[5]: https://developers.google.com/appengine/docs/java/endpoints/
[6]: https://code.google.com/apis/console
[7]: https://github.com/GoogleCloudPlatform/appengine-endpoints-helloendpoints-java-maven
[8]: https://code.google.com/p/google-api-objectivec-client/wiki/BuildingTheLibrary#ARC_Compatibility
