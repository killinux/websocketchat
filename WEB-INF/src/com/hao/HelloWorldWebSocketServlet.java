package com.hao;


import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.websocket.MessageInbound;
import org.apache.catalina.websocket.StreamInbound;
import org.apache.catalina.websocket.WebSocketServlet;
import org.apache.catalina.websocket.WsOutbound;

public class HelloWorldWebSocketServlet extends WebSocketServlet {
	public static Map<String,MyMessageInbound> mmiList  = new HashMap<String,MyMessageInbound>();

	protected StreamInbound createWebSocketInbound(String subProtocol,
			HttpServletRequest arg1) {
		System.out.println("hello world websocket");
		return new MyMessageInbound();
	}
	public int getUserCount(){
		return mmiList.size();
	}
	private class MyMessageInbound extends MessageInbound {
		WsOutbound myoutbound;
		String mykey;
		@Override
		public void onOpen(WsOutbound outbound) {
			try {
				System.out.println("Open Client.");
				this.myoutbound = outbound;
				mykey =""+System.currentTimeMillis();;
				mmiList.put(mykey, this);
				System.out.println("mmiList size:"+mmiList.size());
				outbound.writeTextMessage(CharBuffer.wrap("open "+mykey));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		@Override
		public void onClose(int status) {
			System.out.println("Close Client.");
			//mmiList.remove(this);
			mmiList.remove(mykey);
		}

		@Override
		protected void onBinaryMessage(ByteBuffer arg0) throws IOException {

		}
		private void toOne(CharBuffer message) throws IOException{
			//System.out.println("onText--->" + message.toString());
			
			String[] msgarray= message.toString().split(",");
			if("".equals(msgarray[1])){
				for (Map.Entry<String, MyMessageInbound> entry : mmiList.entrySet()) {
					System.out.println("entry.getKey()-----"+entry.getKey());
					  MyMessageInbound mmib = (MyMessageInbound) entry.getValue(); 
					  CharBuffer buffer = CharBuffer.wrap(message);
					  System.out.println(buffer);
		              mmib.myoutbound.writeTextMessage(buffer);
		              mmib.myoutbound.flush();
				}
			}else{
				MyMessageInbound toUser=mmiList.get(msgarray[1]);
				if(toUser!=null){
					CharBuffer buffer = CharBuffer.wrap(message);
					toUser.myoutbound.writeTextMessage(buffer);
					toUser.myoutbound.flush();
				}
			}	
		}
		@Override
		protected void onTextMessage(CharBuffer message) throws IOException {
			try {//print messages not gif
				String[] messages=message.toString().split("#");
				String log_message=messages[0]+" say to "+messages[1]+":"+messages[2];
				System.out.println("onText---> onTextMessage:"+log_message.toString());
			} catch (Exception e) {
			}
			String[] msgarray= message.toString().split(",");
			for (Map.Entry<String, MyMessageInbound> entry : mmiList.entrySet()) {
				  //System.out.println(entry.getKey()+"-----");
				  MyMessageInbound mmib = (MyMessageInbound) entry.getValue(); 
				  CharBuffer buffer = CharBuffer.wrap(message);
				  //System.out.println(buffer);
	              mmib.myoutbound.writeTextMessage(buffer);
	              mmib.myoutbound.flush();
			}
			
			/*Socket socket;
			String msg = "";
			try {
				socket = new Socket("192.168.0.102", 5000);
				// socket = new Socket("127.0.0.1",5000);
				PrintWriter output = new PrintWriter(socket.getOutputStream());

				output.write(message.toString());
				output.flush();

				DataInputStream input = new DataInputStream(
						socket.getInputStream());
				byte[] b = new byte[1024];
				input.read(b);
				msg = new String(b).trim();

				output.close();
				input.close();
				socket.close();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			CharBuffer cb = CharBuffer.wrap(new StringBuilder(msg));
			getWsOutbound().writeTextMessage(cb);*/
		}
	}

	public static void main(String[] args) {
		
		
		
		/*Socket socket;
		String message = "haoning";
		String msg = "";
		try {
			socket = new Socket("192.168.0.102", 5000);
			// socket = new Socket("127.0.0.1",5000);
			PrintWriter output = new PrintWriter(socket.getOutputStream());

			output.write(message.toString());
			output.flush();

			DataInputStream input = new DataInputStream(socket.getInputStream());
			byte[] b = new byte[1024];
			input.read(b);
			msg = new String(b).trim();

			output.close();
			input.close();
			socket.close();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
	}
}
