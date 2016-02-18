package com.hao;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.websocket.MessageInbound;
import org.apache.catalina.websocket.StreamInbound;
import org.apache.catalina.websocket.WebSocketServlet;
import org.apache.catalina.websocket.WsOutbound;

public class SameWebSocketServlet extends WebSocketServlet {
	public static Map<String, MyMessageInbound> mmiList = new HashMap<String, MyMessageInbound>();

	protected StreamInbound createWebSocketInbound(String subProtocol,
			HttpServletRequest request) {
		System.out.println("room:"+request.getParameter("r"));
		String arg="0";
		if(null!=request.getParameter("r")){
			arg=request.getParameter("r");
		}
		return new MyMessageInbound(arg);
	}

	public int getUserCount() {
		return mmiList.size();
	}

	private class MyMessageInbound extends MessageInbound {
		WsOutbound myoutbound;
		String mykey;
		String room;
		public MyMessageInbound(String room){
			this.room=room;
		}
		@Override
		public void onOpen(WsOutbound outbound) {
			try {
				System.out.println("websocket Client.");
				this.myoutbound = outbound;
				mykey = "" + System.currentTimeMillis();
				mmiList.put(room+"::"+mykey, this);
				System.out.println("mmiList size:" + mmiList.size());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		@Override
		public void onClose(int status) {
			System.out.println("websocket Close."+mykey);
			mmiList.remove(mykey);
		}

		@Override
		protected void onTextMessage(CharBuffer message) throws IOException {
			System.out.println("onTextMessage-------->");
			for (Map.Entry<String, MyMessageInbound> entry : mmiList.entrySet()) {
				//System.out.println(entry.getKey() + "-----");
				String socketroom=entry.getKey().split("::")[0];
				String socketkey=entry.getKey().split("::")[1];
				if(this.room.equals(socketroom)&&!this.mykey.equals(socketkey)){//��room��ͬ���ǲ��ǵ�ǰwebsocket������Ϣ
					System.out.println("-------->" + message.toString());
					System.out.println("--->socketroom:"+socketroom+",socketkey:"+socketkey);
					MyMessageInbound mmib = (MyMessageInbound) entry.getValue();
					CharBuffer buffer = CharBuffer.wrap(message);
					mmib.myoutbound.writeTextMessage(buffer);
					mmib.myoutbound.flush();
				}
			}
		}

		@Override
		protected void onBinaryMessage(ByteBuffer arg0) throws IOException {

		}
	}

}
