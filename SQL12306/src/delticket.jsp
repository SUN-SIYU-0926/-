<%--
  Created by IntelliJ IDEA.
  User: Alienware
  Date: 2020/12/1
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.sql.Connection,
java.sql.DriverManager,
java.sql.Statement,
java.sql.ResultSet,
java.sql.SQLException,
java.util.Random,
java.sql.*" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>身份验证</title>
</head>
<body>
<body>
<%
    String uid=request.getParameter("userid");
    String upassword=request.getParameter("password");
    String ticket=request.getParameter("ticketnum");
    out.println("开始");
    try {
        // 加载数据库驱动，注册到驱动管理器
        Class.forName("com.mysql.jdbc.Driver");
        // 数据库连接字符串
        String url = "jdbc:mysql://localhost:3306/wanli_12306?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
        // 数据库用户名
        String usename = "root";
        // 数据库密码
        String psw = "ssy0926";
        // 创建Connection连接
        Connection conn = DriverManager.getConnection(url,usename,psw);
        // 判断 数据库连接是否为空
        if(conn != null){
            CallableStatement cstmt = conn.prepareCall( "{call DELETE_purchaserecord(?,?)}" );
            cstmt.setString( 1 ,uid);
            cstmt.setString( 2 ,ticket);
            String sql="select * from ticket where id='"+ticket+"'";
            Statement stmt = conn.createStatement();
            ResultSet rs1=stmt.executeQuery(sql);
            if(!rs1.next()){
                response.sendRedirect("tuipiao.jsp");
            }
            else{
                cstmt.execute();
                ResultSet rs=stmt.executeQuery(sql);
                if(rs.next()){
                    response.sendRedirect("zhucesuccess.jsp");
                }else{
                    response.sendRedirect("zhucefail.jsp");
%>
< a href=" "></ a>
<%
                }
                // 输出连接信息
                //out.println("数据库连接成功！");
                // 关闭数据库连接
                conn.close();
                stmt.close();
                cstmt.close();
            }}else{
            // 输出连接信息
            out.println("数据库连接失败！");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
</body>

</html>