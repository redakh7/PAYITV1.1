Widget _buildSearch() => Container(
  padding: EdgeInsets.all(8.0),
  color: Color(0xFF131313),
  height: 50.0,
  child: Row(
    children: <Widget>[
      Flexible(
        flex: 2,
        child: TextFormField(
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 11.0),
          decoration: InputDecoration(
              contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ), // icon is 48px widget.
              ),
              hintText: 'Search artist, genre, playlist',
              hintStyle: TextStyle(fontSize: 11.0)),
        ),
      ),
    ],
  ),
);