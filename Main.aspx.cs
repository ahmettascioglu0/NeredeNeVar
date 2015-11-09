using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Main : System.Web.UI.Page
{
    public static string xml = "http://www.netdata.com/XML/7ed30d10";
    public static DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string GetData()
    {
        StringBuilder sb = new StringBuilder();
        ds = new DataSet();
        ds.ReadXml(xml);
        foreach(DataRow row in ds.Tables[0].Rows)
        {
            sb.Append("<a class='list-group-item' onclick=\"ShowPoint('" + row["ID"] + "')\" style='cursor: pointer;'>");
            sb.Append("<span class='badge'>"+row["dc_Plaka_Kodu"]+"</span>");
            sb.Append("<h4 class='list-group-item-heading'>"+row["dc_Il_Adi"]+"</h4>");
            sb.Append("</a>");
        }
        return sb.ToString();
    }
    [WebMethod]
    public static string ShowPoint(string id)
    {
        StringBuilder sb = new StringBuilder();
        var dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "ID='" + id + "'";
        var dt = dv.ToTable();
        foreach(DataRow row in dt.Rows)
        {
            sb.Append("<div class='row' style='padding-left: 15px; padding-right: 15px'>");
            sb.Append("<div class='panel panel-info'>");
            sb.Append("<div class='panel-heading text-center' id='map' style='padding: 10%'>");
            sb.Append("<h3 class='panel-title' style='font-size: 20px'>Harita</h3>");
            sb.Append("<i class='fa fa-map fa-5x'></i></div></div></div>");
            sb.Append("<script>var latlng = new google.maps.LatLng(" + row["dc_Latitude"] + ", " + row["dc_Longitude"] + ");var myOptions ={center: latlng,scrollWheel: false,zoom: 13};var map = new google.maps.Map(document.getElementById('map'), myOptions);</script>");
            sb.Append("<div class='row'>");
            if (row["dc_Ilce"].ToString().Trim().Equals("") && row["dc_Cografya"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Şehir Hakkında</h3>");
                sb.Append("<i class='fa fa-map fa-5x' style='margin-top: 2%'></i></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('About','" + row["ID"] + "')\"><div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Şehir Hakkında</h3>");
                sb.Append("<i class='fa fa-map fa-5x' style='margin-top: 2%'></i></div></div></a></div>");
            }
            if (row["dc_Ne_Yemeli"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Ne Yemeli ?</h3>");
                sb.Append("<i class='fa fa-cutlery fa-5x'></i></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('Food','" + row["ID"] + "')\"><div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Ne Yemeli ?</h3>");
                sb.Append("<i class='fa fa-cutlery fa-5x'></i></div></div></a></div>");
            }
            if (row["dc_Ne_Yapmali"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Ne Yapmalı ?</h3>");
                sb.Append("<i class='fa fa-street-view fa-5x'></i></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('Action','" + row["ID"] + "')\"><div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Ne Yapmalı ?</h3>");
                sb.Append("<i class='fa fa-street-view fa-5x'></i></div></div></a></div>");
            }
            if (row["dc_Havayolu"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Havayolu</h3>");
                sb.Append("<i class='fa fa-plane fa-5x'></i></div></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('Air','" + row["ID"] + "')\"><div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Havayolu</h3>");
                sb.Append("<i class='fa fa-plane fa-5x'></i></div></div></a></div></div>");
            }
            sb.Append("<div class='row'>");
            if (row["dc_Karayolu"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'><div class='panel panel-info'><div class='panel-heading text-center' style='padding: 10%'><h3 class='panel-title' style='font-size: 20px'>Karayolu</h3><i class='fa fa-bus fa-5x'></i></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'><a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('Road','" + row["ID"] + "')\"><div class='panel panel-info'><div class='panel-heading text-center' style='padding: 10%'><h3 class='panel-title' style='font-size: 20px'>Karayolu</h3><i class='fa fa-bus fa-5x'></i></div></div></a></div>");
            }
            if (row["dc_Denizyolu"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Denizyolu</h3>");
                sb.Append("<i class='fa fa-ship fa-5x'></i></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('Sea','" + row["ID"] + "')\"><div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Denizyolu</h3>");
                sb.Append("<i class='fa fa-ship fa-5x'></i></div></div></a></div>");
            }
            if (row["dc_Demiryolu"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Demiryolu</h3>");
                sb.Append("<i class='fa fa-train fa-5x'></i></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('Train','" + row["ID"] + "')\"><div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Demiryolu</h3>");
                sb.Append("<i class='fa fa-train fa-5x'></i></div></div></a></div>");
            }
            if (row["dc_Valilik"].ToString().Trim().Equals("") && row["dc_Belediye"].ToString().Trim().Equals(""))
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Iletişim</h3>");
                sb.Append("<i class='fa fa-phone fa-5x'></i></div></div></div></div>");
            }
            else
            {
                sb.Append("<div class='col-md-3 col-sm-3 col-xs-3'>");
                sb.Append("<a data-toggle='modal' data-target='#aboutmodal' onclick=\"ShowData('Contact','" + row["ID"] + "')\"><div class='panel panel-info'>");
                sb.Append("<div class='panel-heading text-center' style='padding: 10%'>");
                sb.Append("<h3 class='panel-title' style='font-size: 20px'>Iletişim</h3>");
                sb.Append("<i class='fa fa-phone fa-5x'></i></div></div></a></div></div>");
            }
        }
        return sb.ToString();
    }

    [WebMethod]
    public static string ShowData(string data,string id)
    {
        StringBuilder sb = new StringBuilder();
        var dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "ID='" + id + "'";
        var dt = dv.ToTable();
        if(dt.Rows.Count>0)
        {
            switch(data)
            {
                case "About":
                    sb.Append("<h5 class='text-center'>Ilçeler</h5><hr/>" + dt.Rows[0]["dc_Ilce"] + "<hr/><h5 class='text-center'>Hakkında</h5><hr/>" + dt.Rows[0]["dc_Cografya"]);
                    sb.Append("<script>$('#myModalLabel').html('Şehir Hakkında');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
                case "Food":
                    sb.Append(dt.Rows[0]["dc_Ne_Yemeli"] + "");
                    sb.Append("<script>$('#myModalLabel').html('Ne Yemeli?');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
                case "Air":
                    sb.Append(dt.Rows[0]["dc_Havayolu"] + "");
                    sb.Append("<script>$('#myModalLabel').html('Havayolu Ulaşımı');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
                case "Action":
                    sb.Append(dt.Rows[0]["dc_Ne_Yapmali"] + "");
                    sb.Append("<script>$('#myModalLabel').html('Ne Yapmalı?');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
                case "Road":
                    sb.Append(dt.Rows[0]["dc_Karayolu"] + "");
                    sb.Append("<script>$('#myModalLabel').html('Karayolu Ulaşımı');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
                case "Sea":
                    sb.Append(dt.Rows[0]["dc_Denizyolu"] + "");
                    sb.Append("<script>$('#myModalLabel').html('Denizyolu Ulaşımı');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
                case "Train":
                    sb.Append(dt.Rows[0]["dc_Demiryolu"] + "");
                    sb.Append("<script>$('#myModalLabel').html('Demiryolu Ulaşımı');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
                case "Contact":
                    sb.Append("<h5 class='text-center'>Valilik</h5>" + dt.Rows[0]["dc_Valilik"] + "<hr/><h5 class='text-center'>Belediye</h5>" + dt.Rows[0]["dc_Belediye"]);
                    sb.Append("<script>$('#myModalLabel').html('İletişim Bilgileri');$('#myModalLabel').attr('class','text-center')</script>");
                    break;
            }
        }
        return sb.ToString();
    }
    [WebMethod]
    public static string[] GetMarker()
    {
        string[] data = new string[ds.Tables[0].Rows.Count];
        int i = 0;
        foreach (DataRow row in ds.Tables[0].Rows)
        {
            data[i] = row["dc_Latitude"].ToString() + "," + row["dc_Longitude"].ToString() + "," + row["dc_Il_Adi"] + "," + row["ID"];
            i++;
        }
        return data;
    }
}