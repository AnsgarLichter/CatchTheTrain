import 'package:myapp/models/models.dart';


AppTab activeTabSelector(AppState state) => state.activeTab;

bool isLoadingSelector(AppState state) => state.isLoading;