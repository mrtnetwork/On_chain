import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group("spl token meta data", () {
    _accountMetaData();
  });
}

void _accountMetaData() {
  test("SPLTokenMetaDataAccount", () {
    final accountBytes = BytesUtils.fromHexString(
        "2d5b413c6540de150c9373144d5133ca4cb830ba0f756716acea0e50d79435e53c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc040000006e616d650600000073796d626f6c0300000075726902000000040000006b6579310600000076616c756531040000006b6579320600000076616c756532");

    final account = SPLTokenMetaDataAccount.fromBuffer(accountBytes);
    expect(account.updateAuthority?.address,
        "44444444444444444444444444444444444444444444");
    expect(
        account.mint.address, "55555555555555555555555555555555555555555555");
    expect(account.name, "name");
    expect(account.symbol, "symbol");
    expect(account.uri, "uri");
    expect(account.additionalMetadata[0].key, "key1");
    expect(account.additionalMetadata[0].value, "value1");
    expect(account.additionalMetadata[1].key, "key2");
    expect(account.additionalMetadata[1].value, "value2");
    expect(account.toBytes(), accountBytes);
  });
  test("SPLTokenMetaDataAccount_2", () {
    final accountBytes = BytesUtils.fromHexString(
        "00000000000000000000000000000000000000000000000000000000000000003c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc040000006e616d650600000073796d626f6c0300000075726902000000040000006b6579310600000076616c756531040000006b6579320600000076616c756532");

    final account = SPLTokenMetaDataAccount.fromBuffer(accountBytes);
    expect(account.updateAuthority?.address, null);
    expect(
        account.mint.address, "55555555555555555555555555555555555555555555");
    expect(account.name, "name");
    expect(account.symbol, "symbol");
    expect(account.uri, "uri");
    expect(account.additionalMetadata[0].key, "key1");
    expect(account.additionalMetadata[0].value, "value1");
    expect(account.additionalMetadata[1].key, "key2");
    expect(account.additionalMetadata[1].value, "value2");
    expect(account.toBytes(), accountBytes);
  });
  test("SPLTokenMetaDataAccount_3", () {
    final accountBytes = BytesUtils.fromHexString(
        "00000000000000000000000000000000000000000000000000000000000000003c79ac508701281c10c499706716efb8664aeba2bf47341e3be2bdc11f7047dc040000006e616d650600000073796d626f6c0300000075726900000000");

    final account = SPLTokenMetaDataAccount.fromBuffer(accountBytes);
    expect(account.updateAuthority?.address, null);
    expect(
        account.mint.address, "55555555555555555555555555555555555555555555");
    expect(account.name, "name");
    expect(account.symbol, "symbol");
    expect(account.uri, "uri");
    expect(account.additionalMetadata.isEmpty, true);
    expect(account.toBytes(), accountBytes);
  });
}
