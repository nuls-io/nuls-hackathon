/*
 * MIT License
 *
 * Copyright (c) 2017-2018 nuls.io
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

package io.nuls.rpctools.vo;

import java.util.List;


/*
 * 账户类已经有四个字段，直接返回的Account的实例就行
 */
public class Account {
	
	private List<String> addressList; 
	
    /**
     * 账户地址
     */
    private String address;

    /**
     * 别名
     */
    private String alias;

    /**
     * 公钥Hex.encode(byte[])
     */
    private String pubkeyHex;


    /**
     * 已加密私钥Hex.encode(byte[])
     */
    private String encryptedPrikeyHex;

    public Account() {

    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getPubkeyHex() {
        return pubkeyHex;
    }

    public void setPubkeyHex(String pubkeyHex) {
        this.pubkeyHex = pubkeyHex;
    }

    public String getEncryptedPrikeyHex() {
        return encryptedPrikeyHex;
    }

    public void setEncryptedPrikeyHex(String encryptedPrikeyHex) {
        this.encryptedPrikeyHex = encryptedPrikeyHex;
    }

	public List<String> getAddressList() {
		return addressList;
	}

	public void setAddressList(List<String> addressList) {
		this.addressList = addressList;
	}

}
