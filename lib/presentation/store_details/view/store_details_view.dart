import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:advanced_flutter_arabic/presentation/store_details/view_model/store_details_view_model.dart';
import 'package:flutter/material.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.white),
        title: Text(
          AppStrings.storeDetails,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                      () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget();
            },
          ),
        ),
      ),
    );

  }

  Widget _getContentWidget() {
    return StreamBuilder(
      stream: _viewModel.outputStoreDetails,
      builder: (context, snapshot){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getBannerWidget(),
            _getSection(AppStrings.details),
            _getText(snapshot.data?.details),
            _getSection(AppStrings.services),
            _getText(snapshot.data?.services),
            _getSection(AppStrings.aboutStore),
            _getText(snapshot.data?.about),
          ],
        );
      },
    );
  }

  Widget _getBannerWidget() {
    return StreamBuilder<StoreDetails>(
        stream: _viewModel.outputStoreDetails,
        builder: (context, snapShot) {
          return _getBannerImage(snapShot.data?.image);
        });
  }

  Widget _getBannerImage(String? image) {
    if (image != null) {
      return SizedBox(
        width: double.infinity,
        child: Card(
          elevation: AppSize.s1_5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
              side: BorderSide(
                  color: ColorManager.primary, width: AppSize.s1)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s12),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(title, style: Theme.of(context).textTheme.displayMedium),
    );
  }

  Widget _getText(String? text) {
    if(text != null){
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12,
            right: AppPadding.p12,
            top: AppPadding.p12,
            bottom: AppPadding.p2),
        child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
      );
    } else{
      return Container();
    }

  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
