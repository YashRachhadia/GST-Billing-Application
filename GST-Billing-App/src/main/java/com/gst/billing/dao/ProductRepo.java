package com.gst.billing.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.gst.billing.model.Product;

@Repository
public interface ProductRepo extends JpaRepository<Product, Integer> {
	@Transactional
    @Modifying
    @Query("update Product set product_price=:price, product_gst=:gst where product_code=:code")
    public void updateProductData(@Param("price") int price,@Param("gst") int gst, @Param("code") int code);

    @Query("from Product where product_code=:code")
    public Product getProductData(@Param("code")int prod_code);

    @Query("from Product where product_name=:name")
    public Product getProductDataByName(@Param("name")String name);
}
