using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class Admin : System.Web.UI.Page
{
    public static string xml = "http://www.netdata.com/XML/7ed30d10";
    public static DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string GetData()
    {
        ds = new DataSet();
        ds.ReadXml(xml);
        StringBuilder sb = new StringBuilder();
        sb.Append("<thead><tr><th>" + ds.Tables[0].Columns[0].ColumnName + "</th><th>" + ds.Tables[0].Columns[1].ColumnName + "</th><th>" + ds.Tables[0].Columns[2].ColumnName + "</th><th>" + ds.Tables[0].Columns[3].ColumnName + "</th><th></th></tr></thead>");
        foreach (DataRow row in ds.Tables[0].Rows)
        {
            sb.Append("<tbody><tr><td>" + row[0] + "</td><td>" + row[1] + "</td><td>" + row[2] + "</td><td>" + row[3] + "</td>");
            sb.Append("<td class='text-center'><div class='btn-group'><a onclick=\"EditData('" + row["ID"] + "')\" class='btn btn-warning btn-sm'>Düzenle</a><a onclick=\"DeleteData('" + row["ID"] + "','" + row["dc_Il_Adi"] + "')\" class='btn btn-danger btn-sm'>Sil</a></div></td></tr>");
            sb.Append("</tbody>");
        }
        return sb.ToString();
    }
    [WebMethod]
    public static string[] GetModalData(string id)
    {

        var dv = ds.Tables[0].DefaultView;
        dv.RowFilter = "ID='" + id + "'";
        var dt = dv.ToTable();
        string[] array = new string[dt.Columns.Count];
        for (int i = 0; i < dt.Columns.Count; i++)
        {
            array[i] = dt.Rows[0][i].ToString();
        }
        return array;
    }

}