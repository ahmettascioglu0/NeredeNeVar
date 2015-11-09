<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/sweetalert.css" rel="stylesheet" />
    <script src="/js/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" />
    <style>
        html, body {
            height: 100%;
            min-width: 800px;
            position: relative;
        }

        #main, #main > .row {
            height: 100%;
        }

        #mapjs {
            height: 100%;
        }

        a {
            text-decoration: none;
            cursor: pointer;
        }

            a:hover {
                text-decoration: none;
            }
    </style>
    <script>
        var map; var infowindow;
        var marker = new google.maps.Marker();
        var ltlng = [];
        var markers = [];
        var array = [];
        $(document).ready(function InitializeMap() {
            var latlng = new google.maps.LatLng(40.756, -73.986);
            var myOptions =
            {

                center: latlng,
                scrollWheel: false,
                zoom: 13

            };
            map = new google.maps.Map(document.getElementById("info"), myOptions);
            AddMarker();
        });
        function insertmarker() {
            markers = [];
            var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            var labelIndex = 0;
            for (var i = 0; i < ltlng.length; i++) {
                marker = new google.maps.Marker({
                    map: map,
                    position: ltlng[i],
                    draggable: false,
                    title: array[i].split(',')[2].trim(),
                    content: "<div class='text-center'><h4>" + array[i].split(',')[2].trim() + "</h4></div>",
                    id: i,
                    dataid: array[i].split(',')[3].trim()
                });
                google.maps.event.addListener(marker, 'click', function () {
                    // Calling the open method of the infoWindow 
                    ShowPoint(this.dataid);
                });
                markers.push(marker);
            }
        }
        function AddMarker() {


            $.ajax({
                type: "POST",
                url: "Main.aspx/GetData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                cache: false,
                success: function (response) {
                    $("#mapjs").html(response.d);
                },
                error: function (request, status, error) {
                    console.log(error);
                }
            });


            ltlng = [];
            $.ajax({
                type: "POST",
                url: "Main.aspx/GetMarker",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                cache: false,
                success: function (response) {
                    array = response.d;
                    for (var i = 0; i < array.length; i++) {
                        ltlng.push(new google.maps.LatLng(array[i].split(',')[0].trim(), array[i].split(',')[1].trim()));
                    }
                    insertmarker();
                    map.setCenter(new google.maps.LatLng(38.72007260744209, 35.48246383317746));
                    map.setZoom(6);
                },
                error: function (request, status, error) {
                    console.log(error);
                }
            });
        }
    </script>
</head>
<body style="height: 100%">
    <form id="form1" runat="server">
        <nav class="navbar navbar-default" role="navigation" style="margin-bottom: 0; border-radius: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" style="padding: 0" href="http://www.netdata.com">
                    <img class="img-responsive" src="/images/stnFooterLogo.png" alt="Netdata" /></a>
            </div>
            <div class="collapse navbar-collapse" id="navbar-collapse-1">
                <ul class="nav navbar-nav pull-right">
                    <li><a href="Admin.aspx">Yönetim Paneli</a></li>
                </ul>
            </div>
        </nav>

        <div class="container-fluid" id="main">
            <div class="row">
                <div class="col-md-3 col-xs-3" style="margin-top: 2%; position: absolute; height: 100%; overflow-y: scroll">
                    <div class="list-group" id="mapjs">
                    </div>
                </div>
                <div class="col-md-9 col-xs-9" style="margin-top: 2%; position: absolute; margin-left: 25%;height:100%" id="info">
                    <pre class="alert-info">Şehir Seçimi Yaparak Başlayın.</pre>
                    <img class="img-responsive" src="/images/harita.png" alt="Alternate Text" />
                </div>
            </div>
        </div>


        <div class="modal modal-vcenter fade" id="aboutmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Kapat</span></button>
                        <h4 class="modal-title" id="myModalLabel"></h4>
                    </div>
                    <div class="modal-body text-center" id="modalbody">
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" data-dismiss="modal">Kapat</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function ShowPoint(id) {
            $.ajax({
                type: "POST",
                url: "Main.aspx/ShowPoint",
                contentType: "application/json; charset=utf-8",
                data: "{id:'" + id + "'}",
                dataType: "json",
                async: false,
                cache: false,
                success: function (response) {
                    $("#info").html(response.d);
                },
                error: function (request, status, error) {

                }
            });
        }
        function ShowData(data, id) {
            $.ajax({
                type: "POST",
                url: "Main.aspx/ShowData",
                contentType: "application/json; charset=utf-8",
                data: "{data:'" + data + "',id:'" + id + "'}",
                dataType: "json",
                async: false,
                cache: false,
                success: function (response) {
                    $("#modalbody").html(response.d);
                },
                error: function (request, status, error) {

                }
            });
        }
    </script>
</body>
</html>
