import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class RaiseDoubtScreen extends StatefulWidget {
  final String url;

  const RaiseDoubtScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<RaiseDoubtScreen> createState() => _RaiseDoubtScreenState();
}

class _RaiseDoubtScreenState extends State<RaiseDoubtScreen> {
  late FlutterWebviewPlugin _webviewPlugin;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _webviewPlugin = FlutterWebviewPlugin();
    _webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _webviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebviewScaffold(
          appBar: AppBar(title: const Text('Raise Doubt')),
          url: widget.url,
          withJavascript: true,
          withZoom: true,
          invalidUrlRegex: '^https://www.youtube.com/',
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}