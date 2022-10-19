class CategoryModel {
  int? id;
  int? count;
  String? description;
  String? link;
  String? name;
  String? slug;
  String? taxonomy;
  int? parent;
  String? yoastHead;
  Acf? acf;
  YoastHeadJson? yoastHeadJson;

  CategoryModel(
      {this.id,
        this.count,
        this.description,
        this.link,
        this.name,
        this.slug,
        this.taxonomy,
        this.parent,
        this.yoastHead,
        this.acf,
        this.yoastHeadJson
        });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    description = json['description'];
    link = json['link'];
    name = json['name'];
    slug = json['slug'];
    taxonomy = json['taxonomy'];
    parent = json['parent'];
    acf = json['acf'] != null ? new Acf.fromJson(json['acf']) : null;
    yoastHead = json['yoast_head'];
    yoastHeadJson = json['yoast_head_json'] != null
        ? new YoastHeadJson.fromJson(json['yoast_head_json'])
        : null;
  }

}
class Acf {
  int? icon;
  String? slideshowShortcode;

  Acf({this.icon, this.slideshowShortcode});

  Acf.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    slideshowShortcode = json['slideshow_shortcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['slideshow_shortcode'] = this.slideshowShortcode;
    return data;
  }
}
class YoastHeadJson {
  String? title;
  String? description;
  Robots? robots;
  String? canonical;
  String? ogLocale;
  String? ogType;
  String? ogTitle;
  String? ogDescription;
  String? ogUrl;
  String? ogSiteName;
  String? twitterCard;
  Schema? schema;

  YoastHeadJson(
      {this.title,
        this.description,
        this.robots,
        this.canonical,
        this.ogLocale,
        this.ogType,
        this.ogTitle,
        this.ogDescription,
        this.ogUrl,
        this.ogSiteName,
        this.twitterCard,
        this.schema});

  YoastHeadJson.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    robots =
    json['robots'] != null ? new Robots.fromJson(json['robots']) : null;
    canonical = json['canonical'];
    ogLocale = json['og_locale'];
    ogType = json['og_type'];
    ogTitle = json['og_title'];
    ogDescription = json['og_description'];
    ogUrl = json['og_url'];
    ogSiteName = json['og_site_name'];
    twitterCard = json['twitter_card'];
    schema =
    json['schema'] != null ? new Schema.fromJson(json['schema']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.robots != null) {
      data['robots'] = this.robots!.toJson();
    }
    data['canonical'] = this.canonical;
    data['og_locale'] = this.ogLocale;
    data['og_type'] = this.ogType;
    data['og_title'] = this.ogTitle;
    data['og_description'] = this.ogDescription;
    data['og_url'] = this.ogUrl;
    data['og_site_name'] = this.ogSiteName;
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
  String? description;
  IsPartOf? breadcrumb;
  String? inLanguage;
  List<ItemListElement>? itemListElement;
  List<PotentialAction>? potentialAction;

  Graph(
      {this.type,
        this.id,
        this.url,
        this.name,
        this.isPartOf,
        this.description,
        this.breadcrumb,
        this.inLanguage,
        this.itemListElement,
        this.potentialAction});

  Graph.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['@id'];
    url = json['url'];
    name = json['name'];
    isPartOf = json['isPartOf'] != null
        ? new IsPartOf.fromJson(json['isPartOf'])
        : null;
    description = json['description'];
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
    if (json['potentialAction'] != null) {
      potentialAction = <PotentialAction>[];
      json['potentialAction'].forEach((v) {
        potentialAction!.add(new PotentialAction.fromJson(v));
      });
    }
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
    data['description'] = this.description;
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.toJson();
    }
    data['inLanguage'] = this.inLanguage;
    if (this.itemListElement != null) {
      data['itemListElement'] =
          this.itemListElement!.map((v) => v.toJson()).toList();
    }
    if (this.potentialAction != null) {
      data['potentialAction'] =
          this.potentialAction!.map((v) => v.toJson()).toList();
    }
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

class PotentialAction {
  String? type;
  Target? target;
  String? queryInput;

  PotentialAction({this.type, this.target, this.queryInput});

  PotentialAction.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    target =
    json['target'] != null ? new Target.fromJson(json['target']) : null;
    queryInput = json['query-input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    if (this.target != null) {
      data['target'] = this.target!.toJson();
    }
    data['query-input'] = this.queryInput;
    return data;
  }
}

class Target {
  String? type;
  String? urlTemplate;

  Target({this.type, this.urlTemplate});

  Target.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    urlTemplate = json['urlTemplate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['urlTemplate'] = this.urlTemplate;
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