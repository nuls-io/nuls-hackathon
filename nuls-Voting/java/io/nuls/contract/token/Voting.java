package io.nuls.contract.token;

import io.nuls.contract.sdk.annotation.Required;
import io.nuls.contract.sdk.annotation.View;


public interface Voting {

    @View
    String detail();

    @View
    String resource();

    @View
    String md5forVotingEvent();
}
