package com.art.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.art.model.ArtService;
import com.art.model.ArtVO;
import com.google.protobuf.TextFormatParseInfoTree;

public class ArtServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("artId");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("文章編號錯誤");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/art/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer artId = null;
				try {
					artId = Integer.valueOf(str);
				} catch (Exception e) {
					errorMsgs.add("文章編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/art/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				ArtService artSvc = new ArtService();
				ArtVO artVO = artSvc.getOneArt(artId);
				if (artVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/art/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("artVO", artVO); // 資料庫取出的ArtVO物件,存入req
				String url = "/art/listOneArt.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneArt.jsp
				successView.forward(req, res);
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllArt.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
				/***************************1.接收請求參數****************************************/
				Integer artId = Integer.valueOf(req.getParameter("artId"));
				
				/***************************2.開始查詢資料****************************************/
				ArtService artSvc = new ArtService();
				ArtVO artVO = artSvc.getOneArt(artId);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("artVO", artVO);         // 資料庫取出的ArtVO物件,存入req
				String url = "/art/update_art_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_art_input.jsp
				successView.forward(req, res);
		}
		
		
		if ("update".equals(action)) { // 來自update_art_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			Integer artId = Integer.valueOf(req.getParameter("artId").trim());
				
			String artTitle = req.getParameter("artTitle");
			
				if (artTitle == null || artTitle.trim().length() == 0) {
					errorMsgs.add("文章標題: 請勿空白");
				}
				
			String artContent = req.getParameter("artContent").trim();
				if (artContent == null || artContent.trim().length() == 0) {
					errorMsgs.add("內容請勿空白");
				}	
				
			Timestamp artTimestamp = null;
				try {
					artTimestamp = Timestamp.valueOf(req.getParameter("artTimestamp").trim());
				} catch (IllegalArgumentException e) {
					artTimestamp = new Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				Integer artReply = Integer.valueOf(req.getParameter("artReply").trim());
				Integer artFavor = Integer.valueOf(req.getParameter("artFavor").trim());
				Integer artView = Integer.valueOf(req.getParameter("artView").trim());


				ArtVO artVO = new ArtVO();
				artVO.setArtId(artId);
				artVO.setArtTitle(artTitle);
				artVO.setArtContent(artContent);
				artVO.setArtTimestamp(artTimestamp);
				artVO.setArtReply(artReply);
				artVO.setArtFavor(artFavor);
				artVO.setArtView(artView);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("artVO", artVO); // 含有輸入格式錯誤的ArtVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/art/update_art_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ArtService artSvc = new ArtService();
				artVO = artSvc.updateArt(artId,artTitle, artContent,artTimestamp,artReply,artFavor,artView);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("artVO", artVO); // 資料庫update成功後,正確的的ArtVO物件,存入req
				String url = "/art/listOneArt.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
		}

//		insert
        if ("insert".equals(action)) { // 來自addArt.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
			
				String artTitle = req.getParameter("artTitle");
				
				if (artTitle == null || artTitle.trim().length() == 0) {
					errorMsgs.add("文章標題: 請勿空白");
				} 
				
				String artContent = req.getParameter("artContent").trim();
				if (artContent == null || artContent.trim().length() == 0) {
					errorMsgs.add("內容請勿空白");
				}	
				
			Timestamp artTimestamp = null;
				try {
					artTimestamp = Timestamp.valueOf(req.getParameter("artTimeStamp").trim());
				} catch (IllegalArgumentException e) {
					artTimestamp = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				Integer	artReply = null;
				try {
					artReply = Integer.valueOf(req.getParameter("artReply").trim());
				} catch (NumberFormatException e) {
					artReply = 0;
					errorMsgs.add("請填數字.");
					}
				
				Integer	artFavor = null;
				try {
					artFavor = Integer.valueOf(req.getParameter("artFavor").trim());
				} catch (NumberFormatException e) {
					artFavor = 0;
					errorMsgs.add("請填數字.");
					}
				
				Integer	artView = null;
				try {
					artView = Integer.valueOf(req.getParameter("artView").trim());
				} catch (NumberFormatException e) {
					artView = 0;
					errorMsgs.add("請填數字.");
					}
				

				ArtVO artVO = new ArtVO();
				artVO.setArtTitle(artTitle);
				artVO.setArtContent(artContent);
				artVO.setArtTimestamp(artTimestamp);
				artVO.setArtReply(artReply);
				artVO.setArtFavor(artFavor);
				artVO.setArtView(artView);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("artVO", artVO); // 含有輸入格式錯誤的ArtVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/art/addArt.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ArtService artSvc = new ArtService();
				artVO = artSvc.addArt(artTitle,  artContent ,artTimestamp,
						 artReply, artFavor,  artView);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/art/listAllArt.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
		}
        
//        delete
	if("delete".equals(action))

	{ // 來自listAllArt.jsp

		List<String> errorMsgs = new LinkedList<String>();
		// Store this set in the request scope, in case we need to
		// send the ErrorPage view.
		req.setAttribute("errorMsgs", errorMsgs);

		/*************************** 1.接收請求參數 ***************************************/
		Integer artId = Integer.valueOf(req.getParameter("artId"));

		/*************************** 2.開始刪除資料 ***************************************/
		ArtService artSvc = new ArtService();
		artSvc.deleteArt(artId);

		/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
		String url = "/art/listAllArt.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
		successView.forward(req, res);
	}
}}
