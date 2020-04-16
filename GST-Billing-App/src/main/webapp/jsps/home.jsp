<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="../css/main.css" />" rel="stylesheet">
<link href="<c:url value="../css/popupform.css" />" rel="stylesheet">
<link href="<c:url value="../css/navbar.css" />" rel="stylesheet">
<link href="<c:url value="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@600&display=swap" />" rel="stylesheet">
<link href="<c:url value="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" />" rel="stylesheet">
<link href="<c:url value="https://fonts.googleapis.com/css2?family=Signika:wght@700&family=Ubuntu&display=swap" />" rel="stylesheet">
<link href="<c:url value="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="../css/table.css" />" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script> 
<title>Product Mart</title>
</head>
<body>
<div class="topnav">
  <img src="../logo.png" width="150" height="50">
  <a class="active" href="home">Home</a>
  <a href="billing">Billing Page</a>
</div>
<div class="background">
    <div class="page-wrapper p-t-45 p-b-50">
        <div class="wrapper wrapper--w790">
            <div class="card card-5">
                <div class="card-heading">
                    <h2 class="title">Add Product</h2>
                </div>
                <div class="card-body">
                    <form action="addProduct" method="post">
                        <div class="form-row">
                            <div class="name">Product Code</div>
                            <div class="value">
                                <div class="input-group">
                                    <input class="input--style-5" type="text" name="product_code">
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Product Name</div>
                            <div class="value">
                                <div class="input-group">
                                    <input class="input--style-5" type="text" name="product_name">
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Product Price</div>
                            <div class="value">
                                <div class="input-group">
                                    <input class="input--style-5" type="text" name="product_price">
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Product GST(%)</div>
                            <div class="value">
                                <div class="input-group">
                                    <input class="input--style-5" type="text" name="product_gst">
                                </div>
                            </div>
                        </div>
                        <div>
                            <button type="submit" class="btn btn-primary" name="submit">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
    <h2 style="text-align: center; font-family: 'Signika', sans-serif;">All Product Details</h2>

        <table>
            <tr>
                <th>Product Code</th>
                <th>Product Name</th>
                <th>Product Price</th>
                <th>GST applied</th>
                <th>Edit Product Data</th>
            </tr>
            <c:forEach items="${allProducts}" var="item">
                <tr>
                    <td><c:out value="${item.product_code}" /></td>
                    <td><c:out value="${item.product_name}" /></td>
                    <td><c:out value="${item.product_price}" /></td>
                    <td><c:out value="${item.product_gst}" /></td>
                    <td><button type="submit" class="btn btn-secondary" value="Edit" onclick="openForm(${item.product_code})">Edit</button></td>
                </tr>
            </c:forEach>
        </table>
         <div class="form-popup" id="myForm">
			  <form action="updateProduct" class="form-container" method="post">
			    <h2 style="font-size: 25px; font-family: 'Signika', sans-serif;">Update Product Details</h2>
			
			    <label for="ProductCode"><b>Product Code</b></label>
			    <input type="text" id="prod_code" name="product_code">
			    <label for="ProductPrice"><b>Product Price</b></label>
			    <input type="text" name="product_price">
			    <label for="ProductGst"><b>Product GST(%)</b></label>
			    <input type="text" name="product_gst">
			
			    <button type="submit" class="btn btn-primary">Update</button>
			    <button type="button" class="btn btn-danger" onclick="closeForm()">Close</button>
			  </form>
		</div>
</body>
	<script>
        function openForm(product_code) {
        	  document.getElementById("myForm").style.display = "block";
        	  document.getElementById("prod_code").value=product_code;
        }

       	function closeForm() {
       	  document.getElementById("myForm").style.display = "none";
       	}
    </script>
</html>