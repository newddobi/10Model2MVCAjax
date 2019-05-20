package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;

public interface ProductDao {
	
	public void addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public Review getReview(int reviewNo) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public void increaseViewCount(int prodNo) throws Exception;
	
	public void addZzim(Map map) throws Exception;
	
	public void minusAmount(Product product) throws Exception;
	
	public void addReview(Review review) throws Exception;
	
	public List<Product> getProductList(Search search) throws Exception;
	
	public List<Product> getZzimList(Map map) throws Exception;
	
	public List<Review> getReviewList(Map map) throws Exception;
	
	public int getTotalCount3(Map map) throws Exception;
	
	public int getTotalCount2(String userId) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;

	public List getProductList2(String searchCondition) throws Exception;
	
}
