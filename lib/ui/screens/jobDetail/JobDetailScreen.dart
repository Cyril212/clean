import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/dataRequest/CompleteContractRequest.dart';
import 'package:clean/model/dataRequest/DeclineContractRequest.dart';
import 'package:clean/model/dataRequest/SignContractRequest.dart';
import 'package:clean/model/dataTask/CompleteContractDataTask.dart';
import 'package:clean/model/dataTask/DeclineContractDataTask.dart';
import 'package:clean/model/dataTask/SignContractDataTask.dart';
import 'package:clean/model/job/Job.dart';
import 'package:clean/ui/widgets/appbars/ParallaxAppBar.dart';
import 'package:clean/ui/widgets/buttons/ContainedButtonWidget.dart';
import 'package:clean/ui/widgets/buttons/OutlinedButtonWidget.dart';
import 'package:clean/ui/widgets/cards/DateCardWidget.dart';
import 'package:clean/ui/widgets/cards/NavigateCardWidget.dart';
import 'package:clean/ui/widgets/cards/TimeSpanCardWidget.dart';
import 'package:clean/ui/widgets/dialogs/DialogWidget.dart';
import 'package:clean/ui/widgets/lables/CommonLabelWidget.dart';
import 'package:clean/ui/widgets/lables/JobTypeLabelWidget.dart';
import 'package:clean/ui/widgets/lables/PlaceLabelWidget.dart';
import 'package:clean/ui/widgets/lables/StatusLabelWidget.dart';
import 'package:clean/ui/widgets/modals/CongratulationsModal.dart';
import 'package:clean/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

import '../AppScreenState.dart';

enum PlaceType { house, apartment, office }

class JobDetailScreen extends AppScreen {
  static const String ROUTE = '/job_detail';

  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends AppScreenState<JobDetailScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  CameraPosition? _cameraInitialPosition;
  LatLng? _initialPosition;

  final Set<Marker> _markers = Set();

  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _notesController = TextEditingController();
  final FocusNode _noteFocusNode = FocusNode();

  Job? _job;
  JobStatus _jobStatus = JobStatus.available;

  @override
  firstBuildOnly(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.name?.routingArguments;

    if (arguments != null) {
      _job = Job.fromJson(jsonDecode(
        arguments['job'] ?? "",
      ));
      if (_job != null) {
        _jobStatus = _job!.jobStatus;
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      }
    }
    super.firstBuildOnly(context);
  }

  @override
  void dispose() {
    _notesController.dispose();
    _noteFocusNode.dispose();
    if (_scrollController != null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  AbstractScreenStateOptions get options => AbstractScreenStateOptions.basic(screenName: 'Job detail', title: 'Job detail');

  @override
  Widget buildContent(BuildContext context) {
    if (_job == null) {
      return Container();
    }

    _cameraInitialPosition = CameraPosition(
      target: LatLng(_job!.place!.address.coordinates!.lat + 0.0064, _job!.place!.address.coordinates!.long),
      zoom: 13,
    );

    _initialPosition = LatLng(_job!.place!.address.coordinates!.lat, _job!.place!.address.coordinates!.long);

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        ParallaxAppBar(
          child: GoogleMap(
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            buildingsEnabled: false,
            scrollGesturesEnabled: false,
            markers: _markers,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _cameraInitialPosition!,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(mapStyle);
              _mapController.complete(controller);
              _createMarker();
            },
          ),
          contacts: _job!.contacts,
        ),
        SliverToBoxAdapter(
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: kJobDetailContentHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 28),
                  Text(
                    _job!.serviceName,
                    style: TextStyle(fontWeight: FontWeight.w600, color: kColorTextPrimary, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    _job!.place!.address.fullAddress,
                    style: TextStyle(fontSize: 11, color: kColorTextPrimary.withOpacity(0.7)),
                  ),
                  SizedBox(height: 27),
                  Container(
                    constraints: BoxConstraints(maxWidth: 313),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 53,
                            child: DateCardWidget(type: _jobStatus == JobStatus.completed ? CardType.complete : CardType.regular, date: _job!.startDate)),
                        Spacer(flex: 12),
                        Expanded(
                            flex: 140,
                            child: TimeSpanCardWidget(
                                type: _jobStatus == JobStatus.completed ? CardType.complete : CardType.regular,
                                startDate: _job!.startDate,
                                endDate: _job!.endDate)),
                        Spacer(flex: 12),
                        Expanded(flex: 98, child: NavigateCardWidget(_job!.place!.address)),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      PlaceLabelWidget(header: 'OBJEKT', type: _job!.place!.placeType),
                      SizedBox(width: 34),
                      JobTypeLabelWidget(
                        header: 'TYP ÚKLIDU',
                        jobType: _job!.jobType,
                      ),
                      SizedBox(width: 28),
                      StatusLabelWidget(
                        _jobStatus,
                        header: 'STAV',
                      )
                    ],
                  ),
                  SizedBox(height: 26),
                  CommonLabelWidget('POPIS'),
                  Text(
                    _job!.description,
                    style: TextStyle(color: kColorTextPrimary.withOpacity(0.8), fontSize: 13, height: 1.44),
                  ),
                  SizedBox(height: 24),
                  if (_jobStatus == JobStatus.confirmed || _jobStatus == JobStatus.inProgress || _jobStatus == JobStatus.completed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonLabelWidget('Nahlásit problém'),
                          Form(
                            key: _formKey,
                            child: TextFormFieldWidget(
                              controller: _notesController,
                              focusNode: _noteFocusNode,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (String string) {
                                print("it works");
                              },
                              lines: 2,
                              enabled: _jobStatus != JobStatus.completed,
                              style: kTextFormFieldStyle.copyWith(
                                errorColor: _jobStatus == JobStatus.completed ? Color(0x95AAB9D1) : kColorRed,
                                inputDecoration: kInputDecoration.copyWith(
                                  hintText: _jobStatus != JobStatus.completed
                                      ? 'Pokud jste omylem něco zničili nebo jste si všimli, že je něco rozbité, napište to sem...'
                                      : '',
                                  contentPadding: EdgeInsets.only(
                                    top: 12,
                                    left: 12,
                                    right: 12,
                                    bottom: 12,
                                  ),
                                ),
                              ),
                              validations: [
                                // FormFieldValidation(
                                //     validator: validateRequired, errorText: _jobStatus == JobStatus.completed ? '' : 'Describe reason to decline.',
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: kJobDetailContentHorizontalPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_jobStatus == JobStatus.available)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ContainedButtonWidget(
                        text: 'Potvrdit úklid',
                        prefixIconSvgAssetPath: 'assets/icons/icon_check.svg',
                        onTap: () {
                          _acceptJob(context);
                        },
                        tag: 'accept',
                      ),
                    ),
                  if (_jobStatus == JobStatus.inProgress)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ContainedButtonWidget(
                        text: 'Potvrdit úklid',
                        prefixIconSvgAssetPath: 'assets/icons/icon_check.svg',
                        onTap: () {
                          _completeJob(context);
                        },
                        tag: 'complete',
                      ),
                    ),
                  if (_jobStatus != JobStatus.completed)
                    OutlinedButtonWidget(
                      text: 'Nemohu přijít',
                      prefixIconSvgAssetPath: 'assets/icons/icon_close.svg',
                      onTap: () {
                        _declineJob(context);
                      },
                      tag: 'decline',
                    ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _createMarker() async {
    final Uint8List markerIcon = await Utils.getBytesFromCanvas(90, 140, "assets/icons/map_marker.png");

    final marker = Marker(markerId: MarkerId("marker_1"), position: _initialPosition!, icon: BitmapDescriptor.fromBytes(markerIcon));

    setStateNotDisposed(() {
      _markers.add(marker);
    });
  }

  _acceptJob(BuildContext context) {
    executeAsyncTask(
        () => MainDataProvider.instance!.executeDataTask(SignContractDataTask(data: SignContractRequest(userId: 1, jobId: _job!.id!))).then((task) {
              if (task.result != null) {
                setStateNotDisposed(() {
                  //jobStatus = JobStatus.confirmed;
                  ///we skip confirmed job step so we can finish flow
                  _jobStatus = JobStatus.inProgress;
                });
              } else {
                Utils.showDefaultError(context, task.error!.httpStatusCode!);
              }
            }),
        tag: 'accept');
  }

  _declineJob(BuildContext context) {
    if (_jobStatus == JobStatus.available) {
      _showDeclineJobDialog();
    } else {
      if (_formKey.currentState!.validate()) {
        _showDeclineJobDialog();
      } else {
        showDialog(
          context: context,
          builder: (context) => DialogWidget(
            title: 'Describe reason',
            description: 'To decline this job, describe the reason in the note section.',
            primaryButtonLabel: 'OK',
          ),
        );
      }
    }
  }

  _showDeclineJobDialog() {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: 'Potvrzení',
        description: 'Opravdu chcete tuto práci odmítnout?',
        primaryButtonLabel: 'Ano',
        primaryAction: () {
          popNotDisposed(context, mounted, true);
        },
        secondaryButtonLabel: 'Ne',
        secondaryAction: () {
          popNotDisposed(context, mounted);
        },
      ),
    ).then((value) {
      if (value) {
        executeAsyncTask(
            () => MainDataProvider.instance!
                .executeDataTask(DeclineContractDataTask(data: DeclineContractRequest(userId: 5, jobId: 1, note: _notesController.text)))
                .then((task) => {
                      if (task.result != null) {popNotDisposed(context, mounted)} else {Utils.showDefaultError(context, task.error!.httpStatusCode!)}
                    }),
            tag: 'decline');
      }
    });
  }

  _completeJob(BuildContext context) {
    _noteFocusNode.unfocus();
    executeAsyncTask(
        () => MainDataProvider.instance!.executeDataTask(CompleteContractDataTask(data: CompleteContractRequest(userId: 5, jobId: 1))).then((task) {
              if (task.result != null) {
                setStateNotDisposed(() {
                  _jobStatus = JobStatus.completed;
                });
                CongratulationsModal.show(context);
              } else {
                Utils.showDefaultError(context, task.error!.httpStatusCode!);
              }
            }),
        tag: 'complete');
  }

  String mapStyle = json.encode([
    {
      "elementType": "geometry",
      "stylers": [
        {"color": "#f5f5f5"}
      ]
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {"visibility": "off"}
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#616161"}
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {"color": "#f5f5f5"}
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#bdbdbd"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
        {"color": "#eeeeee"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#757575"}
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {"color": "#e5e5e5"}
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#9e9e9e"}
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {"color": "#ffffff"}
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#757575"}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {"color": "#dadada"}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#616161"}
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#9e9e9e"}
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [
        {"color": "#e5e5e5"}
      ]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [
        {"color": "#eeeeee"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {"color": "#c9c9c9"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#9e9e9e"}
      ]
    }
  ]);

  @override
  PreferredSizeWidget? createAppBar(BuildContext context) {}
}
