import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final bool isSelected;
  final bool isCollapsed;
  final String title;

  // final String trailing;
  final VoidCallback? onTap;

  const NavItem({
    Key? key,
    this.isSelected = false,
    this.isCollapsed = false,
    this.title = '',
    // this.trailing = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffe2e2e1) : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: InkWell(
          hoverColor: Color(0xffebebea),
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: Container(
            // decoration: BoxDecoration(
            //   color: isSelected ? Color(0xffe2e2e1) : null,
            //   borderRadius: BorderRadius.circular(4),
            // ),
            padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
            child: isCollapsed ? collapsedWidget() : unCollapsedWidget(),
          ),
        ),
      ),
    );
  }

  Widget unCollapsedWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: _buildTextStyle(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
        ),
        SizedBox(height: 2,),
        Text(
          '$title',
          style: TextStyle(
            fontSize: 12,
            height: 1.5,
            fontWeight: FontWeight.normal,
            color: Colors.grey
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
        ),
        // Divider(height: 10,),
        // VerticalDivider(),
      ],
    );
  }

  Widget collapsedWidget() => SizedBox(
        height: 24,
        child: Tooltip(
          message: title,
          child: Text(
            title,
            style: _buildTextStyle(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );

  TextStyle _buildTextStyle() {
    return TextStyle(
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.normal,
    );
  }
}
