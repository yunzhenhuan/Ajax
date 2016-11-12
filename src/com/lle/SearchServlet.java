package com.lle;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class SearchServlet extends HttpServlet {

	static List<String> datas = new ArrayList<String>();

	static {	
		datas.add("ajax");
		datas.add("ajax post");
		datas.add("becky");
		datas.add("james");
		datas.add("jerry");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		// 首先获得客户端发送来的数据keyword
		String keyword = request.getParameter("keyword");
		// 获得关键的之后进行处理，得到关联数据
		List<String> listData = getData(keyword);
		// 返回Json格式				
		//System.out.println(JSONArray.fromObject(listData));
		response.getWriter().write(JSONArray.fromObject(listData).toString());
	}

	// 获得关联数据的方法
	public List<String> getData(String keyword) {
		List<String> list = new ArrayList<String>();
		for (String data : datas) {
			if (data.contains(keyword)) {
				if (data.contains(keyword)) {
					list.add(data);
				}
			}
		}
		return list;
	}
}
