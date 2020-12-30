<?php
require_once 'dbconfig.php';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    // echo "Connected to $dbname at $host successfully.";
} catch (PDOException $pe) {
    die("Could not connect to the database $dbname :" . $pe->getMessage());
}
?>
<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Transport a Transportation Category Bootstrap Responsive
            | Home :: w3layouts</title>

    <!--meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="Transport Responsive  Bootstrap" />
    <script type="application/x-javascript">
        addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
        function hideURLbar(){ window.scrollTo(0,1); }
    </script>
    <!--//meta tags ends here-->

    <!--booststrap-->
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <!--//booststrap end-->
    <!-- font-awesome icons -->
    <link href="css/font-awesome.css" rel="stylesheet">
    <!-- //font-awesome icons -->
    <!--stylesheets-->
    <link href="css/style.css" rel='stylesheet' type='text/css' media="all">
    <link rel="stylesheet" href="css/flexslider.css"
          type="text/css" media="screen" />
    <!-- banner text slider-->
    <!--//style sheet end here-->
    <!-- //lightbox files -->
    <link rel="stylesheet" href="css/lightbox.css">
    <!-- //lightbox files -->
    <link href="//fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
          rel="stylesheet">
    <script type='text/javascript' src='js/jquery-2.2.3.min.js'></script>
</head>

<body>
    <div class="banner-w3">

        <div class="w3-agile-logo">
            <div class="container">
                <div class=" head-wl">
                    <div class="headder-w3">
                        <h1><a href="index.php">Transport</a></h1>
                    </div>

                    <div class="w3-header-top-right-text">
                        <h6 class="caption"> Contact Us</h6>
                        <p>(84) 1900 1228</p>
                    </div>

                    <div class="email-right">
                        <h6 class="caption">Email Us</h6>
                        <p><a href="mailto:mail@example.com" class="info">
                            Transport@gmail.com
                        </a></p>

                    </div>


                    <div class="agileinfo-social-grids">
                        <h6 class="caption">Follow Us</h6>
                        <ul>
                            <li><a href="#">
                                <span class="fa fa-facebook"></span>
                            </a></li>
                            <li><a href="#">
                                <span class="fa fa-twitter"></span>
                            </a></li>
                        </ul>
                    </div>

                    <div class="clearfix"> </div>
                </div>
            </div>
                
        </div>
                <div class="top-nav">
        <nav class="navbar navbar-default navbar-fixed-top">
    
    <!-- //header -->
    <div class="container">
            <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed"
                            data-toggle="collapse" data-target="#navbar"
                            aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav ">
                        <li><a href="index.php" >Home</a></li>
                        <li><a href="#about" class="scroll">About</a></li>
                        <li><a href="#services" class="scroll">Services</a></li>
                        <li><a href="#team" class="scroll">Team</a></li>
                        <li><a href="#gallery" class="scroll">Gallery</a></li>
                        <li><a href="#contact" class="scroll">Contact</a></li>
                    </ul>
                </div>
            
            </div>
            <div class="clearfix"> </div>
            </nav>
        </div>
        <div class="container">
            <!-- header -->
            <header>

                <div class="flexslider-info">
                    <section class="slider">
                        <div class="flexslider">
                            <ul class="slides">
                                <li>
                                    <div class="w3l-info">
                                        <h4>Welcome To Company</h4>
                                        <p>The leading shipping
                                           company in Vietnam.</p>
                                        <div class="w3layouts_more-buttn">
                                            <a href="#" data-toggle="modal"
                                               data-target="#myModal">Read More</a>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="w3l-info">
                                        <h4>Around Vietnam</h4>
                                        <p>Shipping within the country. </p>
                                        <div class="w3layouts_more-buttn">
                                            <a href="#" data-toggle="modal"
                                               data-target="#myModal">Read More</a>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="w3l-info">
                                        <h4>The Best Transport</h4>
                                        <p>Bring the best transportation service
                                           to customers.</p>
                                        <div class="w3layouts_more-buttn">
                                            <a href="#" data-toggle="modal"
                                               data-target="#myModal">Read More</a>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </section>
                </div>
            </header>
        </div>
        <div class="clearfix"> </div>
    </div>

    <!-- //header -->
    <!-- banner-text -->

    <!-- modal -->
    <div class="modal about-modal fade" id="myModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Logistical</h4>
                </div>
                <div class="modal-body">
                    <div class="out-info">
                        <img src="images/b5.jpg" alt="" />
                        <p>
                            Our 35,000 Employees are Committed to Finding You the 
                            Best End-to-End Transport Solutions. A Leader in 
                            Container Shipping and a Stable Partner for Businesses.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- -->
    <!-- //modal -->
    <!-- //banner-text end -->