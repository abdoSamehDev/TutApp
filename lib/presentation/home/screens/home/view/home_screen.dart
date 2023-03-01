import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/home/screens/home/view_model/home_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

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
    return Center(
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
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStores(),
      ],
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<HomeObject>(
        stream: _viewModel.outputHomeObject,
        builder: (context, snapShot) {
          return _getBannerWidget(snapShot.data?.data?.banners);
        });
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
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
                          banner.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: AppSize.s190,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
          ));
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
      child: Text(title, style: Theme.of(context).textTheme.titleSmall),
    );
  }

  Widget _getServices() {
    return StreamBuilder<HomeObject>(
        stream: _viewModel.outputHomeObject,
        builder: (context, snapShot) {
          return _getServiceWidget(snapShot.data?.data?.services);
        });
  }

  Widget _getServiceWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        child: Container(
          height: AppSize.s160,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                          color: ColorManager.white,
                          width: AppSize.s1,
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              child: Image.network(
                                service.image,
                                fit: BoxFit.cover,
                                width: AppSize.s120,
                                height: AppSize.s120,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  service.title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores() {
    return StreamBuilder<HomeObject>(
        stream: _viewModel.outputHomeObject,
        builder: (context, snapShot) {
          return _getStoreWidget(snapShot.data?.data?.stores);
        });
  }

  Widget _getStoreWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2.toInt(),
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    //navigate to store details screen
                    Navigator.pushNamed(context, Routes.storeDetailsRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
