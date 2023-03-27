import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'actu_page.dart';
import 'package:flutter/material.dart';

class Actus {
  String author_id;
  final String description;
  final DateTime end_date;
  final GeoPoint localization;
  final Map photos;
  final String place;
  final Float price;
  final DateTime publication_date;
  final DateTime start_date;
  final Map tags;
  final String title;
  final String type;


  Actus({
    required this.author_id,
    required this.description,
    DateTime? end_date,
    required this.localization,
    required this.photos,
    this.place = '',
    required this.price,
    DateTime? publication_date,
    DateTime? start_date,
    required this.tags,
    required this.title,
    required this.type,
  })
  : this.end_date = end_date ?? DateTime.now(),
    this.start_date = start_date ?? DateTime.now(),
    this.publication_date = publication_date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'author_id' : author_id,
    'description' : description,
    'end_date' : end_date,
    'localization' : localization,
    'photos' : photos,
    'place' : place,
    'price' : price,
    'publication_date' : publication_date,
    'start_date' : start_date,
    'tags' : tags,
    'title' : title,
    'type' : type,
  };

  static Actus fromJson(Map<String, dynamic> json) => Actus(
    author_id: json['author_id'],
    description: json['description'],
    end_date: (json['end_date'] as Timestamp).toDate(),
    localization: json['localization'],
    photos: json['photos'],
    place: json['place'],
    price: json['price'],
    publication_date: (json['publication_date'] as Timestamp).toDate(),
    start_date: (json['start_date'] as Timestamp).toDate(),
    tags: json['tags'],
    title: json['title'],
    type: json['type'],
  );

  }