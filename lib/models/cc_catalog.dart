// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
class CatalogModel {
  static List<String> itemNames = [
    'Circuit Cellar December 2023 Issue 401',
    'Circuit Cellar January 2024 Issue 402',
    'Circuit Cellar February 2024 Issue 403',
    'Circuit Cellar March 2024 Issue 404',
    'Circuit Cellar April 2024 Issue 405',
    'Circuit Cellar May 2024 Issue 406',
    'Circuit Cellar June 2024 Issue 407',
    'Circuit Cellar July 2024 Issue 408',
    'Circuit Cellar August 2024 Issue 409',
    'Circuit Cellar September 2024 Issue 410',
    'Circuit Cellar October 2024 Issue 411',
    'Circuit Cellar November 2024 Issue 412',
    'Circuit Cellar December 2024 Issue 413',
    'Circuit Cellar January 2025 Issue 414',
    'Circuit Cellar February 2025 Issue 415',
    'Circuit Cellar March 2025 Issue 416',
    'Circuit Cellar April 2025 Issue 417',
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 23;

  Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
