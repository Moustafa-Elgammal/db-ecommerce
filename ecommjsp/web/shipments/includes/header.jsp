<%
String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);
//out.print(pageName);
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link href="../Design/shipments/css/bootstrap4.css" rel="stylesheet" id="bootstrap-css">
      <script src="../Design/shipments/js/jquery3.2.1.js"></script>

<script src="../Design/shipments/js/bootstrap4.js"></script>
<link type="text/css" href="../Design/shipments/css/fontawesome-all.min.css"  rel="stylesheet">
    <link rel="stylesheet" href="../Design/shipments/css/main.css" />

</head>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.html">Simple Ecommerce</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
            <ul class="navbar-nav m-auto">
                <li class="nav-item <%if(pageName.equals("index.jsp")){out.print("active");}%>">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item <%if(pageName.equals("category.jsp")){out.print("active");}%>">
                    <a class="nav-link" href="category.jsp">Categories <span class="sr-only">(current)</span></a>
                </li>
<!--
                <li class="nav-item <%if(pageName.equals("product.jsp")){out.print("active");}%>">
                    <a class="nav-link" href="product.jsp">Product</a>
                </li>
-->
                <li class="nav-item <%if(pageName.equals("cart.jsp")){out.print("active");}%>">
                    <a class="nav-link" href="cart.jsp">Cart</a>
                </li>
                <li class="nav-item <%if(pageName.equals("contact.jsp")){out.print("active");}%>">
                    <a class="nav-link" href="contact.jsp">Contact</a>
                </li>
            </ul>

            <form action="search.jsp" method="get" class="form-inline my-2 my-lg-0">
                <div class="input-group input-group-sm">
                    <input type="text" name="productName" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary btn-number">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
                <a class="btn btn-success btn-sm ml-3" href="cart.jsp">
                    <i class="fa fa-shopping-cart"></i> Cart
                    <span class="badge badge-light"></span>
                </a>
            </form>
        </div>
    </div>
</nav>
<!--
<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading">E-COMMERCE CATEGORY</h1>
        <p class="lead text-muted mb-0">Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un peintre anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte...</p>
    </div>
</section>
-->
<script>
$("li").click(function() {
      // remove classes from all
      $("li").removeClass("active");
      // add class to the one we clicked
      $(this).addClass("active");
   });


</script>
