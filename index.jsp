<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.xml.parsers.*,java.io.File,org.w3c.dom.*,java.lang.String.*"%>

<%String cQ =request.getParameter("cafeQuantity");%>
<%if(cQ==null){cQ="0";}%>
<%String sQ =request.getParameter("sugarQuantity");%>
<%if(sQ==null){sQ="0";}%>
<%String wQ =request.getParameter("waterQuantity");%>
<%if(wQ==null){wQ="0";}%>
                                
<%----------------------Parser Tou pricelist.xml-----------------------------%>
<% double[] pricelist = new double[3]; 
    String xmlPath = application.getRealPath("/" + request.getParameter("pricelist.xml"));
    xmlPath=xmlPath.substring(0,xmlPath.length()-4);
    xmlPath=xmlPath+"pricelist.xml";

   File fXmlFile = new File(xmlPath);
   DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
   DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
   Document doc = dBuilder.parse(fXmlFile);
   doc.getDocumentElement().normalize();
   
   NodeList nList = doc.getElementsByTagName("Entry");
		
   for (int temp = 0; temp < nList.getLength(); temp++)
   {
 
        Node nNode = nList.item(temp);
                   
        if (nNode.getNodeType() == Node.ELEMENT_NODE)
        {
            Element eElement = (Element) nNode;
            
            NodeList nlList = eElement.getElementsByTagName("Price").item(0).getChildNodes();
            Node nValue = (Node) nlList.item(0);
            
            pricelist[temp] = Double.parseDouble(nValue.getNodeValue());
        }
    }
%>
<%--Source: http://www.mkyong.com/java/how-to-read-xml-file-in-java-dom-parser/ --%>
<%--Telos Parsing tou pricelist.xml kai apo8ikeusi twn timwn sti metabliti pricelist poy einai pinakas double--%>

            <%--------------Cookies------------%>
<%          Cookie cafeCookie = new Cookie("cafeQuantity",cQ);
            cafeCookie.setMaxAge(30 * 60 * 60);
            Cookie sugarCookie = new Cookie("sugarQuantity",sQ);
            sugarCookie.setMaxAge(30 * 60);
            Cookie waterCookie = new Cookie("waterQuantity",wQ);
            waterCookie.setMaxAge(30 * 60);
           
            response.addCookie(cafeCookie);
            response.addCookie(sugarCookie);
            response.addCookie(waterCookie);
            
            
         
            Cookie[] cookies = request.getCookies();
            
            
            if(cookies != null) {
                
                for(int i = 0; i < cookies.length; i++) {
                    Cookie cookie = cookies[i];
                    if(cookie.getName().equals("cafeQuantity")) {
                        cQ = cookie.getValue();
                    }
                    else if(cookie.getName().equals("sugarQuantity")){
                        sQ=cookie.getValue();
                    }
                    else if(cookie.getName().equals("waterQuantity")){
                        wQ=cookie.getValue();
                        
                    }
               }     
                        
                    
            }
%>


<%------------End of Cookies--------%>
<%--------------------------------------------%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WWW Technologies Project 3</title>
    </head>
    <body>
              <h1>My Shoping Cart</h1>
        <form method="get" action="index.jsp">
            <table border="0" cellpadding="5" width="300">
            <tr>
                <td align="center"><strong>Item</strong></td>
                <td align="center"><strong>Price</strong></td>
                <td align="center"><strong>Quantity</strong></td>
                <td align="center"><strong>Total</strong></td>
                </tr>
            <tr>
                <td align="left">Cafe</td>
                <td><%=pricelist[0]+"€"%></td>
                <td><input type = "text" name="cafeQuantity"  align="right" value="<%=cQ%>"></td>
                <%if(cQ==null){cQ="0";};int cafeQuantity = Integer.parseInt(cQ);%>
                <td align="right"><%double tC=pricelist[0]*cafeQuantity;%><%=tC+"€"%></td>
            </tr>
            <tr>
                <td align="left">Sugar</td>
                <td><%=pricelist[1]+"€"%></td>
                <td><input type="text" name="sugarQuantity" value="<%=sQ%>"></td>
                <%if(sQ==null){sQ="0";};int sugarQuantity = Integer.parseInt(sQ);%>
                <td align="right"><%double tS=pricelist[1]*sugarQuantity;%><%=tS+"€"%></td>
                </tr>
            <tr>
                <td align="left">Water</td>
                <td><%=pricelist[2]+"€"%></td>
                <td><input type="text" name="waterQuantity" value="<%=wQ%>"></td>
                <%if(wQ==null){wQ="0";};int waterQuantity = Integer.parseInt(wQ);%>
                <td align="right"><%double tW=pricelist[2]*waterQuantity;%><%=tW+"€"%></td>
            </tr>
            <tr>
                <td align="left">Total</td>
                <td></td>
                <td></td>
                <td align="right"><%=tC+tS+tW+"€"%></td>
            </tr>
        </table>

            
       <input type="submit" value="Checkout" name="Checkout"/>
      <a href="http://constantinediary.wordpress.com/2011/12/14/my-shopping-cart/" target="_blank">Report</a>
       <a href="http://dl.dropbox.com/u/15863529/cartScript.zip" target="_blank">ShoppingCartWithScriptlet</a>
       <a href="http://dl.dropbox.com/u/15863529/cartBeans.zip" target="_blank">ShoppingCartWithoutScriptlet</a>
        </form>
      </body>
</html>



