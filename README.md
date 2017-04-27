# TGFramework-iOS
Purpose of TGFramework is to provide developer friendly library, that can help to improve feature development rather focusing on common structure creation during every mobile app development.

## How to use library?
##### Install using CocoaPods
```
pod 'TGFramework'
```

## Areas where TGFramework may help


### TGSession
Single Session instance in memory to hold values in memory as Key-Value pair. No need to inherit or initialize anything.

##### Where to use:
- Whenever data is common accross multiple activities.
- Managing data in local storage option (like in local database, user default or in disk), when actually data become invalid after app close.

##### TGSessionListener:
Just make any class as Session listener by implementing TGSessionListener. And get the ability to perfrom any post action when any key has been put in session, removed from session or even session become invalidated.

##### Where NOT to use TGSession:
TGSession holds data in app memory (RAM) so whenever it required data to be stored beyond user's app usage. Please consider to store it in local database or shared preference. One can reload in TGSession again when app starts again.


### TGRequest & TGResponse {Comming Soon}
TGFramework gives mechanism to use HTTP Request & Response like an ORM which facilitates various response conversion inbuilt. (Like, JSon response to object)

### TGService {Coming Soon}
Service wrapper class to facilitate all the service/network related calls.
```
public static void performJsonRequest (TGJsonRequest<?> request)
public static void performStringRequest (TGStringRequest<?> request)
public static void performImageRequest (TGImageRequest request)
public static void cancelRequest (TGRequest request)
public static void cancelRequestByTag (Object tag)
public static void startRequests()
public static void stopRequests()
public static void loadImage (String imageUrl, ImageView imageView)
public static void loadImage (String imageUrl, ImageView imageView, int defaultImageId, int errorImageId)
```

### TGUtil
Utility methods which are independent.
```
// Parse Date from String

// Format Date into String

// Current Date and/or Time in String format

// Convert JSon string into Object

// Convert Object into JSon string or even Map object of key value pair by attributes

// Read File

// Random Unique ID Generation

// Check Internet network available

// Serialize & Deserialize any object to & from String

// Conversion between Bitmap to-from Byte array

// Check for phone vs ipad

```

### TGUserDefaults {Coming Soon}
Wrapper class of User Defaults.


### TGLocationManager {Coming Soon}
Custom location manager class to capture current location with accuracy and timeout settings.
```
Implementation...
```

### Example App
Code base already has example "TGFrameworkExample" in parallel to library, which shows how to use all TG components.


### Anything to say?
Any suggestions or recommendations are most welcome.
> Please email me on vishal@techgrains.com with subject "TGFramework" for easier reference and to have in proper mailbox folder. Thanks in advance!


## License
#### Copyright 2017 Techgrains Technologies

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
