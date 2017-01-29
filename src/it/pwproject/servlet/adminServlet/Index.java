package it.pwproject.servlet.adminServlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.pwproject.DBAccess.DBInformation;
import it.pwproject.DBAccess.GetInformation;
import it.pwproject.javabean.OrderBean;

@WebServlet("/admin/index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
    static GetInformation information;
    static {
    	information=new DBInformation();
    }
    public Index() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<OrderBean> orders=information.getOrderForAdmin();
		request.setAttribute("orders", orders);
		request.setAttribute("redirect", false);
		request.getServletContext().getRequestDispatcher("/admin/adminpage.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
