package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/commonservice.xml"})
public class PurchaseServiceTest {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	//@Test
	public void testAddPurchase() throws Exception{
		Purchase purchase = new Purchase();
		User user = new User();
		Product product = new Product();
		
		user.setUserId("user01");
		product.setProdNo(10102);
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("�Źμ�");
		purchase.setReceiverPhone("010-1234-4567");
		purchase.setDivyAddr("õ��");
		purchase.setDivyRequest("õõ���Ϳ�");
		purchase.setTranCode("3");
		purchase.setDivyDate("19/04/13");
		
		purchaseService.addPurchase(purchase);
		purchase = purchaseService.getPurchase(10006);
		
		Assert.assertEquals(10037, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user02", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption());
		
	}
	
	//@Test
	public void testGetPurchase() throws Exception{
		
		Purchase purchase = new Purchase();
		
		purchase = purchaseService.getPurchase(10041);

		System.out.println(purchase);
		
		Assert.assertEquals(10102, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("�Źμ�", purchase.getReceiverName());
		
		
		purchase = purchaseService.getPurchase2(10037);

		System.out.println(purchase);
		
		Assert.assertEquals(10040, purchase.getTranNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("������", purchase.getReceiverName());
		
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		
		Purchase purchase = purchaseService.getPurchase(10041);
		
		System.out.println(purchase);

		Assert.assertNotNull(purchase);		
		
		purchase.setReceiverPhone("111-1111-1111");
		purchase.setDivyAddr("����");
		purchase.setPaymentOption("2");
		purchase.setReceiverName("������");
		purchase.setDivyRequest("Ŀ�ǵ� �����Ϳ�");
		purchase.setDivyDate(purchase.getDivyDate());
		
		System.out.println(purchase);

		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(10041);		
				
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals("111-1111-1111", purchase.getReceiverPhone());
		Assert.assertEquals("����", purchase.getDivyAddr());
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("������", purchase.getReceiverName());
		Assert.assertEquals("Ŀ�ǵ� �����Ϳ�", purchase.getDivyRequest());
				
	}
	//@Test
	public void testGetPurchaseListById() throws Exception{
		Search search = new Search();
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = purchaseService.getPurchaseList(search, "user01");
		
		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);

	}
	
	//@Test
	public void testUpdateTranCode() throws Exception{ 
		Purchase purchase = new Purchase();
		
		purchase = purchaseService.getPurchase(10041);
		
		purchaseService.updateTranCode(purchase);
		
		purchase = purchaseService.getPurchase(10041);
		Assert.assertEquals("2", purchase.getTranCode());
		
	}
	
	//@Test
	public void testDeletePurchase() throws Exception{
		
		purchaseService.deletePurchase(10002);
		
	}
}
