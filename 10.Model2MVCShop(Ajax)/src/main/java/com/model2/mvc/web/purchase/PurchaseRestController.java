package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/addPurchaseView/{prodNo}")
	public Product addPurchaseView(@PathVariable int prodNo) throws Exception{
		
		System.out.println("/purchase/json/addPurchaseView");
		
		Product product = productService.getProduct(prodNo);
		
		return product;
	}
	
	@RequestMapping(value="json/addPurchase")
	public Purchase addPurchase(@RequestBody Purchase purchase) throws Exception{
		
		System.out.println("/purchase/json/addPurchase");
		
		Product product = new Product();
		
		product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		product.setAmount(product.getAmount() - purchase.getTranAmount());
		productService.minusAmount(product);
	
		purchaseService.addPurchase(purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/getPurchase")
	public Purchase getPurchase(@RequestBody Map map) throws Exception{
		
		System.out.println("/purchase/json/getPurchase");
		
		Purchase purchase;
		
		if(map.get("prodNo") != null) {
			System.out.println("prodNo");
			purchase = purchaseService.getPurchase2((int)map.get("prodNo"));
		}else {
			System.out.println("tranNo");
			purchase = purchaseService.getPurchase((int)map.get("tranNo"));
		}
		
		return purchase;
	}
	
	@RequestMapping(value="json/updatePurchaseView/{tranNo}")
	public Purchase updatePurchaseView(@PathVariable int tranNo) throws Exception{
		
		System.out.println("/purchase/json/updatePurchaseView");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		return purchase;
	}
	
	@RequestMapping(value="json/updatePurchase/{tranNo}")
	public Purchase updatePurchase(@PathVariable int tranNo,
																	@RequestBody Purchase purchase) throws Exception{
		
		System.out.println("/purchase/json/updatePurchase");
		purchase.setTranNo(tranNo);
		purchaseService.updatePurchase(purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/listPurchase")
	public Map<String, Object> listPurchase(@RequestBody Search search,
												HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
			System.out.println("들어온 currentPage 값 :: "+request.getParameter("currentPage"));
			search.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		
		if(request.getParameter("pageCondition") != null && !request.getParameter("pageCondition").equals("")) {
			pageSize = Integer.parseInt(request.getParameter("pageCondition"));
		}else {
			pageSize = 3;
		}
		
		search.setPageSize(pageSize);
		
//		session = request.getSession();
//		User user = (User)session.getAttribute("user");

		User user = new User();
		user.setUserId("user01");
		user.setRole("user");
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println(resultPage);

		map.put("resultPage", resultPage);
		
		return map;
	}
	
	@RequestMapping(value="json/deletePurchase/{tranNo}")
	public Purchase deletePurchase(@PathVariable int tranNo) throws Exception{
		
		System.out.println("/purchase/json/deletePurchase");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchaseService.deletePurchase(tranNo);
		
		return purchase;
	}
	
	@RequestMapping(value="json/updateTranCode")
	public Purchase updateTranCode(@RequestBody Map map) throws Exception{
		
		Purchase purchase = new Purchase();
		Product product = new Product();
		
		purchase.setTranNo((int)map.get("tranNo"));
		purchase.setTranCode((String)map.get("tranCode"));
		
		purchaseService.updateTranCode(purchase);
		
		return purchase;
	}
}
