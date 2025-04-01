import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dashboard_page.dart';
import 'package:http/http.dart' as http;

class VideoRecordingPage extends StatefulWidget {
  const VideoRecordingPage({super.key});

  @override
  _VideoRecordingPageState createState() => _VideoRecordingPageState();
}

class _VideoRecordingPageState extends State<VideoRecordingPage> 
{
  CameraController? _cameraController;
  VideoPlayerController? _videoPlayerController;
  List<CameraDescription>? cameras;
  bool _isRecording = false;
  XFile? _videoFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        _cameraController =
            CameraController(cameras!.first, ResolutionPreset.medium);
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      if (_videoFile != null) {
        _videoFile = null;
        _videoPlayerController?.dispose();
        _videoPlayerController = null;
      }

      await _cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print("Error starting video recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController == null || !_cameraController!.value.isRecordingVideo)
      return;

    try {
      XFile videoFile = await _cameraController!.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _videoFile = videoFile;
        _initializeVideoPlayer();
      });
    } catch (e) {
      print("Error stopping video recording: $e");
    }
  }

  void _initializeVideoPlayer() {
    if (_videoFile == null) return;

    _videoPlayerController = VideoPlayerController.file(File(_videoFile!.path))
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.setLooping(false);
      });
  }

  void _sendVideo() async {
  if (_videoFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No video recorded!")),
    );
    return;
  }

  // Show a confirmation dialog with an option to provide a custom name
  String? customFileName = await _showFileNameDialog();

  // If the user cancels the dialog, return
  if (customFileName == null) return;

  // If the user skips, generate a random name
  if (customFileName.isEmpty) {
    customFileName = "video_${DateTime.now().millisecondsSinceEpoch}.mp4";
  }

  try {
    // Show a loading dialog while the video is being uploaded
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    // Prepare the video file for upload with the custom or random filename
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.18.64:5000/upload'),
    );

    request.files.add(await http.MultipartFile.fromPath(
      'video', // Field name
      _videoFile!.path, // File path
      filename: customFileName, // Custom or random filename
    ));

    // Send the request
    var response = await request.send();

    // Close the loading dialog
    Navigator.pop(context);

    if (response.statusCode == 200) {
      // Parse the response
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);

      if (jsonResponse['fall_detected'] == true) {
        // Show the fall detected popup
        _showFallDetectedPopup();
      } else {
        Fluttertoast.showToast(
          msg: "No fall detected.",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Failed to upload video. Status code: ${response.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  } catch (e) {
    Navigator.pop(context); // Close the loading dialog
    Fluttertoast.showToast(
      msg: "Error uploading video: $e",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}

// Add this method inside the `_VideoRecordingPageState` class
Future<String?> _showFileNameDialog() async {
  TextEditingController fileNameController = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Send Video"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Enter a name for the video file (or skip to use a random name):"),
            SizedBox(height: 10),
            TextField(
              controller: fileNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter file name (e.g., my_video.mp4)",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Skip: Return an empty string to indicate skipping
              Navigator.of(context).pop("");
            },
            child: Text("Skip"),
          ),
          TextButton(
            onPressed: () {
              // Confirm: Return the entered file name
              Navigator.of(context).pop(fileNameController.text.trim());
            },
            child: Text("Send"),
          ),
          TextButton(
            onPressed: () {
              // Cancel: Return null to cancel the upload
              Navigator.of(context).pop(null);
            },
            child: Text("Cancel"),
          ),
        ],
      );
    },
  );
}

  @override
  void dispose() {
    _cameraController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Recorder'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: _cameraController != null &&
                    _cameraController!.value.isInitialized
                ? CameraPreview(_cameraController!)
                : Center(child: CircularProgressIndicator()),
          ),
          if (_videoFile != null)
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  if (_videoPlayerController != null) {
                    _videoPlayerController!.play();
                  }
                },
                child: _videoPlayerController != null &&
                        _videoPlayerController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController!),
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSquareButton("Record", Icons.fiber_manual_record,
                  _isRecording ? null : _startRecording, Colors.green),
              _buildSquareButton("Stop", Icons.stop,
                  _isRecording ? _stopRecording : null, Colors.red),
              _buildSquareButton("Send", Icons.send, _sendVideo, Colors.blue),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSquareButton(
      String text, IconData icon, VoidCallback? onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: Colors.white),
          SizedBox(height: 5),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

void _showFallDetectedPopup() {
  // Play a sound (optional)
  // Add the `audioplayers` package to your pubspec.yaml and import it
  // dependencies:
  //   audioplayers: ^0.20.1
  // Then use the following code to play a sound:
  // final player = AudioPlayer();
  // player.play(AssetSource('fall_detected.mp3')); // Add the sound file to your assets

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text("⚠ Fall Detected"),
        content: Text("A fall has been detected. Please check immediately."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Dismiss"),
          ),
        ],
      );
    },
  );

  // Automatically close the popup after 1 minute
  Future.delayed(Duration(minutes: 1), () {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  });
}

}
