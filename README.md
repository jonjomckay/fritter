<p align="center"><a href="https://fritter.cc"><img src="assets/icon.svg" width="150"></a></p> 
<h2 align="center"><b>Fritter</b></h2>
<h4 align="center">A privacy-friendly Twitter frontend for mobile devices.</h4>

<p align="center">
  <a href="https://f-droid.org/packages/com.jonjomckay.fritter/">
    <img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png"
       alt="Get it on F-Droid"
       height="80">
   </a>
   <a href="https://play.google.com/store/apps/details?id=com.jonjomckay.fritter">
     <img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" 
       alt="Get it on Google Play"
       height="80">
   </a>
</p>

<p align="center">
<a href="https://fritter.cc/releases/" alt="Release"><img src="https://img.shields.io/github/release/jonjomckay/Fritter.svg" ></a>
<a href="/LICENSE" alt="License: MIT"><img src="https://img.shields.io/badge/License-MIT-blue.svg"></a>
<a href="https://github.com/jonjomckay/fritter/actions" alt="Build Status"><img src="https://github.com/jonjomckay/fritter/workflows/ci/badge.svg?branch=master&event=push"></a>
<a href="https://hosted.weblate.org/engage/fritter/" alt="Translation Status"><img src="https://hosted.weblate.org/widgets/fritter/-/svg-badge.svg"></a>
<a href="https://oss.issuehunt.io/r/jonjomckay/fritter/" alt="Issuehunt"><img src="https://badges.aleen42.com/src/issuehunt.svg"></a>
</p>
<hr>
<p align="center"><a href="#screenshots">Screenshots</a> &bull; <a href="#features">Features</a> &bull; <a href="#installation-and-updates">Installation and updates</a> &bull; <a href="#contribution">Contribution</a> &bull; <a href="https://fritter.cc/donate">Donate</a> &bull; <a href="#license">License</a></p>
<p align="center"><a href="https://fritter.cc">Website</a> &bull; <a href="https://github.com/jonjomckay/fritter/discussions/categories/q-a">Q&A</a></p>
<hr>

## Screenshots

[<img src="https://user-images.githubusercontent.com/123662124/236850975-950f87c4-2dd1-4c9b-8ba4-1aa2d23ce98d.jpeg" width=160>](https://user-images.githubusercontent.com/123662124/236850975-950f87c4-2dd1-4c9b-8ba4-1aa2d23ce98d.jpeg)
[<img src="https://user-images.githubusercontent.com/123662124/236851092-4825b9d7-cb0b-4981-9c67-8716514f73e8.jpeg" width=160>](https://user-images.githubusercontent.com/123662124/236851092-4825b9d7-cb0b-4981-9c67-8716514f73e8.jpeg)
[<img src="https://user-images.githubusercontent.com/123662124/236851199-6a14e24e-eb1a-48a5-9e53-2247e5e4a9b7.jpeg" width=160>](https://user-images.githubusercontent.com/123662124/236851199-6a14e24e-eb1a-48a5-9e53-2247e5e4a9b7.jpeg)
[<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/shot_04.png" width=160>](fastlane/metadata/android/en-US/images/phoneScreenshots/shot_04.png)
[<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/shot_05.png" width=160>](fastlane/metadata/android/en-US/images/phoneScreenshots/shot_05.png)
[<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/shot_06.png" width=160>](fastlane/metadata/android/en-US/images/phoneScreenshots/shot_06.png)
[<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/shot_07.png" width=160>](fastlane/metadata/android/en-US/images/phoneScreenshots/shot_07.png)
[<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/shot_08.png" width=160>](fastlane/metadata/android/en-US/images/phoneScreenshots/shot_08.png)
[<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/shot_09.png" width=160>](fastlane/metadata/android/en-US/images/phoneScreenshots/shot_09.png)
[<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/shot_10.png" width=160>](fastlane/metadata/android/en-US/images/phoneScreenshots/shot_10.png)
[<img src="fastlane/metadata/android/en-US/images/tenInchScreenshots/shot_11.png" width=405>](fastlane/metadata/android/en-US/images/tenInchScreenshots/shot_11.png)
[<img src="fastlane/metadata/android/en-US/images/tenInchScreenshots/shot_12.png" width=405>](fastlane/metadata/android/en-US/images/tenInchScreenshots/shot_12.png)

### Features

* Privacy: No tracking, with all data local
* Bookmarks: Save tweets locally and offline
* Light and Dark themes: Protect your eyes
* Subscriptions: Follow and group accounts
* Polls: View results without needing to vote
* Search: Find users and tweets
* And more!

## Installation and updates
You can install Fritter using one of the following methods:
 1. Download the APK from the [website](https://fritter.cc/releases/) and install it.
 2. Update via F-Droid. This is the slowest method of getting updates, as F-Droid must recognize changes, build the APK itself, sign it, and then push the update to users.
 3. Build a debug APK yourself. This is the fastest way to get new features on your device, but is much more complicated, so we recommend using one of the other methods.

We recommend method 1 for most users. Building a debug APK using method 4 excludes a key entirely. Signing keys help ensure that a user isn't tricked into installing a malicious update to an app.

In the meanwhile, if you want to switch sources for some reason (e.g. Fritter's core functionality breaks and F-Droid doesn't have the latest update yet), we recommend following this procedure:
1. Back up your data via Settings > Data > Export so you keep your saved tweets, subscriptions, and groups
2. Uninstall Fritter
3. Download the APK from the new source and install it
4. Import the data from step 1 via Settings > Data > Import

<b>Note: when you're importing a database into the official app, always make sure that it is the one you exported _from_ the official app. If you import a database exported from an APK other than the official app, it may break things. Such an action is unsupported, and you should only do so when you're absolutely certain you know what you're doing.</b>

## Contribution
Whether you have ideas, translations, design changes, code cleaning, or even major code changes, help is always welcome. The app gets better and better with each contribution, no matter how big or small! If you'd like to get involved, check our [contribution notes](.github/CONTRIBUTING.md).

<a href="https://hosted.weblate.org/engage/fritter/">
<img src="https://hosted.weblate.org/widgets/fritter/-/287x66-grey.png" alt="Translation status" />
</a>

## Privacy Policy

The Fritter project aims to provide a private experience for Twitter. Therefore, the app does not collect any data without your consent. Fritter's privacy policy explains in detail what data is sent and stored when you send a crash report, or `Say Hello`. You can find the document [here](https://fritter.cc/privacy).

## License
[![MIT Image](https://upload.wikimedia.org/wikipedia/commons/c/c3/License_icon-mit.svg)](/LICENSE)  
