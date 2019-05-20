package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public Product addProduct(@RequestBody Product product) throws Exception{
		
		System.out.println("/product/json/addProduct : POST");
		
		productService.addProduct(product);
		System.out.println(product);
		return product;
	}
	
	@RequestMapping(value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Product getProduct(@PathVariable int prodNo) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");
		
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping(value="json/updateProductView", method=RequestMethod.POST)
	public Product updateProductView(@RequestBody Product product) throws Exception{
		
		System.out.println("/product/updateProductView");
		
		Product product01 = productService.getProduct(product.getProdNo());
		
		return product01;
	}
	
	@RequestMapping(value="json/updateProduct")
	public Product updateProduct(@RequestBody Product product) throws Exception{
		
		System.out.println("/product/updateProduct");
		
		productService.updateProduct(product);
		
		return productService.getProduct(product.getProdNo());
	}
	
	@RequestMapping(value="json/listZzim")
	public Map<String, Object> listZzim(@RequestBody Search search,
												HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/product/listZzim");
		
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
		
		System.out.println("search : "+search);
		
//		String userId=((User)session.getAttribute("user")).getUserId();
		String userId = "user01";
		
		Map<String, Object> map = new HashMap();
		map.put("search", search);
		map.put("userId", userId);
		
		System.out.println("map : "+map);
		
		// Business logic 수행
		map=productService.getZzimList(map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		System.out.println(map);
		
		return map;
		
	}
	
	@RequestMapping(value="json/listProduct")
	public Map<String, Object> listProduct(@RequestBody Search search,
												HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/product/json/listProduct");
		
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
		System.out.println("search : "+search);
		search.setPageSize(pageSize);
		System.out.println("search : "+search);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value="json/listProduct2/{searchCondition}")
	public List<String> listProduct2(@PathVariable String searchCondition ) throws Exception{
		
		System.out.println("/product/json/listProduct2");
		System.out.println(searchCondition);
		
		return productService.getProductList2(searchCondition);
	}
	
	@RequestMapping(value="json/addZzim", method=RequestMethod.POST)
	public Product addZzim(@RequestBody Map map) throws Exception{
		
		System.out.println("/product/json/addZzim : POST");
		
		Product product = productService.getProduct((int)map.get("prodNo"));
		
		Map map1 = new HashMap<String, Object>();
		map1.put("product", product);
		map1.put("userId", (String)map.get("userId"));
		
		productService.addZzim(map1);
		
		return product;
	}
	
	@RequestMapping(value="json/getReview/{reviewNo}")
	public Review getReview(@PathVariable int reviewNo) throws Exception{
		
		System.out.println("/product/json/getReview");
		
		Review review = productService.getReview(reviewNo);
		
		return review;
	}
	
	
}
