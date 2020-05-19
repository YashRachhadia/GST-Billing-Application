package com.gst.billing.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gst.billing.dao.ProductRepo;
import com.gst.billing.model.Product;

@Controller
public class ProductController {
	
	@Autowired
	ProductRepo productrepo;
	
	List<Product> pbyname = new ArrayList<>();
	
	List<Product> pbycode = new ArrayList<>();
	
	@RequestMapping("/")
    public String home(Model m)
    {

        List<Product> all_products= productrepo.findAll();

        m.addAttribute("allProducts",all_products);

        return "home";
    }
	@RequestMapping("/neworder")
	public String newOrder(Model m) {
		
		pbycode.clear();
		pbyname.clear();
		m.addAttribute("result_bycode", pbycode);
		m.addAttribute("result_pbyname", pbyname);
		
		return "billing";
	}
	@RequestMapping("/home")
	public String returnhome(Model m) {
		List<Product> all_products= productrepo.findAll();

        m.addAttribute("allProducts",all_products);
        
		return "home";
	}
	
	@RequestMapping("/billing")
    public String viewBill(Model m)
    {
		m.addAttribute("result_bycode", pbycode);
		m.addAttribute("result_byname", pbyname);
		
        return "billing";
    }

    @RequestMapping("addProduct")
    public String addNewProduct(@ModelAttribute("productData") Product prod,Model m)
    {
        productrepo.save(prod);
  
        List<Product> all_products= productrepo.findAll();

        m.addAttribute("allProducts",all_products);
        
        return "home";

    }

    @RequestMapping("getProductByCode")
    public String getProduct(@RequestParam("product_code") int prod_code, Model m)
    {
        Product obj  = productrepo.getProductData(prod_code);
        
        boolean b = true;
    
        if(obj == null){
        	m.addAttribute("result_bycode", pbycode);
    		m.addAttribute("result_byname", pbyname);
        	return "billing";
        }
//        System.out.println(obj.getProduct_code());
        for(int i=0; i<pbycode.size(); i++) {
        	if(pbycode.get(i).getProduct_code() == (obj.getProduct_code())) {
//        		System.out.println("Inside1 " + pbycode.get(i).getProduct_code());
        		b = false;	
        		break;
        	}
        }
//        System.out.println("B1 " + b);
        
        for(int i=0; i<pbyname.size(); i++) {
        	if(pbyname.get(i).getProduct_code() == (obj.getProduct_code())) {
//        		System.out.println("Inside2 " + pbyname.get(i).getProduct_code());
        		b = false;
        		break;
        	}
        }
//        System.out.println("B2 " + b);
        if(b) {
	        pbycode.add(obj);  
        }
        m.addAttribute("result_bycode", pbycode);
        m.addAttribute("result_byname", pbyname);
        return "billing";
    }

    @RequestMapping("getProductByName")
    public String getProductName(@RequestParam("product_name") String prod_name, Model m)
    {
        Product obj  = productrepo.getProductDataByName(prod_name);
        boolean t = true;
        if(obj == null){
        	m.addAttribute("result_bycode", pbycode);
    		m.addAttribute("result_byname", pbyname);
        	return "billing";
        }
        
        for(int i=0; i<pbyname.size(); i++) {
        	if(pbyname.get(i).getProduct_code() == (obj.getProduct_code())) {
        		t = false;
        		break;
        	}
        }
        
        for(int i=0; i<pbycode.size(); i++) {
        	if(pbycode.get(i).getProduct_code() == (obj.getProduct_code())) {
        		t = false;
        		break;
        	}
        }
        if(t){
	        pbyname.add(obj);   
        }
        m.addAttribute("result_byname", pbyname);
        m.addAttribute("result_bycode", pbycode);
        return "billing";
    }

    @RequestMapping("updateProduct")
    public String updateProduct(@RequestParam("product_price") int price,@RequestParam("product_gst") int gst
            ,@RequestParam("product_code")int code,Model m)
    {
        productrepo.updateProductData(price,gst,code);

        List<Product> all_products= productrepo.findAll();

        m.addAttribute("allProducts",all_products);

        return "home";
    }
	
}
