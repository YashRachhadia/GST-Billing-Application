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
	@RequestMapping("/home")
	public String returnhome(Model m) {
		List<Product> all_products= productrepo.findAll();

        m.addAttribute("allProducts",all_products);
        
		return "home";
	}
	@RequestMapping("/billing")
    public String viewBill(Model m)
    {
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
    public String getProduct(@RequestParam("product_code") int prod_code,Model m)
    {
        Product obj  = productrepo.getProductData(prod_code);
        
        if(obj == null){
        	return "billing";
        }
        
        pbycode.add(obj);
        m.addAttribute("result",pbycode);

        return "billing";
    }

    @RequestMapping("getProductByName")
    public String getProductName(@RequestParam("product_name") String prod_name, Model m)
    {
        Product obj  = productrepo.getProductDataByName(prod_name);
        
        if(obj == null){
        	return "billing";
        }
        
        pbyname.add(obj);
        m.addAttribute("result",pbyname);

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
