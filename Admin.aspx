<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/sweetalert.css" rel="stylesheet" />
    <script src="/js/jquery-1.11.3.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" />
    <script src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.9/css/jquery.dataTables.min.css" rel="stylesheet" />
    <style>
        html, body {
            height: 100%;
            min-width: 800px;
            overflow-y: scroll;
            position: relative;
        }
    </style>
</head>
<body>
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
                    <li><a href="Main.aspx">Anasayfa</a></li>
                </ul>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="btn-group pull-right">
                    <a class="btn btn-info btn-md" onclick="FocusDataDiv();Clear()">Yeni Kayıt Ekle</a>
                </div>
            </div>
            <div class="row" style="margin-top: 2%">
                <div class="col-md-offset-1 col-md-10">
                    <div class="panel panel-default" style="max-height: 500px; overflow-y: scroll">
                        <div class="panel-body">
                            <table class="table table-bordered table-striped table-responsive" id="DataGrid">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" id="data">
                <div class="col-md-offset-1 col-md-10">
                    <div class="panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Plaka Kodu</span>
                                        <input type='text' class='form-control' id='dc_Plaka_Kodu' aria-describedby='basic-addon3' />
                                    </div>
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>İl Adı</span>
                                        <input type='text' class='form-control' id='dc_Il_Adi' aria-describedby='basic-addon3' />
                                    </div>
                              
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Yüzölçümü </span>
                                        <input type='text' class='form-control' id='dc_Yuzolcumu' aria-describedby='basic-addon3' />
                                    </div>
                               
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Telefon Kodu </span>
                                        <input type='text' class='form-control' id='dc_Telefon_Kodu' aria-describedby='basic-addon3' />
                                    </div>
                               
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>İlçe </span>
                                        <input type='text' class='form-control' id='dc_Ilce' aria-describedby='basic-addon3' />
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Valilik</span>
                                        <input type='text' class='form-control' id='dc_Valilik' aria-describedby='basic-addon3' />
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Belediye</span>
                                        <input type='text' class='form-control' id='dc_Belediye' aria-describedby='basic-addon3' />
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Harita Bilgisi (Enlem)</span>
                                        <input type='text' class='form-control' id='dc_Latitude' aria-describedby='basic-addon3' />
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Harita Bilgisi (Boylam)</span>
                                        <input type='text' class='form-control' id='dc_Longitude' aria-describedby='basic-addon3' />
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Coğrafya </span>
                                        <textarea class="form-control" id="dc_Cografya" style="max-height: 100px; resize: none;" aria-describedby='basic-addon3'></textarea>
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Ne Yemeli </span>
                                        <textarea class="form-control" id="dc_Ne_Yemeli" style="max-height: 100px; resize: none;" aria-describedby='basic-addon3'></textarea>
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Ne Yapmalı </span>
                                        <textarea class="form-control" id="dc_Ne_Yapmali" style="max-height: 100px; resize: none;" aria-describedby='basic-addon3'></textarea>
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Karayolu </span>
                                        <textarea class="form-control" id="dc_Karayolu" style="max-height: 100px; resize: none;" aria-describedby='basic-addon3'></textarea>
                                    </div>
                                
                                
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Havayolu </span>
                                        <textarea class="form-control" id="dc_Havayolu" style="max-height: 100px; resize: none;" aria-describedby='basic-addon3'></textarea>
                                    </div>
                               
                               
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Demiryolu </span>
                                        <textarea class="form-control" id="dc_Demiryolu" style="max-height: 100px; resize: none;" aria-describedby='basic-addon3'></textarea>
                                    </div>
                                
                              
                                    <div class='input-group' style='padding:1%'>
                                        <span class='input-group-addon' style='min-width:170px' id='basic-addon3'>Denizyolu </span>
                                        <textarea class="form-control" id="dc_Denizyolu" style="max-height: 100px; resize: none;" aria-describedby='basic-addon3'></textarea>
                                    </div>
                                
                                <span class="hidden" id="dataid"></span>
                                <div class="col-md-offset-3 col-md-6 text-center" style="margin-top: 1%">
                                    <div class="btn-group">
                                        <a class="btn btn-success btn-md" id="btnkayit" onclick="SaveData()">Kaydet</a>
                                        <a class="btn btn-success btn-md" id="btnguncelle" onclick="UpdateData()">Güncelle</a>
                                        <a onclick="Clear()" class="btn btn-danger btn-md">Temizle</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        var array = [];
        function GetData() {
            $.ajax({
                type: "POST",
                url: "Admin.aspx/GetData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                cache: false,
                success: function (response) {
                    $("#DataGrid").html(response.d);
                    $('html, body').animate({ scrollTop: $('#DataGrid').offset().top }, 'slow');
                },
                error: function (request, status, error) {
                    console.log(error);
                }

            });
        }
        $(document).ready(function () {
            GetData();
            $("#btnkayit").show();
            $("#btnguncelle").hide();
        });
        function EditData(id) {
            $.ajax({
                type: "POST",
                url: "Admin.aspx/GetModalData",
                contentType: "application/json; charset=utf-8",
                data: "{id:'" + id + "'}",
                dataType: "json",
                async: true,
                cache: false,
                success: function (response) {
                    $("#btnguncelle").show();
                    $("#btnkayit").hide();
                    FocusDataDiv();
                    array = response.d;
                    $("#dc_Plaka_Kodu").val(array[1]);
                    $("#dc_Il_Adi").val(array[2]);
                    $("#dc_Yuzolcumu").val(array[3]);
                    $("#dc_Telefon_Kodu").val(array[4]);
                    $("#dc_Ilce").val(array[5]);
                    $("#dc_Cografya").val(array[6]);
                    $("#dc_Ne_Yemeli").val(array[7]);
                    $("#dc_Ne_Yapmali").val(array[8]);
                    $("#dc_Karayolu").val(array[9]);
                    $("#dc_Havayolu").val(array[10]);
                    $("#dc_Demiryolu").val(array[11]);
                    $("#dc_Denizyolu").val(array[12]);
                    $("#dc_Valilik").val(array[13]);
                    $("#dc_Belediye").val(array[14]);
                    $("#dc_Latitude").val(array[15]);
                    $("#dc_Longitude").val(array[16]);
                    $("#dataid").text(id);
                },
                error: function (request, status, error) {
                    console.log(error);
                }
            });
        }
        function Clear() {
            $("#dc_Plaka_Kodu").val("");
            $("#dc_Il_Adi").val("");
            $("#dc_Yuzolcumu").val("");
            $("#dc_Telefon_Kodu").val("");
            $("#dc_Ilce").val("");
            $("#dc_Cografya").val("");
            $("#dc_Ne_Yemeli").val("");
            $("#dc_Ne_Yapmali").val("");
            $("#dc_Karayolu").val("");
            $("#dc_Havayolu").val("");
            $("#dc_Demiryolu").val("");
            $("#dc_Denizyolu").val("");
            $("#dc_Valilik").val("");
            $("#dc_Belediye").val("");
            $("#dc_Latitude").val("");
            $("#dc_Longitude").val("");
            $("#btnkayit").show();
            $("#btnguncelle").hide();
        }
        function SaveData() {
            swal({
                title: "Demo Uygulama Olduğu İçin Değişiklik Yapamazsınız!",
                text: "Netdata",
                type: "warning",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "OK",
                closeOnConfirm: true
            });
        }
        function FocusDataDiv() {
            $('html, body').animate({ scrollTop: $('#data').offset().top }, 'slow');
        }
        function UpdateData() {
            swal({
                title: "Demo Uygulama Olduğu İçin Değişiklik Yapamazsınız!",
                text: "Netdata",
                type: "warning",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "OK",
                closeOnConfirm: true
            });
        }
        function DeleteData(id, name) {
            swal({
                title: "Demo Uygulama Olduğu İçin Değişiklik Yapamazsınız!",
                text: "Netdata",
                type: "warning",
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "OK",
                closeOnConfirm: true
            });
        }
    </script>
</body>
</html>
