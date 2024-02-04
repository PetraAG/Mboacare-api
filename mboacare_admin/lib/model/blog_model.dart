class BlogModel {
  String? blogWebLink;
  String? blogImage;
  String? userEmail;
  String? blogPubDate;
  String? id;
  List<String>? blogCat;
  String? blogTitle;
  String? blogAuthor;
  bool? isApprove;

  BlogModel(
      {this.blogWebLink,
      this.blogImage,
      this.userEmail,
      this.id,
      this.blogCat,
      this.blogTitle,
      this.blogAuthor,
      this.blogPubDate,
      this.isApprove});

  BlogModel.fromJson(Map<String, dynamic> json) {
    blogWebLink = json['blogWebLink'];
    blogImage = json['blogImage'];
    userEmail = json['userEmail'];
    id = json['id'];
    blogCat = json['blogCat'].cast<String>();
    blogTitle = json['blogTitle'];
    blogAuthor = json['blogAuthor'];
    blogPubDate = json['blogPubDate'].toString();
    isApprove = json['isApprove'];
  }
}

class BlogItem {
  final String imageUrl;
  final String category;
  final String title;
  final String author;
  final String date;
  final bool isApproved;
  final String blogTitle;
  final String blogWebLink;
  final String blogId;

  BlogItem({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.author,
    required this.date,
    required this.isApproved,
    required this.blogTitle,
    required this.blogWebLink,
    required this.blogId,
  });

  factory BlogItem.fromJson(Map<String, dynamic> json) {
    return BlogItem(
      imageUrl: json['blogImage'],
      category: json['blogCat'][0],
      title: json['blogTitle'],
      author: json['blogAuthor'],
      date: json['blogPubDate'],
      isApproved: json['isApprove'],
      blogTitle: json['blogTitle'],
      blogWebLink: json['blogWebLink'],
      blogId: json['id'],
    );
  }
}
