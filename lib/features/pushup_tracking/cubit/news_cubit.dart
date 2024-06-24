import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/provider/data_for_day.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  Future<void> getNews(int day) async {
    emit(NewsFetching());

    emit(
      NewsLoaded([...getNewsForDay(day)]),
    );
  }
}
