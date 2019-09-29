package io.nuls.contract.token;

import io.nuls.contract.sdk.Address;
import io.nuls.contract.sdk.Event;
import io.nuls.contract.sdk.annotation.Required;
import io.nuls.contract.sdk.annotation.View;

import java.math.BigInteger;

public interface Token {

    @View
    String name();

    @View
    String symbol();

    @View
    int decimals();

    @View
    BigInteger totalSupply();

    @View
    BigInteger balanceOf(@Required Address owner);

    boolean transfer(@Required Address to, @Required BigInteger value);

    boolean transferFrom(@Required Address from, @Required Address to, @Required BigInteger value);

    boolean approve(@Required Address spender, @Required BigInteger value);

    @View
    BigInteger allowance(@Required Address owner, @Required Address spender);

    class TransferEvent implements Event {

        private Address from;

        private Address to;

        private BigInteger value;

        public TransferEvent(Address from, @Required Address to, @Required BigInteger value) {
            this.from = from;
            this.to = to;
            this.value = value;
        }

        public Address getFrom() {
            return from;
        }

        public void setFrom(Address from) {
            this.from = from;
        }

        public Address getTo() {
            return to;
        }

        public void setTo(Address to) {
            this.to = to;
        }

        public BigInteger getValue() {
            return value;
        }

        public void setValue(BigInteger value) {
            this.value = value;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            TransferEvent that = (TransferEvent) o;

            if (from != null ? !from.equals(that.from) : that.from != null) return false;
            if (to != null ? !to.equals(that.to) : that.to != null) return false;
            return value != null ? value.equals(that.value) : that.value == null;
        }

        @Override
        public int hashCode() {
            int result = from != null ? from.hashCode() : 0;
            result = 31 * result + (to != null ? to.hashCode() : 0);
            result = 31 * result + (value != null ? value.hashCode() : 0);
            return result;
        }

        @Override
        public String toString() {
            return "TransferEvent{" +
                    "from=" + from +
                    ", to=" + to +
                    ", value=" + value +
                    '}';
        }

    }

    class VotingTransferEvent implements Event {

        private Address from;

        private Address to;

        private BigInteger value;

        private String transfertype;

        private String votecontractaddr;

        private String introduce;

        private String resource;

        private String md5remark;

        public VotingTransferEvent(Address from, @Required Address to,String transfertype , String votecontractaddr , String introduce , String resource ,String md5remark ,@Required BigInteger value) {
            this.from = from;
            this.to = to;
            this.value = value;
            this.transfertype = transfertype;
            this.votecontractaddr = votecontractaddr;
            this.introduce = introduce;
            this.resource = resource;
            this.md5remark = md5remark;
        }

        public Address getFrom() {
            return from;
        }

        public void setFrom(Address from) {
            this.from = from;
        }

        public Address getTo() {
            return to;
        }

        public void setTo(Address to) {
            this.to = to;
        }

        public BigInteger getValue() {
            return value;
        }

        public void setValue(BigInteger value) {
            this.value = value;
        }

        public String getTransfertype() {
            return transfertype;
        }

        public void setTransfertype(String  transfertype) {
            this.transfertype = transfertype;
        }

        public String getVotecontractaddr() {
            return votecontractaddr;
        }

        public void setVotecontractaddr(String votecontractaddr) {
            this.votecontractaddr = votecontractaddr;
        }

        public String getIntroduce() {
            return  introduce;
        }

        public void setIntroduce(String introduce) {
            this.introduce = introduce;
        }

        public String getResource() {
            return  resource;
        }

        public void setResource(String resource) {
            this.resource = resource;
        }

        public String getMd5remark() {
            return  md5remark;
        }

        public void setMd5remark(String md5remark) {
            this.md5remark = md5remark;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            TransferEvent that = (TransferEvent) o;

            if (from != null ? !from.equals(that.from) : that.from != null) return false;
            if (to != null ? !to.equals(that.to) : that.to != null) return false;
            return value != null ? value.equals(that.value) : that.value == null;
        }

        @Override
        public int hashCode() {
            int result = from != null ? from.hashCode() : 0;
            result = 31 * result + (to != null ? to.hashCode() : 0);
            result = 31 * result + (value != null ? value.hashCode() : 0);
            return result;
        }

        @Override
        public String toString() {
            return "TransferEvent{" +
                    "from=" + from +
                    ", to=" + to +
                    ", value=" + value +
                    ", transfertype=" + transfertype +
                    ", votecontractaddr=" + votecontractaddr +
                    ", introduce=" + introduce +
                    ", resource=" + resource +
                    ", md5remark=" + md5remark +
                    "}";
        }

    }

    class ApprovalEvent implements Event {

        private Address owner;

        private Address spender;

        private BigInteger value;

        public ApprovalEvent(@Required Address owner, @Required Address spender, @Required BigInteger value) {
            this.owner = owner;
            this.spender = spender;
            this.value = value;
        }

        public Address getOwner() {
            return owner;
        }

        public void setOwner(Address owner) {
            this.owner = owner;
        }

        public Address getSpender() {
            return spender;
        }

        public void setSpender(Address spender) {
            this.spender = spender;
        }

        public BigInteger getValue() {
            return value;
        }

        public void setValue(BigInteger value) {
            this.value = value;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            ApprovalEvent that = (ApprovalEvent) o;

            if (owner != null ? !owner.equals(that.owner) : that.owner != null) return false;
            if (spender != null ? !spender.equals(that.spender) : that.spender != null) return false;
            return value != null ? value.equals(that.value) : that.value == null;
        }

        @Override
        public int hashCode() {
            int result = owner != null ? owner.hashCode() : 0;
            result = 31 * result + (spender != null ? spender.hashCode() : 0);
            result = 31 * result + (value != null ? value.hashCode() : 0);
            return result;
        }

        @Override
        public String toString() {
            return "ApprovalEvent{" +
                    "owner=" + owner +
                    ", spender=" + spender +
                    ", value=" + value +
                    '}';
        }

    }

}
