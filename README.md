# StreamTest

Test for a Video player app

## Task

Duplicate the layout of a video streaming app and add a like button with a pulse animation.

## Architecture

The project is build using [Uber's RIBs](https://github.com/uber/RIBs) as architecture, services sturcture to load data from local JSON files and urls for images. The project requires iOS 12+

### Pods

* [Uber's RIBs](https://github.com/uber/RIBs) - Architecture
* [Lottie by AirBnB for some animations](https://airbnb.design/lottie/) - Empty view animations

## Elements

### Likes

The like button displays an animation and it takes "available likes" from an internal count of 100. You can give likes to any streamer and see how their cout goes up while your count goes down to 0.

The like count stays with the streamers and is added to the one set in the JSON file.

To reset the likes count just tap the "likes view" in the section above the video and you will get another 100 likes to give.

### Data

The video's information is real from YouTube API V3, it is stored locally to avoid issues with YT limits while testing. The chat data is the same for all videos just to serve as a placeholder.

The app includes commented out code that shows how to get the info from YI API.


### Video

The videos are loaded into a WKWebView to use their Youtube ID, there's also code to show how to load a video from the web into an AVPlayer.

### Assets

I created all icons using AfterEffects. The animations were downloaded [Lottie Files](https://lottiefiles.com) 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
