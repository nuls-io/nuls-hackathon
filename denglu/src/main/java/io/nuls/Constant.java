package io.nuls;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import io.nuls.controller.vo.Transfer;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-11 20:06
 * @Description: 常量定义
 */
public class Constant {

    /**
     * 创建邮箱地址的交易类型
     */
    public static final int TX_TYPE_CREATE_MAIL_ADDRESS = 200;

    /**
     * 发送邮件的交易类型
     */
    public static final int TX_TYPE_SEND_MAIL = 201;

    /**
     * 黑洞地址
     * 用于接收系统收费
     */
    public static final String BLACK_HOLE_ADDRESS = "tNULSeBaMtsumpXhfEZBU2pMEz7SHLcx5b2TQr";
    
    public static final String AGENCY_PASSWORD = "nuls123456";
    
	public static String getAgencyAddress() {
		
		List<String> agencyAddress = new ArrayList<String>();
		agencyAddress.add("tNULSeBaMhxsMP44CATcgaXsHiNskPWTNaWKgk");
		agencyAddress.add("tNULSeBaMtu9EAsepSgLsLujDfMbeoWXM47dDd");
//		agencyAddress.add("33");
//		agencyAddress.add("44");
//		agencyAddress.add("55");
		
		Random random = new Random();
		int index = random.nextInt(1);
		
		return agencyAddress.get(index);
	}
	
	private static int count = 0;
	private static List<Transfer> transferList = new ArrayList<>();
	
	public static int getTransferCount() {
		return count;
	}
	public static int addCount() {
		return count++;
	}
	public static boolean resetCount() {
		count = 0;
		return true;
	}
	
	public static boolean add(Transfer transfer) {
		transferList.add(transfer);
		return true;
	}
	public static boolean resetList() {
		transferList.clear();
		return true;
	}
	public static List<Transfer> getList() {
		return transferList;
	}
	
	
	
}
