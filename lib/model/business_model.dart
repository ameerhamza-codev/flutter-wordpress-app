class BusinessModel {
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
  Content? content;
  int? featuredMedia;
  String? template;
  List<int>? industry;
  Acf? acf;
  YoastHeadJson? yoastHeadJson;
  UagbFeaturedImageSrc? uagbFeaturedImageSrc;
  UagbAuthorInfo? uagbAuthorInfo;
  int? uagbCommentInfo;

  BusinessModel(
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
        this.content,
        this.featuredMedia,
        this.template,
        this.industry,
        this.acf,
        this.yoastHeadJson,
        this.uagbFeaturedImageSrc,
        this.uagbAuthorInfo,
        this.uagbCommentInfo,
});

  BusinessModel.fromJson(Map<String, dynamic> json) {
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
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    featuredMedia = json['featured_media'];
    template = json['template'];
    industry = json['industry'].cast<int>();
    acf = json['acf'] != null ? new Acf.fromJson(json['acf']) : null;
    yoastHeadJson = json['yoast_head_json'] != null
        ? new YoastHeadJson.fromJson(json['yoast_head_json'])
        : null;
    uagbFeaturedImageSrc = json['uagb_featured_image_src'] != null
        ? new UagbFeaturedImageSrc.fromJson(json['uagb_featured_image_src'])
        : null;
    uagbAuthorInfo = json['uagb_author_info'] != null
        ? new UagbAuthorInfo.fromJson(json['uagb_author_info'])
        : null;
    uagbCommentInfo = json['uagb_comment_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_gmt'] = this.dateGmt;
    if (this.guid != null) {
      data['guid'] = this.guid!.toJson();
    }
    data['modified'] = this.modified;
    data['modified_gmt'] = this.modifiedGmt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['featured_media'] = this.featuredMedia;
    data['template'] = this.template;
    data['industry'] = this.industry;
    if (this.acf != null) {
      data['acf'] = this.acf!.toJson();
    }
    if (this.yoastHeadJson != null) {
      data['yoast_head_json'] = this.yoastHeadJson!.toJson();
    }
    if (this.uagbFeaturedImageSrc != null) {
      data['uagb_featured_image_src'] = this.uagbFeaturedImageSrc!.toJson();
    }
    if (this.uagbAuthorInfo != null) {
      data['uagb_author_info'] = this.uagbAuthorInfo!.toJson();
    }
    data['uagb_comment_info'] = this.uagbCommentInfo;

    return data;
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

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}

class Acf {
  List<Locations>? locations;

  Acf({this.locations});

  Acf.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  String? nickname;
  String? directions;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? phone;
  String? website;

  Locations(
      {this.nickname,
        this.directions,
        this.address,
        this.address2,
        this.city,
        this.state,
        this.zip,
        this.phone,
        this.website});

  Locations.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    directions = json['directions'];
    address = json['address'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    phone = json['phone'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['directions'] = this.directions;
    data['address'] = this.address;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['website'] = this.website;
    return data;
  }
}

class YoastHeadJson {
  String? title;
  Robots? robots;
  String? canonical;
  String? ogLocale;
  String? ogType;
  String? ogTitle;
  String? ogUrl;
  String? ogSiteName;
  String? articleModifiedTime;
  List<OgImage>? ogImage;
  String? twitterCard;

  YoastHeadJson(
      {this.title,
        this.robots,
        this.canonical,
        this.ogLocale,
        this.ogType,
        this.ogTitle,
        this.ogUrl,
        this.ogSiteName,
        this.articleModifiedTime,
        this.ogImage,
        this.twitterCard,
        });

  YoastHeadJson.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    robots =
    json['robots'] != null ? new Robots.fromJson(json['robots']) : null;
    canonical = json['canonical'];
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

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.robots != null) {
      data['robots'] = this.robots!.toJson();
    }
    data['canonical'] = this.canonical;
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

    return data;
  }
}

class Robots {
  String? index;
  String? follow;
  String? maxSnippet;
  String? maxImagePreview;
  String? maxVideoPreview;

  Robots(
      {this.index,
        this.follow,
        this.maxSnippet,
        this.maxImagePreview,
        this.maxVideoPreview});

  Robots.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    follow = json['follow'];
    maxSnippet = json['max-snippet'];
    maxImagePreview = json['max-image-preview'];
    maxVideoPreview = json['max-video-preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['follow'] = this.follow;
    data['max-snippet'] = this.maxSnippet;
    data['max-image-preview'] = this.maxImagePreview;
    data['max-video-preview'] = this.maxVideoPreview;
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

class UagbFeaturedImageSrc {
  List<String>? full;
  List<String>? thumbnail;
  List<String>? medium;
  List<String>? mediumLarge;
  List<String>? large;
  List<String>? l1536x1536;
  List<String>? l2048x2048;
  List<String>? woocommerceThumbnail;
  List<String>? woocommerceSingle;
  List<String>? woocommerceGalleryThumbnail;

  UagbFeaturedImageSrc(
      {this.full,
        this.thumbnail,
        this.medium,
        this.mediumLarge,
        this.large,
        this.l1536x1536,
        this.l2048x2048,
        this.woocommerceThumbnail,
        this.woocommerceSingle,
        this.woocommerceGalleryThumbnail});

  UagbFeaturedImageSrc.fromJson(Map<String, dynamic> json) {
    full = json['full'].cast<String>();
    thumbnail = json['thumbnail'].cast<String>();
    medium = json['medium'].cast<String>();
    mediumLarge = json['medium_large'].cast<String>();
    large = json['large'].cast<String>();
    l1536x1536 = json['1536x1536'].cast<String>();
    l2048x2048 = json['2048x2048'].cast<String>();
    woocommerceThumbnail = json['woocommerce_thumbnail'].cast<String>();
    woocommerceSingle = json['woocommerce_single'].cast<String>();
    woocommerceGalleryThumbnail =
        json['woocommerce_gallery_thumbnail'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full'] = this.full;
    data['thumbnail'] = this.thumbnail;
    data['medium'] = this.medium;
    data['medium_large'] = this.mediumLarge;
    data['large'] = this.large;
    data['1536x1536'] = this.l1536x1536;
    data['2048x2048'] = this.l2048x2048;
    data['woocommerce_thumbnail'] = this.woocommerceThumbnail;
    data['woocommerce_single'] = this.woocommerceSingle;
    data['woocommerce_gallery_thumbnail'] = this.woocommerceGalleryThumbnail;
    return data;
  }
}

class UagbAuthorInfo {
  String? displayName;
  String? authorLink;

  UagbAuthorInfo({this.displayName, this.authorLink});

  UagbAuthorInfo.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    authorLink = json['author_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    data['author_link'] = this.authorLink;
    return data;
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

class WpFeaturedmedia {
  bool? embeddable;
  String? href;

  WpFeaturedmedia({this.embeddable, this.href});

  WpFeaturedmedia.fromJson(Map<String, dynamic> json) {
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

class WpTerm {
  String? taxonomy;
  bool? embeddable;
  String? href;

  WpTerm({this.taxonomy, this.embeddable, this.href});

  WpTerm.fromJson(Map<String, dynamic> json) {
    taxonomy = json['taxonomy'];
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxonomy'] = this.taxonomy;
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}

class Curies {
  String? name;
  String? href;
  bool? templated;

  Curies({this.name, this.href, this.templated});

  Curies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    href = json['href'];
    templated = json['templated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['href'] = this.href;
    data['templated'] = this.templated;
    return data;
  }
}