part of 'region_bloc.dart';

abstract class RegionEvent {}

class LoadRegion extends RegionEvent {
  final String region;

  LoadRegion({required this.region});
}
