import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool smallText;

  const DetailCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.iconColor,
    this.smallText = false,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      shadowColor: Colors.grey[500],
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          title: !smallText
              ? Text(
                  subtitle,
                  style: TextStyle(fontSize: height * 0.03),
                )
              : Text(
                  title,
                  style: TextStyle(fontSize: height * 0.02),
                ),
          subtitle: Text(
            !smallText ? title : subtitle,
            style: TextStyle(fontSize: !smallText ? height * 0.02 : 12),
          ),
          trailing: !smallText
              ? Icon(
                  icon,
                  color: iconColor,
                  size: height * 0.06,
                )
              : null,
        ),
      ),
    );
  }
}
