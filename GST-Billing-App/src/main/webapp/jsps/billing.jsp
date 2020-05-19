<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Billing Page</title>
        <link href="<c:url value="../css/navbar.css" />" rel="stylesheet">
        <link href="<c:url value="../css/table.css" />" rel="stylesheet">
        <link href="<c:url value="../css/searchbox.css" />" rel="stylesheet">
        <link href="<c:url value="../css/util.css" />" rel="stylesheet">
        <link href="<c:url value="https://fonts.googleapis.com/css2?family=Bree+Serif&display=swap" />" rel="stylesheet">
        <link href="<c:url value="https://fonts.googleapis.com/css2?family=Josefin+Sans:ital@1&family=Righteous&display=swap" />" rel="stylesheet">
        <link href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />" rel="stylesheet">
        <link href="<c:url value="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" />" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script> 
    </head>
    <body>
    <div class="background">
        <div class="topnav">
            <img src="../logo.png" width="150" height="50">
      		<a href="home">Home</a>
      		<a class="active" href="billing">Billing Page</a>
    	</div>
        <h2 style="text-align: center; font-size: 50px">Billing Page</h2>
        <h3 style="text-align: center">Search product by product code/product name</h3>
        <div style="display: flex;align-content: center;justify-content: center;text-align: center">
            <form action="getProductByCode" method="get">
                <br>
                <div class="input-container">
                    <input class="input-field" type="text" placeholder="Product Code" name="product_code">
                    <button type="submit" class="btn btn-secondary"><i class="fa fa-search icon"></i></button>
                </div>
            </form>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <form action="getProductByName" method="get">
                <br>
                <div class="input-container">
                    <input class="input-field" type="text" placeholder="Product Name" name="product_name">
                    <button type="submit" class="btn btn-secondary"><i class="fa fa-search icon"></i></button>
                </div>
            </form>
        </div>
    </div>
    
        <a href="neworder">
            <button class="btn btn-primary" style="padding: 10px; font-size: 18px; margin-left: 715px">New Order</button>
        </a>
        <br>
        <br>
        <h3 style="text-align: center; font-size: 35px"><b>Cart Checkout</b></h3>
        <table>
            <tr>
                <th>Product Code</th>
                <th>Product Name</th>
                <th>Product Price</th>
                <th>GST applied</th>
                <th>Enter Quantity of Product needed</th>
                <th>Price of the Product</th>
            </tr>
            <c:set var = "initial_gst" scope = "session" value = "${0}"/>
            <c:set var = "initial_grand_total" scope = "session" value = "${0}"/>
            <c:forEach items="${result_bycode}" var="item">
                <tr>
                    <td><c:out value="${item.product_code}" /></td>
                    <td><c:out value="${item.product_name}" /></td>
                    <td><c:out value="${item.product_price}" /></td>
                    <td class="all_gst"><c:out value="${item.product_gst}" /></td>
                    <c:set var = "initial_value" scope = "session" value = "${item.product_price*1}"/>
                    <td>
                        <input type="text" id="entry+${item.product_code}" value=1 onkeyup="initTotal(${item.product_price},${item.product_code},${item.product_gst})"/>
                    </td>
                    <td id="price+${item.product_code}" class="price_of_product">${initial_value}</td>
                </tr>
                <c:set var = "initial_grand_total" scope = "session" value = "${initial_grand_total + item.product_price}"/>
            </c:forEach>

            <c:forEach items="${result_byname}" var="item">
                <tr>
                    <td><c:out value="${item.product_code}" /></td>
                    <td><c:out value="${item.product_name}" /></td>
                    <td><c:out value="${item.product_price}" /></td>
                    <td class="all_gst"><c:out value="${item.product_gst}" /></td>
                    <c:set var = "initial_value" scope = "session" value = "${item.product_price*1}"/>
                    <td>
                        <input type="text" id="entry+${item.product_code}" value=1 onkeyup="initTotal(${item.product_price},${item.product_code},${item.product_gst})"/>
                    </td>
                    <td id="price+${item.product_code}" class="price_of_product">${initial_value}</td>
                </tr>
                <c:set var = "initial_grand_total" scope = "session" value = "${initial_grand_total + item.product_price}"/>
            </c:forEach>
            
            <tr>
                <td colspan="4">Total</td>
                <td id="getGst">GST is ${initial_gst}</td>
                <td id="finalTotal">Total Cost is ${initial_grand_total} INR</td>
            </tr>
        </table>
</body>
<script>
    var total_price=0;
    var final_total=0;
    var total_gst = 0;
    // var arr = [];

    function initTotal(product_price,product_code,product_gst)
    {
        var quant=0;
        quant= document.getElementById("entry"+"+"+product_code).value;
        var value= quant*product_price;
        document.getElementById("price"+"+"+product_code).innerHTML=value.toString();

        calculateTotal(product_gst);

    }

    function calculateTotal(product_gst)
    {
        total_price=0;
        total_gst = 0;
        var prices= document.getElementsByClassName("price_of_product");
        var gsts = document.getElementsByClassName("all_gst");
        for(var i=0; i<prices.length; i++)
        {
            var p = parseInt(prices[i].innerHTML);
            var g = parseInt(gsts[i].innerHTML);
            total_price += p;
            total_gst += parseFloat(((p * g)/100).toFixed(2));
        }
       
        final_total = (total_price + parseFloat(total_gst)).toFixed(2);

        document.getElementById("getGst").innerHTML="GST is "+total_gst.toFixed(2) + " INR";
        document.getElementById("finalTotal").innerHTML="Total Cost (including GST) is "+final_total+" INR";

    }


    </script>
</html>
