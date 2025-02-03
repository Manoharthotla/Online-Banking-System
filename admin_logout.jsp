<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Invalidate the current session
    
    if (session != null) {
        session.invalidate(); // Destroy the session
    }

    // Redirect to index.jsp
    response.sendRedirect("index.jsp");
%>
