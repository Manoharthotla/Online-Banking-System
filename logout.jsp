<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Invalidate the session to log the user out
    if (session != null) {
        session.invalidate(); // Invalidates the session
    }
    response.sendRedirect("index.jsp");
%>
