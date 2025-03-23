# Assignment 1: Design only the Homescreen of this figma design-
https://www.figma.com/design/nWTUc8uLkCY4gPp393ET24/UIP-TV?node-id=0-1&p=f&t=DMdZDJZErAKkOPPm-0


# Flutter API & Hive App
This Flutter app fetches data from a public API and displays it using a list view. It also supports offline capabilities, where the fetched data is cached using Hive, and will be shown even if there is no internet connection.
Steps to Build the App
# 1. Setting Up the Flutter Project
We started by creating a new Flutter project using the command:
flutter create task_app
cd task_app
Then, we updated the pubspec.yaml file to include dependencies for:

Hive: For local storage to cache data.

Hive_flutter: To integrate Hive with Flutter.

Provider: To manage app state.

http: To make network requests and fetch data from an API.
# 2. Setting Up Hive for Local Storage
Next, we set up Hive for local storage. We used Hive to save the fetched API data locally, so the app can display it even when there's no internet.

We first initialized Hive in the main.dart file by calling Hive.initFlutter() and opened a box to store the data.

We defined a PostModel class, which was used to represent the data fetched from the API. This class was registered with Hive as an adapter.
# 3. State Management with Provider
We used Provider to manage the state of the app. The PostProvider class is responsible for:

Fetching data from the API.

Caching the data in Hive.

Managing the loading state and error states.

In the PostProvider, we defined methods like fetchPosts() for fetching data from the API, refreshPosts() for refreshing the data, and logic to check if the data is available in Hive when the app is offline.

Here’s how we registered the Hive adapter:

await Hive.initFlutter();
Hive.registerAdapter(PostModelAdapter());
await Hive.openBox('postsBox');
# 4. User Interface (UI)
The UI of the app consists of:

A RefreshIndicator: This allows users to pull down to refresh the data. It triggers the fetchPosts method to refresh the data.

A ListView: This is used to display the list of posts fetched from the API.

A FloatingActionButton: This button is used to manually trigger a refresh to fetch the latest data.
# 5. Offline Capability with Hive
To handle offline capabilities:

We saved the fetched data in Hive whenever the app has internet access. This data is then retrieved from Hive when the app is offline.

The refreshPosts method checks whether the app is connected to the internet. If it is, it fetches new data from the API and saves it to Hive. If the app is offline, it uses the data already cached in Hive.
## Features:
Fetch data from a public API (https://jsonplaceholder.typicode.com/posts).

Store fetched data in Hive for offline usage.

Display a loading spinner while fetching data.

Show cached data when the app is offline.

Implement refresh functionality using RefreshIndicator.

State management using Provider.

# ApK file
https://drive.google.com/file/d/1jQP6WXqHqqBnv16BehOn_5VbGeDhLMoE/view?usp=sharing
