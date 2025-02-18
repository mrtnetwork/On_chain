class AptosGraphqlQueriesConst {
  static const String getAccountCoinsCount =
      r'''query getAccountCoinsCount($address: String) {
  current_fungible_asset_balances_aggregate(
    where: {owner_address: {_eq: $address}}
  ) {
    aggregate {
      count
    }
  }
}''';
  static const String chainId = r'''query {
  ledger_infos {
    chain_id
  }
}''';

  static const String getAccountCoinsData =
      r'''query getAccountCoinsData($where_condition: current_fungible_asset_balances_bool_exp!, $offset: Int, $limit: Int, $order_by: [current_fungible_asset_balances_order_by!]) {
  current_fungible_asset_balances(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    amount
    asset_type
    is_frozen
    is_primary
    last_transaction_timestamp
    last_transaction_version
    owner_address
    storage_id
    token_standard
    metadata {
      token_standard
      symbol
      supply_aggregator_table_key_v1
      supply_aggregator_table_handle_v1
      project_uri
      name
      last_transaction_version
      last_transaction_timestamp
      icon_uri
      decimals
      creator_address
      asset_type
    }
  }
}''';

  static const String getAccountCollectionWithOwnedTokens =
      r'''query getAccountCollectionsWithOwnedTokens($where_condition: current_collection_ownership_v2_view_bool_exp!, $offset: Int, $limit: Int, $order_by: [current_collection_ownership_v2_view_order_by!]) {
  current_collection_ownership_v2_view(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    current_collection {
      collection_id
      collection_name
      creator_address
      current_supply
      description
      last_transaction_timestamp
      last_transaction_version
      mutable_description
      max_supply
      mutable_uri
      table_handle_v1
      token_standard
      total_minted_v2
      uri
    }
    collection_id
    collection_name
    collection_uri
    creator_address
    distinct_tokens
    last_transaction_version
    owner_address
    single_token_uri
  }
}''';

  static const String currentTokenOwnershipFieldsFragmentDoc =
      '''fragment CurrentTokenOwnershipFields on current_token_ownerships_v2 {
  token_standard
  token_properties_mutated_v1
  token_data_id
  table_type_v1
  storage_id
  property_version_v1
  owner_address
  last_transaction_version
  last_transaction_timestamp
  is_soulbound_v2
  is_fungible_v2
  amount
  current_token_data {
    collection_id
    description
    is_fungible_v2
    largest_property_version_v1
    last_transaction_timestamp
    last_transaction_version
    maximum
    supply
    token_data_id
    token_name
    token_properties
    token_standard
    token_uri
    decimals
    current_collection {
      collection_id
      collection_name
      creator_address
      current_supply
      description
      last_transaction_timestamp
      last_transaction_version
      max_supply
      mutable_description
      mutable_uri
      table_handle_v1
      token_standard
      total_minted_v2
      uri
    }
  }
}
''';

  static const String getAccountOwnedTokens =
      r'''query getAccountOwnedTokens($where_condition: current_token_ownerships_v2_bool_exp!, $offset: Int, $limit: Int, $order_by: [current_token_ownerships_v2_order_by!]) {
  current_token_ownerships_v2(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    ...CurrentTokenOwnershipFields
  }
}''' +
          currentTokenOwnershipFieldsFragmentDoc;
  static String getAccountOwnedTokensByTokenData =
      r'''query getAccountOwnedTokensByTokenData($where_condition: current_token_ownerships_v2_bool_exp!, $offset: Int, $limit: Int, $order_by: [current_token_ownerships_v2_order_by!]) {
  current_token_ownerships_v2(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    ...CurrentTokenOwnershipFields
  }
}''' +
          currentTokenOwnershipFieldsFragmentDoc;

  static String getAccountOwnedTokensFromCollection =
      r'''query getAccountOwnedTokensFromCollection($where_condition: current_token_ownerships_v2_bool_exp!, $offset: Int, $limit: Int, $order_by: [current_token_ownerships_v2_order_by!]) {
  current_token_ownerships_v2(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    ...CurrentTokenOwnershipFields
  }
}''' +
          currentTokenOwnershipFieldsFragmentDoc;

  static const String getAccountTokensCount =
      r'''query getAccountTokensCount($where_condition: current_token_ownerships_v2_bool_exp, $offset: Int, $limit: Int) {
  current_token_ownerships_v2_aggregate(
    where: $where_condition
    offset: $offset
    limit: $limit
  ) {
    aggregate {
      count
    }
  }
}''';
  static const String getAccountTransactionsCount =
      r'''query getAccountTransactionsCount($address: String) {
  account_transactions_aggregate(where: {account_address: {_eq: $address}}) {
    aggregate {
      count
    }
  }
}''';
  static const String getChainTopUserTransactions =
      r'''query getChainTopUserTransactions($limit: Int) {
  user_transactions(limit: $limit, order_by: {version: desc}) {
    version
  }
}''';
  static const String getCollectionData =
      r'''query getCollectionData($where_condition: current_collections_v2_bool_exp!) {
  current_collections_v2(where: $where_condition) {
    uri
    total_minted_v2
    token_standard
    table_handle_v1
    mutable_uri
    mutable_description
    max_supply
    collection_id
    collection_name
    creator_address
    current_supply
    description
    last_transaction_timestamp
    last_transaction_version
    cdn_asset_uris {
      cdn_image_uri
      asset_uri
      animation_optimizer_retry_count
      cdn_animation_uri
      cdn_json_uri
      image_optimizer_retry_count
      json_parser_retry_count
      raw_animation_uri
      raw_image_uri
    }
  }
}''';

  static const String getCurrentFungibleAssetBalances =
      r'''query getCurrentFungibleAssetBalances($where_condition: current_fungible_asset_balances_bool_exp, $offset: Int, $limit: Int) {
  current_fungible_asset_balances(
    where: $where_condition
    offset: $offset
    limit: $limit
  ) {
    amount
    asset_type
    is_frozen
    is_primary
    last_transaction_timestamp
    last_transaction_version
    owner_address
    storage_id
    token_standard
  }
}''';
  static const String getDelegatedStakingActivities =
      r'''query getDelegatedStakingActivities($delegatorAddress: String, $poolAddress: String) {
  delegated_staking_activities(
    where: {delegator_address: {_eq: $delegatorAddress}, pool_address: {_eq: $poolAddress}}
  ) {
    amount
    delegator_address
    event_index
    event_type
    pool_address
    transaction_version
  }
}''';

  static const String getEvents =
      r'''query getEvents($where_condition: events_bool_exp, $offset: Int, $limit: Int, $order_by: [events_order_by!]) {
  events(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    account_address
    creation_number
    data
    event_index
    sequence_number
    transaction_block_height
    transaction_version
    type
    indexed_type
  }
}''';

  static const String getFungibleAssetActivities =
      r'''query getFungibleAssetActivities($where_condition: fungible_asset_activities_bool_exp, $offset: Int, $limit: Int) {
  fungible_asset_activities(
    where: $where_condition
    offset: $offset
    limit: $limit
  ) {
    amount
    asset_type
    block_height
    entry_function_id_str
    event_index
    gas_fee_payer_address
    is_frozen
    is_gas_fee
    is_transaction_success
    owner_address
    storage_id
    storage_refund_amount
    token_standard
    transaction_timestamp
    transaction_version
    type
  }
}''';
  static const String getFungibleAssetMetadata =
      r'''query getFungibleAssetMetadata($where_condition: fungible_asset_metadata_bool_exp, $offset: Int, $limit: Int) {
  fungible_asset_metadata(where: $where_condition, offset: $offset, limit: $limit) {
    icon_uri
    project_uri
    supply_aggregator_table_handle_v1
    supply_aggregator_table_key_v1
    creator_address
    asset_type
    decimals
    last_transaction_timestamp
    last_transaction_version
    name
    symbol
    token_standard
    supply_v2
    maximum_v2
  }
}''';
  static const String ansTokenFragmentFragmentDoc =
      r'''query getFungibleAssetMetadata($where_condition: fungible_asset_metadata_bool_exp, $offset: Int, $limit: Int) {
  fungible_asset_metadata(where: $where_condition, offset: $offset, limit: $limit) {
    icon_uri
    project_uri
    supply_aggregator_table_handle_v1
    supply_aggregator_table_key_v1
    creator_address
    asset_type
    decimals
    last_transaction_timestamp
    last_transaction_version
    name
    symbol
    token_standard
    supply_v2
    maximum_v2
  }
}''';
  static const String getNames =
      r'''query getNames($offset: Int, $limit: Int, $where_condition: current_aptos_names_bool_exp, $order_by: [current_aptos_names_order_by!]) {
  current_aptos_names(
    limit: $limit
    where: $where_condition
    order_by: $order_by
    offset: $offset
  ) {
    ...AnsTokenFragment
  }
}''' +
          ansTokenFragmentFragmentDoc;
  static const String getNumberOfDelegators =
      r'''query getNumberOfDelegators($where_condition: num_active_delegator_per_pool_bool_exp, $order_by: [num_active_delegator_per_pool_order_by!]) {
  num_active_delegator_per_pool(where: $where_condition, order_by: $order_by) {
    num_active_delegator
    pool_address
  }
}''';
  static const String getObjectData =
      r'''query getObjectData($where_condition: current_objects_bool_exp, $offset: Int, $limit: Int, $order_by: [current_objects_order_by!]) {
  current_objects(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    allow_ungated_transfer
    state_key_hash
    owner_address
    object_address
    last_transaction_version
    last_guid_creation_num
    is_deleted
  }
}''';
  static const String getProcessorStatus =
      r'''query getProcessorStatus($where_condition: processor_status_bool_exp) {
  processor_status(where: $where_condition) {
    last_success_version
    processor
    last_updated
  }
}''';
  static const String getTableItemsData =
      r'''query getTableItemsData($where_condition: table_items_bool_exp!, $offset: Int, $limit: Int, $order_by: [table_items_order_by!]) {
  table_items(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    decoded_key
    decoded_value
    key
    table_handle
    transaction_version
    write_set_change_index
  }
}''';
  static const String getTableItemsMetadata =
      r'''query getTableItemsMetadata($where_condition: table_metadatas_bool_exp!, $offset: Int, $limit: Int, $order_by: [table_metadatas_order_by!]) {
  table_metadatas(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    handle
    key_type
    value_type
  }
}''';
  static const String tokenActivitiesFieldsFragmentDoc =
      r'''fragment TokenActivitiesFields on token_activities_v2 {
  after_value
  before_value
  entry_function_id_str
  event_account_address
  event_index
  from_address
  is_fungible_v2
  property_version_v1
  to_address
  token_amount
  token_data_id
  token_standard
  transaction_timestamp
  transaction_version
  type
}''';
  static const String getTokenActivity =
      r'''query getTokenActivity($where_condition: token_activities_v2_bool_exp!, $offset: Int, $limit: Int, $order_by: [token_activities_v2_order_by!]) {
  token_activities_v2(
    where: $where_condition
    order_by: $order_by
    offset: $offset
    limit: $limit
  ) {
    ...TokenActivitiesFields
  }
}''' +
          tokenActivitiesFieldsFragmentDoc;
  static const String getCurrentTokenOwnership =
      r'''query getCurrentTokenOwnership($where_condition: current_token_ownerships_v2_bool_exp!, $offset: Int, $limit: Int, $order_by: [current_token_ownerships_v2_order_by!]) {
  current_token_ownerships_v2(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    ...CurrentTokenOwnershipFields
  }
}''' +
          currentTokenOwnershipFieldsFragmentDoc;

  static const String getTokenData =
      r'''query getTokenData($where_condition: current_token_datas_v2_bool_exp, $offset: Int, $limit: Int, $order_by: [current_token_datas_v2_order_by!]) {
  current_token_datas_v2(
    where: $where_condition
    offset: $offset
    limit: $limit
    order_by: $order_by
  ) {
    collection_id
    description
    is_fungible_v2
    largest_property_version_v1
    last_transaction_timestamp
    last_transaction_version
    maximum
    supply
    token_data_id
    token_name
    token_properties
    token_standard
    token_uri
    decimals
    current_collection {
      collection_id
      collection_name
      creator_address
      current_supply
      description
      last_transaction_timestamp
      last_transaction_version
      max_supply
      mutable_description
      mutable_uri
      table_handle_v1
      token_standard
      total_minted_v2
      uri
    }
  }
}''';
}

class AptosGraphQLApiAggregate {
  final int? count;

  // Constructor
  AptosGraphQLApiAggregate({this.count});

  // Factory method to create the class from a JSON object
  factory AptosGraphQLApiAggregate.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLApiAggregate(count: json['count']);
  }

  // Converts the object to a JSON representation
  Map<String, dynamic> toJson() {
    return {'count': count};
  }
}

class AptosGraphQLPaginatedWithOrderVariablesParams {
  final Map<String, dynamic> whereCondition;
  final int? offset;
  final int? limit;
  final List<Map<String, dynamic>>? orderBy;

  AptosGraphQLPaginatedWithOrderVariablesParams({
    this.whereCondition = const {},
    this.offset,
    this.limit,
    this.orderBy,
  });

  // Converts the object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'where_condition': whereCondition,
      'offset': offset,
      'limit': limit,
      'order_by': orderBy?.map((e) => e).toList(),
    };
  }
}

class AptosGraphQLWhereConditionWithOrderVariablesParams {
  final Map<String, dynamic> whereCondition;
  final List<Map<String, dynamic>>? orderBy;

  AptosGraphQLWhereConditionWithOrderVariablesParams({
    this.whereCondition = const {},
    this.orderBy,
  });

  // Converts the object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'where_condition': whereCondition,
      'order_by': orderBy?.map((e) => e).toList(),
    };
  }
}

class AptosGraphQLWhereConditionVariablesParams {
  final Map<String, dynamic> whereCondition;

  AptosGraphQLWhereConditionVariablesParams({this.whereCondition = const {}});

  // Converts the object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'where_condition': whereCondition,
    };
  }
}

class AptosGraphQLPaginatedVariablesParams {
  final Map<String, dynamic> whereCondition;
  final int? offset;
  final int? limit;

  AptosGraphQLPaginatedVariablesParams(
      {this.whereCondition = const {}, this.offset, this.limit});

  // Converts the object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'where_condition': whereCondition,
      'offset': offset,
      'limit': limit
    };
  }
}

class AptosGraphQLFungibleAssetBalance {
  final dynamic amount;
  final String? assetType;
  final bool isFrozen;
  final bool? isPrimary;
  final dynamic lastTransactionTimestamp;
  final dynamic lastTransactionVersion;
  final String ownerAddress;
  final String storageId;
  final String? tokenStandard;
  final AptosGraphQLFungibleAssetMetadata? metadata;

  AptosGraphQLFungibleAssetBalance({
    this.amount,
    this.assetType,
    required this.isFrozen,
    this.isPrimary,
    this.lastTransactionTimestamp,
    this.lastTransactionVersion,
    required this.ownerAddress,
    required this.storageId,
    this.tokenStandard,
    this.metadata,
  });

  factory AptosGraphQLFungibleAssetBalance.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLFungibleAssetBalance(
      amount: json['amount'],
      assetType: json['asset_type'],
      isFrozen: json['is_frozen'],
      isPrimary: json['is_primary'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      lastTransactionVersion: json['last_transaction_version'],
      ownerAddress: json['owner_address'],
      storageId: json['storage_id'],
      tokenStandard: json['token_standard'],
      metadata: json['metadata'] != null
          ? AptosGraphQLFungibleAssetMetadata.fromJson(json['metadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'asset_type': assetType,
      'is_frozen': isFrozen,
      'is_primary': isPrimary,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'last_transaction_version': lastTransactionVersion,
      'owner_address': ownerAddress,
      'storage_id': storageId,
      'token_standard': tokenStandard,
      'metadata': metadata?.toJson(),
    };
  }
}

class AptosGraphQLFungibleAssetMetadata {
  final String tokenStandard;
  final String symbol;
  final String? supplyAggregatorTableKeyV1;
  final String? supplyAggregatorTableHandleV1;
  final String? projectUri;
  final String name;
  final dynamic lastTransactionVersion;
  final dynamic lastTransactionTimestamp;
  final String? iconUri;
  final int decimals;
  final String creatorAddress;
  final String assetType;

  AptosGraphQLFungibleAssetMetadata({
    required this.tokenStandard,
    required this.symbol,
    this.supplyAggregatorTableKeyV1,
    this.supplyAggregatorTableHandleV1,
    this.projectUri,
    required this.name,
    required this.lastTransactionVersion,
    required this.lastTransactionTimestamp,
    this.iconUri,
    required this.decimals,
    required this.creatorAddress,
    required this.assetType,
  });

  factory AptosGraphQLFungibleAssetMetadata.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLFungibleAssetMetadata(
      tokenStandard: json['token_standard'],
      symbol: json['symbol'],
      supplyAggregatorTableKeyV1: json['supply_aggregator_table_key_v1'],
      supplyAggregatorTableHandleV1: json['supply_aggregator_table_handle_v1'],
      projectUri: json['project_uri'],
      name: json['name'],
      lastTransactionVersion: json['last_transaction_version'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      iconUri: json['icon_uri'],
      decimals: json['decimals'],
      creatorAddress: json['creator_address'],
      assetType: json['asset_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_standard': tokenStandard,
      'symbol': symbol,
      'supply_aggregator_table_key_v1': supplyAggregatorTableKeyV1,
      'supply_aggregator_table_handle_v1': supplyAggregatorTableHandleV1,
      'project_uri': projectUri,
      'name': name,
      'last_transaction_version': lastTransactionVersion,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'icon_uri': iconUri,
      'decimals': decimals,
      'creator_address': creatorAddress,
      'asset_type': assetType,
    };
  }
}

class AptosGraphQLCollectionOwnershipV2View {
  final String? collectionId;
  final String? collectionName;
  final String? collectionUri;
  final String? creatorAddress;
  final dynamic distinctTokens;
  final dynamic lastTransactionVersion;
  final String? ownerAddress;
  final String? singleTokenUri;
  final AptosGraphQLCollectionOwnershipV2ViewCollection? currentCollection;

  AptosGraphQLCollectionOwnershipV2View({
    this.collectionId,
    this.collectionName,
    this.collectionUri,
    this.creatorAddress,
    this.distinctTokens,
    this.lastTransactionVersion,
    this.ownerAddress,
    this.singleTokenUri,
    this.currentCollection,
  });

  factory AptosGraphQLCollectionOwnershipV2View.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLCollectionOwnershipV2View(
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      collectionUri: json['collection_uri'],
      creatorAddress: json['creator_address'],
      distinctTokens: json['distinct_tokens'],
      lastTransactionVersion: json['last_transaction_version'],
      ownerAddress: json['owner_address'],
      singleTokenUri: json['single_token_uri'],
      currentCollection: json['current_collection'] != null
          ? AptosGraphQLCollectionOwnershipV2ViewCollection.fromJson(
              json['current_collection'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_id': collectionId,
      'collection_name': collectionName,
      'collection_uri': collectionUri,
      'creator_address': creatorAddress,
      'distinct_tokens': distinctTokens,
      'last_transaction_version': lastTransactionVersion,
      'owner_address': ownerAddress,
      'single_token_uri': singleTokenUri,
      'current_collection': currentCollection?.toJson(),
    };
  }
}

class AptosGraphQLCollectionOwnershipV2ViewCollection {
  final String collectionId;
  final String collectionName;
  final String creatorAddress;
  final dynamic currentSupply;
  final String description;
  final dynamic lastTransactionTimestamp;
  final dynamic lastTransactionVersion;
  final bool? mutableDescription;
  final dynamic maxSupply;
  final bool? mutableUri;
  final String? tableHandleV1;
  final String tokenStandard;
  final dynamic totalMintedV2;
  final String uri;

  AptosGraphQLCollectionOwnershipV2ViewCollection({
    required this.collectionId,
    required this.collectionName,
    required this.creatorAddress,
    required this.currentSupply,
    required this.description,
    required this.lastTransactionTimestamp,
    required this.lastTransactionVersion,
    this.mutableDescription,
    this.maxSupply,
    this.mutableUri,
    this.tableHandleV1,
    required this.tokenStandard,
    this.totalMintedV2,
    required this.uri,
  });

  factory AptosGraphQLCollectionOwnershipV2ViewCollection.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLCollectionOwnershipV2ViewCollection(
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      creatorAddress: json['creator_address'],
      currentSupply: json['current_supply'],
      description: json['description'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      lastTransactionVersion: json['last_transaction_version'],
      mutableDescription: json['mutable_description'],
      maxSupply: json['max_supply'],
      mutableUri: json['mutable_uri'],
      tableHandleV1: json['table_handle_v1'],
      tokenStandard: json['token_standard'],
      totalMintedV2: json['total_minted_v2'],
      uri: json['uri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_id': collectionId,
      'collection_name': collectionName,
      'creator_address': creatorAddress,
      'current_supply': currentSupply,
      'description': description,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'last_transaction_version': lastTransactionVersion,
      'mutable_description': mutableDescription,
      'max_supply': maxSupply,
      'mutable_uri': mutableUri,
      'table_handle_v1': tableHandleV1,
      'token_standard': tokenStandard,
      'total_minted_v2': totalMintedV2,
      'uri': uri,
    };
  }
}

class AptosGraphQLTokenOwnershipV2 {
  final String tokenStandard;
  final dynamic tokenPropertiesMutatedV1;
  final String tokenDataId;
  final String? tableTypeV1;
  final String storageId;
  final dynamic propertyVersionV1;
  final String ownerAddress;
  final dynamic lastTransactionVersion;
  final dynamic lastTransactionTimestamp;
  final bool? isSoulboundV2;
  final bool? isFungibleV2;
  final dynamic amount;
  final AptosGraphQLTokenOwnershipV2TokenData? currentTokenData;

  AptosGraphQLTokenOwnershipV2({
    required this.tokenStandard,
    this.tokenPropertiesMutatedV1,
    required this.tokenDataId,
    this.tableTypeV1,
    required this.storageId,
    required this.propertyVersionV1,
    required this.ownerAddress,
    this.lastTransactionVersion,
    this.lastTransactionTimestamp,
    this.isSoulboundV2,
    this.isFungibleV2,
    required this.amount,
    this.currentTokenData,
  });

  factory AptosGraphQLTokenOwnershipV2.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLTokenOwnershipV2(
      tokenStandard: json['token_standard'],
      tokenPropertiesMutatedV1: json['token_properties_mutated_v1'],
      tokenDataId: json['token_data_id'],
      tableTypeV1: json['table_type_v1'],
      storageId: json['storage_id'],
      propertyVersionV1: json['property_version_v1'],
      ownerAddress: json['owner_address'],
      lastTransactionVersion: json['last_transaction_version'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      isSoulboundV2: json['is_soulbound_v2'],
      isFungibleV2: json['is_fungible_v2'],
      amount: json['amount'],
      currentTokenData: json['current_token_data'] == null
          ? null
          : AptosGraphQLTokenOwnershipV2TokenData.fromJson(
              json['current_token_data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_standard': tokenStandard,
      'token_properties_mutated_v1': tokenPropertiesMutatedV1,
      'token_data_id': tokenDataId,
      'table_type_v1': tableTypeV1,
      'storage_id': storageId,
      'property_version_v1': propertyVersionV1,
      'owner_address': ownerAddress,
      'last_transaction_version': lastTransactionVersion,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'is_soulbound_v2': isSoulboundV2,
      'is_fungible_v2': isFungibleV2,
      'amount': amount,
      'current_token_data': currentTokenData?.toJson(),
    };
  }
}

class AptosGraphQLTokenOwnershipV2TokenData {
  final String collectionId;
  final String description;
  final bool? isFungibleV2;
  final dynamic largestPropertyVersionV1;
  final dynamic lastTransactionTimestamp;
  final dynamic lastTransactionVersion;
  final dynamic maximum;
  final dynamic supply;
  final String tokenDataId;
  final String tokenName;
  final dynamic tokenProperties;
  final String tokenStandard;
  final String tokenUri;
  final dynamic decimals;
  final AptosGraphQLTokenOwnershipV2TokenDataCollection? currentCollection;

  AptosGraphQLTokenOwnershipV2TokenData({
    required this.collectionId,
    required this.description,
    this.isFungibleV2,
    this.largestPropertyVersionV1,
    this.lastTransactionTimestamp,
    this.lastTransactionVersion,
    this.maximum,
    this.supply,
    required this.tokenDataId,
    required this.tokenName,
    this.tokenProperties,
    required this.tokenStandard,
    required this.tokenUri,
    this.decimals,
    this.currentCollection,
  });

  factory AptosGraphQLTokenOwnershipV2TokenData.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLTokenOwnershipV2TokenData(
      collectionId: json['collection_id'],
      description: json['description'],
      isFungibleV2: json['is_fungible_v2'],
      largestPropertyVersionV1: json['largest_property_version_v1'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      lastTransactionVersion: json['last_transaction_version'],
      maximum: json['maximum'],
      supply: json['supply'],
      tokenDataId: json['token_data_id'],
      tokenName: json['token_name'],
      tokenProperties: json['token_properties'],
      tokenStandard: json['token_standard'],
      tokenUri: json['token_uri'],
      decimals: json['decimals'],
      currentCollection: json['current_collection'] == null
          ? null
          : AptosGraphQLTokenOwnershipV2TokenDataCollection.fromJson(
              json['current_collection']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_id': collectionId,
      'description': description,
      'is_fungible_v2': isFungibleV2,
      'largest_property_version_v1': largestPropertyVersionV1,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'last_transaction_version': lastTransactionVersion,
      'maximum': maximum,
      'supply': supply,
      'token_data_id': tokenDataId,
      'token_name': tokenName,
      'token_properties': tokenProperties,
      'token_standard': tokenStandard,
      'token_uri': tokenUri,
      'decimals': decimals,
      'current_collection': currentCollection?.toJson(),
    };
  }
}

class AptosGraphQLTokenOwnershipV2TokenDataCollection {
  final String collectionId;
  final String collectionName;
  final String creatorAddress;
  final dynamic currentSupply;
  final String description;
  final dynamic lastTransactionTimestamp;
  final dynamic lastTransactionVersion;
  final dynamic maxSupply;
  final bool? mutableDescription;
  final bool? mutableUri;
  final String? tableHandleV1;
  final String tokenStandard;
  final dynamic totalMintedV2;
  final String uri;

  AptosGraphQLTokenOwnershipV2TokenDataCollection({
    required this.collectionId,
    required this.collectionName,
    required this.creatorAddress,
    required this.currentSupply,
    required this.description,
    this.lastTransactionTimestamp,
    this.lastTransactionVersion,
    this.maxSupply,
    this.mutableDescription,
    this.mutableUri,
    this.tableHandleV1,
    required this.tokenStandard,
    this.totalMintedV2,
    required this.uri,
  });

  factory AptosGraphQLTokenOwnershipV2TokenDataCollection.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLTokenOwnershipV2TokenDataCollection(
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      creatorAddress: json['creator_address'],
      currentSupply: json['current_supply'],
      description: json['description'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      lastTransactionVersion: json['last_transaction_version'],
      maxSupply: json['max_supply'],
      mutableDescription: json['mutable_description'],
      mutableUri: json['mutable_uri'],
      tableHandleV1: json['table_handle_v1'],
      tokenStandard: json['token_standard'],
      totalMintedV2: json['total_minted_v2'],
      uri: json['uri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_id': collectionId,
      'collection_name': collectionName,
      'creator_address': creatorAddress,
      'current_supply': currentSupply,
      'description': description,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'last_transaction_version': lastTransactionVersion,
      'max_supply': maxSupply,
      'mutable_description': mutableDescription,
      'mutable_uri': mutableUri,
      'table_handle_v1': tableHandleV1,
      'token_standard': tokenStandard,
      'total_minted_v2': totalMintedV2,
      'uri': uri,
    };
  }
}

class AptosGraphQLCollectionV2 {
  final String uri;
  final String tokenStandard;
  final String collectionId;
  final String collectionName;
  final String creatorAddress;
  final String description;
  final dynamic totalMintedV2;
  final String? tableHandleV1;
  final bool? mutableUri;
  final bool? mutableDescription;
  final dynamic maxSupply;
  final dynamic currentSupply;
  final String lastTransactionTimestamp;
  final dynamic lastTransactionVersion;
  final AptosGraphQLCollectionV2CdnAssetUris? cdnAssetUris;

  AptosGraphQLCollectionV2({
    required this.uri,
    required this.tokenStandard,
    required this.collectionId,
    required this.collectionName,
    required this.creatorAddress,
    required this.description,
    this.totalMintedV2,
    this.tableHandleV1,
    this.mutableUri,
    this.mutableDescription,
    this.maxSupply,
    this.currentSupply,
    required this.lastTransactionTimestamp,
    this.lastTransactionVersion,
    this.cdnAssetUris,
  });

  factory AptosGraphQLCollectionV2.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLCollectionV2(
      uri: json['uri'],
      tokenStandard: json['token_standard'],
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      creatorAddress: json['creator_address'],
      description: json['description'],
      totalMintedV2: json['total_minted_v2'],
      tableHandleV1: json['table_handle_v1'],
      mutableUri: json['mutable_uri'],
      mutableDescription: json['mutable_description'],
      maxSupply: json['max_supply'],
      currentSupply: json['current_supply'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      lastTransactionVersion: json['last_transaction_version'],
      cdnAssetUris: json['cdn_asset_uris'] == null
          ? null
          : AptosGraphQLCollectionV2CdnAssetUris.fromJson(
              json['cdn_asset_uris']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
      'token_standard': tokenStandard,
      'collection_id': collectionId,
      'collection_name': collectionName,
      'creator_address': creatorAddress,
      'description': description,
      'total_minted_v2': totalMintedV2,
      'table_handle_v1': tableHandleV1,
      'mutable_uri': mutableUri,
      'mutable_description': mutableDescription,
      'max_supply': maxSupply,
      'current_supply': currentSupply,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'last_transaction_version': lastTransactionVersion,
      'cdn_asset_uris': cdnAssetUris?.toJson(),
    };
  }
}

class AptosGraphQLCollectionV2CdnAssetUris {
  final String assetUri;
  final int animationOptimizerRetryCount;
  final String? cdnImageUri;
  final String? cdnAnimationUri;
  final String? cdnJsonUri;
  final int imageOptimizerRetryCount;
  final int jsonParserRetryCount;
  final String? rawAnimationUri;
  final String? rawImageUri;

  AptosGraphQLCollectionV2CdnAssetUris({
    required this.assetUri,
    required this.animationOptimizerRetryCount,
    this.cdnImageUri,
    this.cdnAnimationUri,
    this.cdnJsonUri,
    required this.imageOptimizerRetryCount,
    required this.jsonParserRetryCount,
    this.rawAnimationUri,
    this.rawImageUri,
  });

  factory AptosGraphQLCollectionV2CdnAssetUris.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLCollectionV2CdnAssetUris(
      assetUri: json['asset_uri'],
      animationOptimizerRetryCount: json['animation_optimizer_retry_count'],
      cdnImageUri: json['cdn_image_uri'],
      cdnAnimationUri: json['cdn_animation_uri'],
      cdnJsonUri: json['cdn_json_uri'],
      imageOptimizerRetryCount: json['image_optimizer_retry_count'],
      jsonParserRetryCount: json['json_parser_retry_count'],
      rawAnimationUri: json['raw_animation_uri'],
      rawImageUri: json['raw_image_uri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset_uri': assetUri,
      'animation_optimizer_retry_count': animationOptimizerRetryCount,
      'cdn_image_uri': cdnImageUri,
      'cdn_animation_uri': cdnAnimationUri,
      'cdn_json_uri': cdnJsonUri,
      'image_optimizer_retry_count': imageOptimizerRetryCount,
      'json_parser_retry_count': jsonParserRetryCount,
      'raw_animation_uri': rawAnimationUri,
      'raw_image_uri': rawImageUri,
    };
  }
}

class AptosGraphQLDelegatedStakingActivity {
  final dynamic amount;
  final String delegatorAddress;
  final dynamic eventIndex;
  final String eventType;
  final String poolAddress;
  final dynamic transactionVersion;

  AptosGraphQLDelegatedStakingActivity({
    required this.amount,
    required this.delegatorAddress,
    required this.eventIndex,
    required this.eventType,
    required this.poolAddress,
    required this.transactionVersion,
  });

  factory AptosGraphQLDelegatedStakingActivity.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLDelegatedStakingActivity(
      amount: json['amount'],
      delegatorAddress: json['delegator_address'],
      eventIndex: json['event_index'],
      eventType: json['event_type'],
      poolAddress: json['pool_address'],
      transactionVersion: json['transaction_version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'delegator_address': delegatorAddress,
      'event_index': eventIndex,
      'event_type': eventType,
      'pool_address': poolAddress,
      'transaction_version': transactionVersion,
    };
  }
}

class AptosGraphQLEvent {
  final String accountAddress;
  final dynamic creationNumber;
  final dynamic data;
  final dynamic eventIndex;
  final dynamic sequenceNumber;
  final dynamic transactionBlockHeight;
  final dynamic transactionVersion;
  final String type;
  final String indexedType;

  AptosGraphQLEvent({
    required this.accountAddress,
    required this.creationNumber,
    required this.data,
    required this.eventIndex,
    required this.sequenceNumber,
    required this.transactionBlockHeight,
    required this.transactionVersion,
    required this.type,
    required this.indexedType,
  });

  factory AptosGraphQLEvent.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLEvent(
      accountAddress: json['account_address'],
      creationNumber: json['creation_number'],
      data: json['data'],
      eventIndex: json['event_index'],
      sequenceNumber: json['sequence_number'],
      transactionBlockHeight: json['transaction_block_height'],
      transactionVersion: json['transaction_version'],
      type: json['type'],
      indexedType: json['indexed_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_address': accountAddress,
      'creation_number': creationNumber,
      'data': data,
      'event_index': eventIndex,
      'sequence_number': sequenceNumber,
      'transaction_block_height': transactionBlockHeight,
      'transaction_version': transactionVersion,
      'type': type,
      'indexed_type': indexedType,
    };
  }
}

class AptosGraphQLFungibleAssetActivity {
  final dynamic amount;
  final String? assetType;
  final dynamic blockHeight;
  final String? entryFunctionIdStr;
  final dynamic eventIndex;
  final String? gasFeePayerAddress;
  final bool? isFrozen;
  final bool isGasFee;
  final bool isTransactionSuccess;
  final String? ownerAddress;
  final String storageId;
  final dynamic storageRefundAmount;
  final String tokenStandard;
  final dynamic transactionTimestamp;
  final dynamic transactionVersion;
  final String type;

  AptosGraphQLFungibleAssetActivity({
    this.amount,
    this.assetType,
    required this.blockHeight,
    this.entryFunctionIdStr,
    required this.eventIndex,
    this.gasFeePayerAddress,
    this.isFrozen,
    required this.isGasFee,
    required this.isTransactionSuccess,
    this.ownerAddress,
    required this.storageId,
    this.storageRefundAmount,
    required this.tokenStandard,
    required this.transactionTimestamp,
    required this.transactionVersion,
    required this.type,
  });

  factory AptosGraphQLFungibleAssetActivity.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLFungibleAssetActivity(
      amount: json['amount'],
      assetType: json['asset_type'],
      blockHeight: json['block_height'],
      entryFunctionIdStr: json['entry_function_id_str'],
      eventIndex: json['event_index'],
      gasFeePayerAddress: json['gas_fee_payer_address'],
      isFrozen: json['is_frozen'],
      isGasFee: json['is_gas_fee'],
      isTransactionSuccess: json['is_transaction_success'],
      ownerAddress: json['owner_address'],
      storageId: json['storage_id'],
      storageRefundAmount: json['storage_refund_amount'],
      tokenStandard: json['token_standard'],
      transactionTimestamp: json['transaction_timestamp'],
      transactionVersion: json['transaction_version'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'asset_type': assetType,
      'block_height': blockHeight,
      'entry_function_id_str': entryFunctionIdStr,
      'event_index': eventIndex,
      'gas_fee_payer_address': gasFeePayerAddress,
      'is_frozen': isFrozen,
      'is_gas_fee': isGasFee,
      'is_transaction_success': isTransactionSuccess,
      'owner_address': ownerAddress,
      'storage_id': storageId,
      'storage_refund_amount': storageRefundAmount,
      'token_standard': tokenStandard,
      'transaction_timestamp': transactionTimestamp,
      'transaction_version': transactionVersion,
      'type': type,
    };
  }
}

class AptosGraphQLAptosName {
  final String? domain;
  final dynamic expirationTimestamp;
  final String? registeredAddress;
  final String? subdomain;
  final String? tokenStandard;
  final bool? isPrimary;
  final String? ownerAddress;
  final dynamic subdomainExpirationPolicy;
  final dynamic domainExpirationTimestamp;

  AptosGraphQLAptosName({
    this.domain,
    this.expirationTimestamp,
    this.registeredAddress,
    this.subdomain,
    this.tokenStandard,
    this.isPrimary,
    this.ownerAddress,
    this.subdomainExpirationPolicy,
    this.domainExpirationTimestamp,
  });

  factory AptosGraphQLAptosName.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLAptosName(
      domain: json['domain'],
      expirationTimestamp: json['expiration_timestamp'],
      registeredAddress: json['registered_address'],
      subdomain: json['subdomain'],
      tokenStandard: json['token_standard'],
      isPrimary: json['is_primary'],
      ownerAddress: json['owner_address'],
      subdomainExpirationPolicy: json['subdomain_expiration_policy'],
      domainExpirationTimestamp: json['domain_expiration_timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'expiration_timestamp': expirationTimestamp,
      'registered_address': registeredAddress,
      'subdomain': subdomain,
      'token_standard': tokenStandard,
      'is_primary': isPrimary,
      'owner_address': ownerAddress,
      'subdomain_expiration_policy': subdomainExpirationPolicy,
      'domain_expiration_timestamp': domainExpirationTimestamp,
    };
  }
}

class AptosGraphQLNumActiveDelegatorPerPool {
  final dynamic numActiveDelegator;
  final String? poolAddress;

  AptosGraphQLNumActiveDelegatorPerPool({
    this.numActiveDelegator,
    this.poolAddress,
  });

  factory AptosGraphQLNumActiveDelegatorPerPool.fromJson(
      Map<String, dynamic> json) {
    return AptosGraphQLNumActiveDelegatorPerPool(
      numActiveDelegator: json['num_active_delegator'],
      poolAddress: json['pool_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num_active_delegator': numActiveDelegator,
      'pool_address': poolAddress,
    };
  }
}

class AptosGraphQLObject {
  final bool allowUngatedTransfer;
  final String stateKeyHash;
  final String ownerAddress;
  final String objectAddress;
  final dynamic lastTransactionVersion;
  final dynamic lastGuidCreationNum;
  final bool isDeleted;

  AptosGraphQLObject({
    required this.allowUngatedTransfer,
    required this.stateKeyHash,
    required this.ownerAddress,
    required this.objectAddress,
    required this.lastTransactionVersion,
    required this.lastGuidCreationNum,
    required this.isDeleted,
  });

  factory AptosGraphQLObject.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLObject(
      allowUngatedTransfer: json['allow_ungated_transfer'],
      stateKeyHash: json['state_key_hash'],
      ownerAddress: json['owner_address'],
      objectAddress: json['object_address'],
      lastTransactionVersion: json['last_transaction_version'],
      lastGuidCreationNum: json['last_guid_creation_num'],
      isDeleted: json['is_deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allow_ungated_transfer': allowUngatedTransfer,
      'state_key_hash': stateKeyHash,
      'owner_address': ownerAddress,
      'object_address': objectAddress,
      'last_transaction_version': lastTransactionVersion,
      'last_guid_creation_num': lastGuidCreationNum,
      'is_deleted': isDeleted,
    };
  }
}

class AptosGraphQLProcessorStatus {
  final dynamic lastSuccessVersion;
  final String processor;
  final dynamic lastUpdated;

  AptosGraphQLProcessorStatus({
    required this.lastSuccessVersion,
    required this.processor,
    required this.lastUpdated,
  });

  factory AptosGraphQLProcessorStatus.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLProcessorStatus(
      lastSuccessVersion: json['last_success_version'],
      processor: json['processor'],
      lastUpdated: json['last_updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_success_version': lastSuccessVersion,
      'processor': processor,
      'last_updated': lastUpdated,
    };
  }
}

class AptosGraphQLTableItem {
  final dynamic decodedKey;
  final dynamic decodedValue;
  final String key;
  final String tableHandle;
  final dynamic transactionVersion;
  final dynamic writeSetChangeIndex;

  AptosGraphQLTableItem({
    required this.decodedKey,
    this.decodedValue,
    required this.key,
    required this.tableHandle,
    required this.transactionVersion,
    required this.writeSetChangeIndex,
  });

  factory AptosGraphQLTableItem.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLTableItem(
      decodedKey: json['decoded_key'],
      decodedValue: json['decoded_value'],
      key: json['key'],
      tableHandle: json['table_handle'],
      transactionVersion: json['transaction_version'],
      writeSetChangeIndex: json['write_set_change_index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'decoded_key': decodedKey,
      'decoded_value': decodedValue,
      'key': key,
      'table_handle': tableHandle,
      'transaction_version': transactionVersion,
      'write_set_change_index': writeSetChangeIndex,
    };
  }
}

class AptosGraphQLTableMetadata {
  final String handle;
  final String keyType;
  final String valueType;

  AptosGraphQLTableMetadata({
    required this.handle,
    required this.keyType,
    required this.valueType,
  });

  factory AptosGraphQLTableMetadata.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLTableMetadata(
      handle: json['handle'],
      keyType: json['key_type'],
      valueType: json['value_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'handle': handle,
      'key_type': keyType,
      'value_type': valueType,
    };
  }
}

class AptosGraphQLTokenActivity {
  final String? afterValue;
  final String? beforeValue;
  final String? entryFunctionIdStr;
  final String eventAccountAddress;
  final dynamic eventIndex;
  final String? fromAddress;
  final bool? isFungibleV2;
  final dynamic propertyVersionV1;
  final String? toAddress;
  final dynamic tokenAmount;
  final String tokenDataId;
  final String tokenStandard;
  final dynamic transactionTimestamp;
  final dynamic transactionVersion;
  final String type;

  AptosGraphQLTokenActivity({
    this.afterValue,
    this.beforeValue,
    this.entryFunctionIdStr,
    required this.eventAccountAddress,
    required this.eventIndex,
    this.fromAddress,
    this.isFungibleV2,
    required this.propertyVersionV1,
    this.toAddress,
    required this.tokenAmount,
    required this.tokenDataId,
    required this.tokenStandard,
    required this.transactionTimestamp,
    required this.transactionVersion,
    required this.type,
  });

  factory AptosGraphQLTokenActivity.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLTokenActivity(
      afterValue: json['after_value'],
      beforeValue: json['before_value'],
      entryFunctionIdStr: json['entry_function_id_str'],
      eventAccountAddress: json['event_account_address'],
      eventIndex: json['event_index'],
      fromAddress: json['from_address'],
      isFungibleV2: json['is_fungible_v2'],
      propertyVersionV1: json['property_version_v1'],
      toAddress: json['to_address'],
      tokenAmount: json['token_amount'],
      tokenDataId: json['token_data_id'],
      tokenStandard: json['token_standard'],
      transactionTimestamp: json['transaction_timestamp'],
      transactionVersion: json['transaction_version'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'after_value': afterValue,
      'before_value': beforeValue,
      'entry_function_id_str': entryFunctionIdStr,
      'event_account_address': eventAccountAddress,
      'event_index': eventIndex,
      'from_address': fromAddress,
      'is_fungible_v2': isFungibleV2,
      'property_version_v1': propertyVersionV1,
      'to_address': toAddress,
      'token_amount': tokenAmount,
      'token_data_id': tokenDataId,
      'token_standard': tokenStandard,
      'transaction_timestamp': transactionTimestamp,
      'transaction_version': transactionVersion,
      'type': type,
    };
  }
}

class AptosGraphQLTokenCollection {
  final String collectionId;
  final String collectionName;
  final String creatorAddress;
  final dynamic currentSupply;
  final String description;
  final dynamic lastTransactionTimestamp;
  final dynamic lastTransactionVersion;
  final dynamic maxSupply;
  final bool? mutableDescription;
  final bool? mutableUri;
  final String? tableHandleV1;
  final String tokenStandard;
  final dynamic totalMintedV2;
  final String uri;

  AptosGraphQLTokenCollection({
    required this.collectionId,
    required this.collectionName,
    required this.creatorAddress,
    required this.currentSupply,
    required this.description,
    required this.lastTransactionTimestamp,
    required this.lastTransactionVersion,
    this.maxSupply,
    this.mutableDescription,
    this.mutableUri,
    this.tableHandleV1,
    required this.tokenStandard,
    this.totalMintedV2,
    required this.uri,
  });

  factory AptosGraphQLTokenCollection.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLTokenCollection(
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      creatorAddress: json['creator_address'],
      currentSupply: json['current_supply'],
      description: json['description'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      lastTransactionVersion: json['last_transaction_version'],
      maxSupply: json['max_supply'],
      mutableDescription: json['mutable_description'],
      mutableUri: json['mutable_uri'],
      tableHandleV1: json['table_handle_v1'],
      tokenStandard: json['token_standard'],
      totalMintedV2: json['total_minted_v2'],
      uri: json['uri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_id': collectionId,
      'collection_name': collectionName,
      'creator_address': creatorAddress,
      'current_supply': currentSupply,
      'description': description,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'last_transaction_version': lastTransactionVersion,
      'max_supply': maxSupply,
      'mutable_description': mutableDescription,
      'mutable_uri': mutableUri,
      'table_handle_v1': tableHandleV1,
      'token_standard': tokenStandard,
      'total_minted_v2': totalMintedV2,
      'uri': uri,
    };
  }
}

class AptosGraphQLTokenData {
  final String collectionId;
  final String description;
  final bool? isFungibleV2;
  final dynamic largestPropertyVersionV1;
  final dynamic lastTransactionTimestamp;
  final dynamic lastTransactionVersion;
  final dynamic maximum;
  final dynamic supply;
  final String tokenDataId;
  final String tokenName;
  final dynamic tokenProperties;
  final String tokenStandard;
  final String tokenUri;
  final dynamic decimals;
  final AptosGraphQLTokenCollection? currentCollection;

  AptosGraphQLTokenData({
    required this.collectionId,
    required this.description,
    this.isFungibleV2,
    this.largestPropertyVersionV1,
    required this.lastTransactionTimestamp,
    required this.lastTransactionVersion,
    this.maximum,
    this.supply,
    required this.tokenDataId,
    required this.tokenName,
    required this.tokenProperties,
    required this.tokenStandard,
    required this.tokenUri,
    this.decimals,
    this.currentCollection,
  });

  factory AptosGraphQLTokenData.fromJson(Map<String, dynamic> json) {
    return AptosGraphQLTokenData(
      collectionId: json['collection_id'],
      description: json['description'],
      isFungibleV2: json['is_fungible_v2'],
      largestPropertyVersionV1: json['largest_property_version_v1'],
      lastTransactionTimestamp: json['last_transaction_timestamp'],
      lastTransactionVersion: json['last_transaction_version'],
      maximum: json['maximum'],
      supply: json['supply'],
      tokenDataId: json['token_data_id'],
      tokenName: json['token_name'],
      tokenProperties: json['token_properties'],
      tokenStandard: json['token_standard'],
      tokenUri: json['token_uri'],
      decimals: json['decimals'],
      currentCollection: json['current_collection'] != null
          ? AptosGraphQLTokenCollection.fromJson(json['current_collection'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection_id': collectionId,
      'description': description,
      'is_fungible_v2': isFungibleV2,
      'largest_property_version_v1': largestPropertyVersionV1,
      'last_transaction_timestamp': lastTransactionTimestamp,
      'last_transaction_version': lastTransactionVersion,
      'maximum': maximum,
      'supply': supply,
      'token_data_id': tokenDataId,
      'token_name': tokenName,
      'token_properties': tokenProperties,
      'token_standard': tokenStandard,
      'token_uri': tokenUri,
      'decimals': decimals,
      'current_collection': currentCollection?.toJson(),
    };
  }
}
