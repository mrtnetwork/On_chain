import 'package:on_chain/fil/src/crypto/cid/cid.dart';

import 'types.dart';

class FilNetworkConst {
  static const FilNetworkActorConfig mainnet = FilNetworkActorConfig(
    actors: {
      FilActorNames.multisig: [
        FilActorCid(
          cid: Cid(
            "bafk2bzacebhldfjuy4o5v7amrhp5p2gzv2qo5275jut4adnbyp56fxkwy5fag",
          ),
          version: FilActorVersion.v8,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacec4va3nmugyqjqrs3lqyr2ij67jhjia5frvx7omnh2isha6abxzya",
          ),
          version: FilActorVersion.v9,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceduf3hayh63jnl4z2knxv7cnrdenoubni22fxersc4octlwpxpmy4",
          ),
          version: FilActorVersion.v10,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceafajceqwg5ybiz7xw6rxammuirkgtuv625gzaehsqfprm4bazjmk",
          ),
          version: FilActorVersion.v11,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacecw5lyp3n3t67xdwrmo36h4z7afc3lobmmr6wg55w6yjzg5jhmh42",
          ),
          version: FilActorVersion.v12,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacecr5zqarfqak42xqcfeulsxlavcltawsx2fvc7zsjtby6ti4b3wqc",
          ),
          version: FilActorVersion.v13,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceajcmsngu3f2chk2y7nanlen5xlftzatytzm6hxwiiw5i5nz36bfc",
          ),
          version: FilActorVersion.v14,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaced3csl3buj7chpunsubrhwhchtskx674fpukfen4u6pbpkcheueya",
          ),
          version: FilActorVersion.v15,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceastb65il5j3v2q2pfxgk7brmzh6djzisjo3mfybbiplgy3w7iscm",
          ),
          version: FilActorVersion.v16,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceblf5vqw4dwjueoetgawhg7t6he7qhdnfy3shf7ufnfv4mkwchgbm",
          ),
          version: FilActorVersion.v17,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacecgyiuanstjcdo43xkax274hmyyfiw7ju44uvcyreayonp7r3fmls",
          ),
          version: FilActorVersion.v18,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacecgyiuanstjcdo43xkax274hmyyfiw7ju44uvcyreayonp7r3fmls",
          ),
          version: FilActorVersion.v19,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
      ],
      FilActorNames.paymentchannel: [
        FilActorCid(
          cid: Cid(
            "bafk2bzacebalad3f72wyk7qyilvfjijcwubdspytnyzlrhvn73254gqis44rq",
          ),
          version: FilActorVersion.v8,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacebhdvjbjcgupklddfavzef4e4gnkt3xk3rbmgfmk7xhecszhfxeds",
          ),
          version: FilActorVersion.v9,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceartlg4mrbwgzcwric6mtvyawpbgx2xclo2vj27nna57nxynf3pgc",
          ),
          version: FilActorVersion.v10,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceb4e6cnsnviegmqvsmoxzncruvhra54piq7bwiqfqevle6oob2gvo",
          ),
          version: FilActorVersion.v11,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacectv4cm47bnhga5febf3lo3fq47g72kmmp2xd5s6tcxz7hiqdywa4",
          ),
          version: FilActorVersion.v12,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacebntdhfmyc24e7tm52ggx5tnw4i3hrr3jmllsepv3mibez4hywsa2",
          ),
          version: FilActorVersion.v13,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceavslp27u3f4zwjq45rlg6assj6cqod7r5f6wfwkptlpi6j4qkmne",
          ),
          version: FilActorVersion.v14,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacea3dpsfxw7cnj6zljmjnnaubp43a5kvuausigztmukektesg2flei",
          ),
          version: FilActorVersion.v15,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceanasifggzenhwl5cchnv3rro63mcodpveix6glfkzuwl3qknqn6k",
          ),
          version: FilActorVersion.v16,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceavlvljdoww4v3bp225p6lurcxtdsub4rg33ee6xhvhkyyysnenac",
          ),
          version: FilActorVersion.v17,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacebuw6l22xfht4gv4q5ltk66sy6ibp6ou63wvy6zaiyzievu3cl4v2",
          ),
          version: FilActorVersion.v18,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacebuw6l22xfht4gv4q5ltk66sy6ibp6ou63wvy6zaiyzievu3cl4v2",
          ),
          version: FilActorVersion.v19,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
      ],
    },
  );

  static const FilNetworkActorConfig calibrationnet = FilNetworkActorConfig(
    actors: {
      FilActorNames.multisig: [
        FilActorCid(
          cid: Cid(
            "bafk2bzacec66wmb4kohuzvuxsulhcgiwju7sqkldwfpmmgw7dbbwgm5l2574q",
          ),
          version: FilActorVersion.v8,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacec6gmi7ucukr3bk67akaxwngohw3lsg3obvdazhmfhdzflkszk3tg",
          ),
          version: FilActorVersion.v9,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacebv5gdlte2pyovmz6s37me6x2rixaa6a33w6lgqdohmycl23snvwm",
          ),
          version: FilActorVersion.v10,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacebcb72fmbpocetnzgni2wnbrduamlqx6fl3yelrlzu7id6bu5ib5g",
          ),
          version: FilActorVersion.v11,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacednkwcpw5yzxjceoaliajgupzj6iqxe7ks2ll3unspbprbo5f2now",
          ),
          version: FilActorVersion.v12,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacedbgei6jkx36fwdgvoohce4aghvpohqdhoco7p4thszgssms7olv2",
          ),
          version: FilActorVersion.v13,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacedwx4svscsp6wqqu2vlcunjihvvm4u2jnsqjkwutjhir7dwtl7z6m",
          ),
          version: FilActorVersion.v14,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacean3scmnmvgvyxv44d775ssfwcwghyubqv4dul3ohkvlv3cm2bwui",
          ),
          version: FilActorVersion.v15,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacedtukutyifkwelun4nq7asowfzmdyrefmycc3xphajdlauti2w7zq",
          ),
          version: FilActorVersion.v16,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacecmjfy72xhq726aewdcg5n2ospadxdhvisnclx43ujrg65ujrjwtq",
          ),
          version: FilActorVersion.v17,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacechrsbw65ojbktr63swju5g7275fl3lxminrz7damr4me6wq6fjxm",
          ),
          version: FilActorVersion.v18,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacectb43we4mpxvtejyywdvprwvmvzhhdbxx2kf5tznegntsjamkn7i",
          ),
          version: FilActorVersion.v19,
          supportedMethods: [
            FilMultisigSupportedMethods.construct,
            FilMultisigSupportedMethods.propose,
            FilMultisigSupportedMethods.approveV2,
            FilMultisigSupportedMethods.cancelV2,
            FilMultisigSupportedMethods.addSigner,
            FilMultisigSupportedMethods.removeSigner,
            FilMultisigSupportedMethods.swapSigner,
            FilMultisigSupportedMethods.changeNumApprovalsThreshold,
            FilMultisigSupportedMethods.lockBalance,
            FilMultisigSupportedMethods.fallback,
          ],
        ),
      ],
      FilActorNames.paymentchannel: [
        FilActorCid(
          cid: Cid(
            "bafk2bzaceblot4pemhfgwb3lceellwrpgxaqkpselzbpqu32maffpopdunlha",
          ),
          version: FilActorVersion.v8,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacec4kg3bfjtssvv2b4wizlbdk3pdtrg5aknzgeb3a6rmksgurpynca",
          ),
          version: FilActorVersion.v9,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacea7ngq44gedftjlar3j3ql3dmd7e7xkkb6squgxinfncybfmppmlc",
          ),
          version: FilActorVersion.v10,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceazwhm63kyp47pste5i5acnuhosrgythyagf3kc5clogiqqx6vkzk",
          ),
          version: FilActorVersion.v11,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacebaxhk4itfiuvbftg7kz5zxugqnvdgerobitjq4vl6q4orcwk6wqg",
          ),
          version: FilActorVersion.v12,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceasmgmfsi4mjanxlowsub65fmevhzky4toeqbtw4kp6tmu4kxjpgq",
          ),
          version: FilActorVersion.v13,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacedbit7oo6lryhbo64uikvtjtfcth6oxwy3eebxerenu2h7rj44n24",
          ),
          version: FilActorVersion.v14,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceb3o3ayjxoi5dc3e6ysuyqtcwbas5cvl3mxhxn57ieackjah5dhe6",
          ),
          version: FilActorVersion.v15,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceaftvzd5t2wkmmsgs2lzndoqpb2fkhpzdafnuhxiw2abzzevdc6me",
          ),
          version: FilActorVersion.v16,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacecudlzl2infgft4rxwwvsovts23ri2gi7dbfcblw2uny4y7rcjuni",
          ),
          version: FilActorVersion.v17,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzacecycr25bi4fqwpkrkyiarch3qlhakt6l5linxrs4vpjzv5a3a55rg",
          ),
          version: FilActorVersion.v18,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
        FilActorCid(
          cid: Cid(
            "bafk2bzaceafrj27pyjilccx6mgnfo4io4qa2qhug63zgie6gfhi3r3izzbbu2",
          ),
          version: FilActorVersion.v19,
          supportedMethods: [
            FilPaychSupportedMethods.construct,
            FilPaychSupportedMethods.updateChannelState,
            FilPaychSupportedMethods.settle,
            FilPaychSupportedMethods.collect,
            FilPaychSupportedMethods.fallback,
          ],
        ),
      ],
    },
  );
}
