import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/network_inspector_enum.dart';
import '../../domain/entities/http_activity.dart';
import '../../network_inspector_presentation.dart';
import '../widgets/titled_label.dart';
import 'http_request_page.dart';
import 'http_response_page.dart';

class ActivityDetailPage extends StatelessWidget {
  final HttpActivity httpActivity;
  const ActivityDetailPage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityDetailProvider>(
      create: (context) => ActivityDetailProvider(
        httpActivity: httpActivity,
        context: context,
      ),
      builder: (context, child) {
        final provider = context.read<ActivityDetailProvider>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Http Activity'),
            actions: [
              IconButton(
                onPressed: () {
                  provider.buildJson(
                    provider.shareHttpActivity,
                    HttpActivityActionType.share,
                  );
                },
                icon: const Icon(
                  Icons.share,
                ),
              ),
              IconButton(
                onPressed: () {
                  provider.buildJson(
                    provider.copyHttpActivity,
                    HttpActivityActionType.copy,
                  );
                },
                icon: const Icon(
                  Icons.copy,
                ),
              ),
            ],
          ),
          body: buildBody(context),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyHeader(context),
          bodyContent(context),
        ],
      ),
    );
  }

  Widget bodyHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitledLabel(
                title: 'Url',
                text: httpActivity.request?.baseUrl,
              ),
              const SizedBox(height: 8),
              TitledLabel(
                title: 'Path',
                text: httpActivity.request?.path,
              ),
            ],
          ),
        ),
        TabBar(
          labelStyle: Theme.of(context).textTheme.button,
          labelColor: Colors.black,
          indicatorColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              child: Text('Request'),
            ),
            Tab(
              child: Text('Response'),
            ),
          ],
        ),
      ],
    );
  }

  Widget bodyContent(BuildContext context) {
    return Expanded(
      child: Consumer<ActivityDetailProvider>(
        builder: (context, provider, child) => TabBarView(
          children: [
            HttpRequestPage(
              httpActivity: httpActivity,
            ),
            HttpResponsePage(
              httpActivity: httpActivity,
            ),
          ],
        ),
      ),
    );
  }
}
