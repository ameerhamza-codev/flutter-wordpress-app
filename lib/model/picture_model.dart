class PictureModel {
  int? id;
  String? date;
  String? dateGmt;
  Guid? guid;
  String? modified;
  String? modifiedGmt;
  String? slug;
  String? status;
  String? type;
  String? link;
  Guid? title;
  int? author;
  String? commentStatus;
  String? pingStatus;
  String? template;
  String? yoastHead;
  YoastHeadJson? yoastHeadJson;
  Guid? description;
  Guid? caption;
  String? altText;
  String? mediaType;
  String? mimeType;
  MediaDetails? mediaDetails;
  String? sourceUrl;

  PictureModel(
      {this.id,
        this.date,
        this.dateGmt,
        this.guid,
        this.modified,
        this.modifiedGmt,
        this.slug,
        this.status,
        this.type,
        this.link,
        this.title,
        this.author,
        this.commentStatus,
        this.pingStatus,
        this.template,
        this.yoastHead,
        this.yoastHeadJson,
        this.description,
        this.caption,
        this.altText,
        this.mediaType,
        this.mimeType,
        this.mediaDetails,
        this.sourceUrl,
        });

  PictureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? new Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    author = json['author'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    template = json['template'];

    yoastHead = json['yoast_head'];
    yoastHeadJson = json['yoast_head_json'] != null
        ? new YoastHeadJson.fromJson(json['yoast_head_json'])
        : null;
    description = json['description'] != null
        ? new Guid.fromJson(json['description'])
        : null;
    caption =
    json['caption'] != null ? new Guid.fromJson(json['caption']) : null;
    altText = json['alt_text'];
    mediaType = json['media_type'];
    mimeType = json['mime_type'];
    mediaDetails = json['media_details'] != null
        ? new MediaDetails.fromJson(json['media_details'])
        : null;

    sourceUrl = json['source_url'];
  }

}

class Guid {
  String? rendered;

  Guid({this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class YoastHeadJson {
  String? title;
  Robots? robots;
  String? ogLocale;
  String? ogType;
  String? ogTitle;
  String? ogUrl;
  String? ogSiteName;
  String? articleModifiedTime;
  List<OgImage>? ogImage;
  String? twitterCard;
  Schema? schema;

  YoastHeadJson(
      {this.title,
        this.robots,
        this.ogLocale,
        this.ogType,
        this.ogTitle,
        this.ogUrl,
        this.ogSiteName,
        this.articleModifiedTime,
        this.ogImage,
        this.twitterCard,
        this.schema});

  YoastHeadJson.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    robots =
    json['robots'] != null ? new Robots.fromJson(json['robots']) : null;
    ogLocale = json['og_locale'];
    ogType = json['og_type'];
    ogTitle = json['og_title'];
    ogUrl = json['og_url'];
    ogSiteName = json['og_site_name'];
    articleModifiedTime = json['article_modified_time'];
    if (json['og_image'] != null) {
      ogImage = <OgImage>[];
      json['og_image'].forEach((v) {
        ogImage!.add(new OgImage.fromJson(v));
      });
    }
    twitterCard = json['twitter_card'];
    schema =
    json['schema'] != null ? new Schema.fromJson(json['schema']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.robots != null) {
      data['robots'] = this.robots!.toJson();
    }
    data['og_locale'] = this.ogLocale;
    data['og_type'] = this.ogType;
    data['og_title'] = this.ogTitle;
    data['og_url'] = this.ogUrl;
    data['og_site_name'] = this.ogSiteName;
    data['article_modified_time'] = this.articleModifiedTime;
    if (this.ogImage != null) {
      data['og_image'] = this.ogImage!.map((v) => v.toJson()).toList();
    }
    data['twitter_card'] = this.twitterCard;
    if (this.schema != null) {
      data['schema'] = this.schema!.toJson();
    }
    return data;
  }
}

class Robots {
  String? index;
  String? follow;

  Robots({this.index, this.follow});

  Robots.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    follow = json['follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['follow'] = this.follow;
    return data;
  }
}

class OgImage {
  int? width;
  int? height;
  String? url;
  String? type;

  OgImage({this.width, this.height, this.url, this.type});

  OgImage.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Schema {
  String? context;
  List<Graph>? graph;

  Schema({this.context, this.graph});

  Schema.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    if (json['@graph'] != null) {
      graph = <Graph>[];
      json['@graph'].forEach((v) {
        graph!.add(new Graph.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@context'] = this.context;
    if (this.graph != null) {
      data['@graph'] = this.graph!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Graph {
  String? type;
  String? id;
  String? url;
  String? name;
  IsPartOf? isPartOf;
  String? datePublished;
  String? dateModified;
  IsPartOf? breadcrumb;
  String? inLanguage;
  List<ItemListElement>? itemListElement;
  String? description;

  Graph(
      {this.type,
        this.id,
        this.url,
        this.name,
        this.isPartOf,
        this.datePublished,
        this.dateModified,
        this.breadcrumb,
        this.inLanguage,
        this.itemListElement,
        this.description});

  Graph.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['@id'];
    url = json['url'];
    name = json['name'];
    isPartOf = json['isPartOf'] != null
        ? new IsPartOf.fromJson(json['isPartOf'])
        : null;
    datePublished = json['datePublished'];
    dateModified = json['dateModified'];
    breadcrumb = json['breadcrumb'] != null
        ? new IsPartOf.fromJson(json['breadcrumb'])
        : null;
    inLanguage = json['inLanguage'];

    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(new ItemListElement.fromJson(v));
      });
    }
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['@id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    if (this.isPartOf != null) {
      data['isPartOf'] = this.isPartOf!.toJson();
    }
    data['datePublished'] = this.datePublished;
    data['dateModified'] = this.dateModified;
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.toJson();
    }
    data['inLanguage'] = this.inLanguage;

    if (this.itemListElement != null) {
      data['itemListElement'] =
          this.itemListElement!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    return data;
  }
}

class IsPartOf {
  String? id;

  IsPartOf({this.id});

  IsPartOf.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.id;
    return data;
  }
}


class ItemListElement {
  String? type;
  int? position;
  String? name;
  String? item;

  ItemListElement({this.type, this.position, this.name, this.item});

  ItemListElement.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    name = json['name'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['position'] = this.position;
    data['name'] = this.name;
    data['item'] = this.item;
    return data;
  }
}

class MediaDetails {
  int? width;
  int? height;
  String? file;
  Sizes? sizes;
  ImageMeta? imageMeta;

  MediaDetails(
      {this.width, this.height, this.file, this.sizes, this.imageMeta});

  MediaDetails.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    file = json['file'];
    sizes = json['sizes'] != null ? new Sizes.fromJson(json['sizes']) : null;
    imageMeta = json['image_meta'] != null
        ? new ImageMeta.fromJson(json['image_meta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['file'] = this.file;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.toJson();
    }

    return data;
  }
}

class Sizes {
  Thumbnail? thumbnail;
  Thumbnail? shopThumbnail;
  Thumbnail? full;

  Sizes({this.thumbnail, this.shopThumbnail, this.full});

  Sizes.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    shopThumbnail = json['shop_thumbnail'] != null
        ? new Thumbnail.fromJson(json['shop_thumbnail'])
        : null;
    full = json['full'] != null ? new Thumbnail.fromJson(json['full']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.shopThumbnail != null) {
      data['shop_thumbnail'] = this.shopThumbnail!.toJson();
    }
    if (this.full != null) {
      data['full'] = this.full!.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String? file;
  int? width;
  int? height;
  String? mimeType;
  String? sourceUrl;

  Thumbnail(
      {this.file, this.width, this.height, this.mimeType, this.sourceUrl});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    width = json['width'];
    height = json['height'];
    mimeType = json['mime_type'];
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['width'] = this.width;
    data['height'] = this.height;
    data['mime_type'] = this.mimeType;
    data['source_url'] = this.sourceUrl;
    return data;
  }
}

class ImageMeta {
  String? aperture;
  String? credit;
  String? camera;
  String? caption;
  String? createdTimestamp;
  String? copyright;
  String? focalLength;
  String? iso;
  String? shutterSpeed;
  String? title;
  String? orientation;
  List<Null>? keywords;

  ImageMeta(
      {this.aperture,
        this.credit,
        this.camera,
        this.caption,
        this.createdTimestamp,
        this.copyright,
        this.focalLength,
        this.iso,
        this.shutterSpeed,
        this.title,
        this.orientation,
        this.keywords});

  ImageMeta.fromJson(Map<String, dynamic> json) {
    aperture = json['aperture'];
    credit = json['credit'];
    camera = json['camera'];
    caption = json['caption'];
    createdTimestamp = json['created_timestamp'];
    copyright = json['copyright'];
    focalLength = json['focal_length'];
    iso = json['iso'];
    shutterSpeed = json['shutter_speed'];
    title = json['title'];
    orientation = json['orientation'];

  }

}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Author {
  bool? embeddable;
  String? href;

  Author({this.embeddable, this.href});

  Author.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}