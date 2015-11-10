Nerede Ne Var Uygulaması
=============
Bu uygulamayla Türkiye üzerinde bulunan bütün şehirlerin bilgilerini görüntüleyebilirsiniz. Veriler netdata.com üzerinden xml olarak çekilmektedir.

Bu çalışmanın amacı netdata üzerinden yapabileceklerinizin bir sınırının olmadığını göstermektir.
Eğer netdata üzerinde bir projeniz varsa dışardan bu projenize erişip ekleme/silme/güncelleme gibi işlemleri netdata'ya bağlı kalmaksızın yazdığınız uygulama içerisinde gerçekleştirebilirsiniz.

Netdata üzerinden veri çekme
=============
Netdata size birden fazla veri çekme yöntemi sunmaktadır. XML,JSON,SOAP Webservice ve IFRAME size sunduğumuz veri çekme yöntemleridir. Ayrıca verilerinizi URL bazlı filtreleme yaparak dilediğiniz sql sorgularını yazabilir ve sorgu sonucu üretilen verileri uygulamanızda kullanabilirsiniz. Nerede Ne Var uygulaması için Main.aspx ve Admin.aspx sayfalarında XML türünden veriler çektik. Eğer bir projeniz varsa ve dışardan erişime açtıysanız tek yapmanız gereken uygun veri çekme formatını seçmek.

AccPo ile Projeye Veri Ekleme / Silme / Güncelleme
=============
Netdata'nın sizlere sunduğu çözümlerden bir taneside AccPo ile verilerinizi dışardan göndereceğiniz bir WebRequest ile değiştirebilmektir. Aşağıda AccPo'nun örnek kullanımı yer almaktadır.

Veri Ekleme
-------
```
POST /AccPo.asmx HTTP/1.1
Host: www.netdata.com
Content-Type: text/xml; charset=utf-8
Content-Length: length
SOAPAction: "http://tempuri.org/InsertRecord"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <InsertRecord xmlns="http://tempuri.org/">
      <APIKey>string</APIKey>
      <InsertList>
        <AccPoKeyValuePair>
          <Key>dc_Plaka_Kodu</Key>
          <Value>string</Value>
        </AccPoKeyValuePair>
      </InsertList>
    </InsertRecord>
  </soap:Body>
</soap:Envelope>
```
Bu kod sayesinde bir Request oluşturup verilerinizi uygulamanız üzerinden ekleyebilirsiniz. Bunun için tek yapmanız gereken projenizi dışardan erişime açmak ve bir AccPo API KEY oluşturmaktır. Aşağıda ASP.NET içerisinde verinin nasıl eklenildiğine dair bir kod bulacaksınız.

```
HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create("http://www.netdata.com/AccPo.asmx");
        webRequest.Headers.Add(@"SOAP:Action:http://tempuri.org/InsertRecord");
        webRequest.ContentType = "text/xml;charset=\"utf-8\"";
        webRequest.Accept = "text/xml";
        webRequest.Method = "POST";
        XmlDocument soapEnvelopeXml = new XmlDocument();
        string envelope = "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><InsertRecord xmlns='http://tempuri.org/'><APIKey>string</APIKey><InsertList><AccPoKeyValuePair>" //AccPo API KEY
            + "<Key>dc_Plaka_Kodu</Key><Value>" + array[0] + "</Value></AccPoKeyValuePair>"
            + "<AccPoKeyValuePair><Key>dc_Il_Adi</Key><Value>" + array[1] + "</Value></AccPoKeyValuePair>"
            + "<AccPoKeyValuePair><Key>dc_Yuzolcumu</Key><Value>" + array[2] + "</Value></AccPoKeyValuePair>"
            + "</InsertList></InsertRecord></soap:Body></soap:Envelope>";
        soapEnvelopeXml.LoadXml(envelope);

        using (Stream stream = webRequest.GetRequestStream())
        {
            soapEnvelopeXml.Save(stream);
        }
        WebResponse response = webRequest.GetResponse();
```
Veri Güncelleme
-------
AccPo sayesinde ekleme yapabildiğiniz gibi güncelleme işlemlerinide yalnızca bir Request ile gerçekleştirebilirsiniz. Projeniz için bir AccPo oluşturduktan sonra aşağıdaki kod size verilecektir. Bu kod sayesinde ID parametresiyle belirlenen satırın bir sütununu değiştirebilirsiniz. Birden fazla sütunda değişiklik yapmak isterseniz tek yapmanız gereken dinamik bir request oluşturmak.
```
POST /AccPo.asmx HTTP/1.1
Host: www.netdata.com
Content-Type: text/xml; charset=utf-8
Content-Length: length
SOAPAction: "http://tempuri.org/UpdateRecord"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <UpdateRecord xmlns="http://tempuri.org/">
      <APIKey>string</APIKey>
      <IDNumber>string</IDNumber>
      <UpdateFieldName>string</UpdateFieldName>
      <UpdateFieldNewValue>string</UpdateFieldNewValue>
    </UpdateRecord>
  </soap:Body>
</soap:Envelope>
```
Asp.NET Kullanımı
-------
```
HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create("http://www.netdata.com/AccPo.asmx");
        webRequest.Headers.Add(@"SOAP:Action:http://tempuri.org/UpdateRecord");
        webRequest.ContentType = "text/xml;charset=\"utf-8\"";
        webRequest.Accept = "text/xml";
        webRequest.Method = "POST";
        XmlDocument soapEnvelopeXml = new XmlDocument();

        string envelope = "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
          + "<soap:Body>"
          + "<UpdateRecord xmlns='http://tempuri.org/'>"
          + "<APIKey>string</APIKey>"  //AccPo API KEY
          + "<IDNumber>"+id+"</IDNumber>"
          + "<UpdateFieldName>"+column+"</UpdateFieldName>"
          + "<UpdateFieldNewValue>"+value+"</UpdateFieldNewValue>"
          + "</UpdateRecord>"
          + "</soap:Body>"
          + "</soap:Envelope>";
        soapEnvelopeXml.LoadXml(envelope);

        using (Stream stream = webRequest.GetRequestStream())
        {
            soapEnvelopeXml.Save(stream);
        }
        WebResponse response = webRequest.GetResponse();
```

Veri Silme
-------
AccPo ile veri silmek ekleme ve güncelleme gibidir. Projeniz için bir AccPo oluşturmanız ve uygulamanız içerisinde aşağıdaki kod bloğunu bize request olarak göndermeniz yeterlidir.

```
POST /AccPo.asmx HTTP/1.1
Host: www.netdata.com
Content-Type: text/xml; charset=utf-8
Content-Length: length
SOAPAction: "http://tempuri.org/DeleteRecord"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <DeleteRecord xmlns="http://tempuri.org/">
      <APIKey>string</APIKey>
      <IDNumber>string</IDNumber>
    </DeleteRecord>
  </soap:Body>
</soap:Envelope>
```

Asp.NET Kullanımı
-------
```
HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create("http://www.netdata.com/AccPo.asmx");
        webRequest.Headers.Add(@"SOAP:Action:http://tempuri.org/DeleteRecord");
        webRequest.ContentType = "text/xml;charset=\"utf-8\"";
        webRequest.Accept = "text/xml";
        webRequest.Method = "POST";
        XmlDocument soapEnvelopeXml = new XmlDocument();

       string envelope=@"<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>
        <soap:Body>
        <DeleteRecord xmlns='http://tempuri.org/'>
        <APIKey>string</APIKey>
        <IDNumber>ID</IDNumber>
        </DeleteRecord>
        </soap:Body>
        </soap:Envelope>";
       soapEnvelopeXml.LoadXml(envelope);

       using (Stream stream = webRequest.GetRequestStream())
       {
           soapEnvelopeXml.Save(stream);
       }
       WebResponse response = webRequest.GetResponse();
```

