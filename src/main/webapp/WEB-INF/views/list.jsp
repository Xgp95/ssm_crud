<%--!!!jstl!!--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--empPageInfo
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/4/22
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>EmpList</title>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--    引入jquery--%>
    <script type="text/javascript"
            src="${pageContext.getAttribute("APP_PATH")}/static/js/jquery-1.12.4.min.js"></script>
    <%--    引入样式--%>
    <link href="${pageContext.getAttribute("APP_PATH")}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${pageContext.getAttribute("APP_PATH")}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 搭建显示页面 -->
<div class="container">

    <!-- 标题 -->
    <div class="row">
        <div class="col-md-offset-4">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-offset-8">
            <button class="btn btn-primary">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                新增
            </button>
            <button class="btn btn-danger">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                删除
            </button>
        </div>
    </div>

    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${ empPageInfo.list }" var="emp">
                    <tr>
                        <th>${ emp.empId }</th>
                        <th>${ emp.empName }</th>
                        <th>${ emp.gender=="1"?"男":"女" }</th>
                        <th>${ emp.email }</th>
                        <th>${ emp.dept.deptName }</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <%--分页--%>
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-offset-8">当前 ${ empPageInfo.pageNum }页,总${empPageInfo.pages }
            页,总 ${empPageInfo.total } 条记录
        </div>

        <!-- 分页条信息 -->
        <div class="col-md-offset-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${empPageInfo.pageNum != 1 }">
                        <li>
                            <a href="${pageContext.getAttribute("APP_PATH")}/getAllEmp?pn=1">首页</a>
                        </li>
                        <li>
                            <a href="${pageContext.getAttribute("APP_PATH")}/getAllEmp?pn=${empPageInfo.pageNum - 1}"
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${empPageInfo.navigatepageNums}" var="navigatepageNum">
                        <c:if test="${navigatepageNum == empPageInfo.pageNum}">
                            <li class="active">
                                <a href="${pageContext.getAttribute("APP_PATH")}/getAllEmp?pn=${navigatepageNum}">${navigatepageNum}
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${navigatepageNum != empPageInfo.pageNum}">
                            <li>
                                <a href="${pageContext.getAttribute("APP_PATH")}/getAllEmp?pn=${navigatepageNum}">${navigatepageNum}
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${empPageInfo.pageNum != empPageInfo.pages}">
                        <li>
                            <a href="${pageContext.getAttribute("APP_PATH")}/getAllEmp?pn=${empPageInfo.pageNum + 1}"
                               aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.getAttribute("APP_PATH")}/getAllEmp?pn=${empPageInfo.pages}">末页</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
