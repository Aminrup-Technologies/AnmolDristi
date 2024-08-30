<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="apps.aspx.cs" Inherits="AnmolDristi.apps" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="Resources/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Resources/nprogress/nprogress.css" rel="stylesheet" />
    <link href="Resources/custom/custom.css" rel="stylesheet" />
    <style type="text/css">
        .thumbnail {
            text-align: center;
            position: relative;
            overflow: hidden;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .thumbnail .image {
            position: relative;
        }

        .thumbnail .image img {
            display: block;
            margin: 0 auto; /* Centers the image */
        }

        .thumbnail .caption {
            padding: 10px;
            text-align: center; /* Centers the caption text */
        }

        .thumbnail .mask {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            color: #fff;
            opacity: 0;
            transition: opacity 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .thumbnail .mask p {
            margin: 0;
        }

        .thumbnail:hover .mask {
            opacity: 1;
        }

        .thumbnail .tools {
            position: absolute;
            bottom: 10px;
            right: 10px;
        }

        .thumbnail .tools a {
            color: #fff;
            margin-left: 10px;
            font-size: 16px;
        }

        .thumbnail .tools a:hover {
            color: #ddd;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container body">
            <div class="main_container">
                <!-- page content -->
                <div class="right_col" role="main">
                    <div class="">
                        <div class="page-title">
                            <div class="title_left">
                                <h3>Anmol Industries <small>Applications</small> </h3>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>Application <small>Store </small></h2>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">

                                        <div class="row">
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 70%; display: block;" src="WebData/qaqc.png" alt="image" height="100px" />
                                                        <div class="mask">
                                                            <p>Quality Reporting Portal</p>
                                                            <div class="tools tools-bottom">
                                                                <a href="login.aspx"><i class="fa fa-link"></i></a>
                                                                <%--<a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>Quality Reporting</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 70%; display: block;" src="WebData/confbook.png" alt="image" height="100px" />
                                                        <div class="mask">
                                                            <p>Conference Booking</p>
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <%--<a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>Conference Booking</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--<div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask">
                                                            <p>Your Text</p>
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>Snow and Ice Incoming for the South</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask">
                                                            <p>Your Text</p>
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>Snow and Ice Incoming for the South</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask">
                                                            <p>Your Text</p>
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>Snow and Ice Incoming for the South</p>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask no-caption">
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>
                                                            <strong>Image Name</strong>
                                                        </p>
                                                        <p>Snow and Ice Incoming</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask no-caption">
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>
                                                            <strong>Image Name</strong>
                                                        </p>
                                                        <p>Snow and Ice Incoming</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask no-caption">
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>
                                                            <strong>Image Name</strong>
                                                        </p>
                                                        <p>Snow and Ice Incoming</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask no-caption">
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>
                                                            <strong>Image Name</strong>
                                                        </p>
                                                        <p>Snow and Ice Incoming</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-55">
                                                <div class="thumbnail">
                                                    <div class="image view view-first">
                                                        <img style="width: 100%; display: block;" src="images/media.jpg" alt="image" />
                                                        <div class="mask no-caption">
                                                            <div class="tools tools-bottom">
                                                                <a href="#"><i class="fa fa-link"></i></a>
                                                                <a href="#"><i class="fa fa-pencil"></i></a>
                                                                <a href="#"><i class="fa fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="caption">
                                                        <p>
                                                            <strong>Image Name</strong>
                                                        </p>
                                                        <p>Snow and Ice Incoming</p>
                                                    </div>
                                                </div>
                                            </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /page content -->
            </div>
        </div>
    </form>
</body>
</html>
