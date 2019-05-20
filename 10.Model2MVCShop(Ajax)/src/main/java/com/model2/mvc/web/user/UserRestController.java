package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;


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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/addUser", method=RequestMethod.POST)
	public User addUser( @RequestBody User user) throws Exception{
		
		System.out.println("/user/json/addUser : POST");
		
		userService.addUser(user);
		
		return user;
		
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("user ::"+user);
		User dbUser=userService.getUser(user.getUserId());
		System.out.println("dbuser ::"+dbUser);
		
		if(dbUser != null) {
			if(user.getPassword().equals(dbUser.getPassword())){
				System.out.println("test1");
				session.setAttribute("user", dbUser);
			}else {
				System.out.println("test2");
				dbUser = new User();
			}
		}else {
			dbUser = new User();
		}
		return dbUser;
	}
	
	@RequestMapping( value = "json/updateUser/{userId}", method=RequestMethod.GET)
	public User updateUser( @PathVariable String userId) throws Exception{
	
		System.out.println("/user/json/updateUser : GET");
		
		return userService.getUser(userId);
	}
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST)
	public User updateUser(@RequestBody User user, HttpSession session) throws Exception {
		
		System.out.println("/user/json/updateUser : POST");
		
		userService.updateUser(user);

		return userService.getUser(user.getUserId());
		
	}
	
	@RequestMapping( value="json/logout", method=RequestMethod.GET)
	public void logout(HttpSession session) throws Exception{
		
		System.out.println("/user/json/logout : GET");
		
		session.invalidate();
	}
	
	@RequestMapping( value="json/checkDuplication/{userId}", method=RequestMethod.GET)
	public Map checkDuplication(@PathVariable String userId) throws Exception{
		
		System.out.println("/user/json/checkDuplication : POST");
		
		boolean result = userService.checkDuplication(userId);
		
		Map map = new HashMap<String, Object>();
		map.put("result", new Boolean(result));
		map.put("userId", userId);
		
		return map;
		
	}
	
	@RequestMapping( value="json/listUser")
	public Map<String, Object> lisetUser(@RequestBody Search search) throws Exception{
		
		System.out.println("/user/json/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		System.out.println("map :: "+map);
		return map;
		
	}
	
}