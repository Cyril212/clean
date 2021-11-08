import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/job/Contact.dart';
import 'package:clean/ui/widgets/listTiles/TwoLineListItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsModal extends StatefulWidget {
  final List<Contact> contacts;

  ContactsModal(this.contacts);

  static show(BuildContext context, List<Contact> contacts) {
    showModalBottomSheet(
        isScrollControlled: true,
        barrierColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Container(constraints: BoxConstraints(minHeight: 420), child: Material(color: Colors.transparent, child: ContactsModal(contacts)));
        });
  }

  @override
  _ContactsModalState createState() => _ContactsModalState();
}

class _ContactsModalState extends State<ContactsModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 12),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 44,
                child: Center(
                  child: Text(
                    'Kontakty',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: kColorTextPrimary),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/close.svg',
                    color: kColorSecondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: widget.contacts.map((contact) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: TwoLineListItemWidget(label: contact.name, subHeader: contact.label, value: contact.phone, onTap: () async {

                var canCall = await canLaunch('tel:${contact.formattedPhoneNumber()}');

                if(canCall){
                  launch('tel:${contact.formattedPhoneNumber()}');
                }

              },),
            )).toList(),
          ),
        ),
      ],
    );
  }
}
