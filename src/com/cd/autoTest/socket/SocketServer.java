package com.cd.autoTest.socket;

import java.io.IOException;
import java.net.InetSocketAddress;

import org.apache.mina.core.service.IoAcceptor;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.filter.codec.ProtocolCodecFilter;
import org.apache.mina.filter.codec.serialization.ObjectSerializationCodecFactory;
import org.apache.mina.transport.socket.nio.NioSocketAcceptor;

public class SocketServer {
	private static final int PORT = 9213;
	private static SocketServer socketServer;
	public static SocketServer getInstance()
	{
		if(socketServer==null)
		{
			socketServer=new SocketServer();
		}
		return socketServer;
	}
	public static void main(String[] args) throws IOException {

		IoAcceptor acceptor = new NioSocketAcceptor();
		acceptor.setHandler(new SocketHandler());
		acceptor.getFilterChain().addLast("codec", new ProtocolCodecFilter(new ObjectSerializationCodecFactory()));
		acceptor.getSessionConfig().setReadBufferSize(2048);
		acceptor.getSessionConfig().setIdleTime(IdleStatus.BOTH_IDLE, 10);

		acceptor.bind(new InetSocketAddress(PORT));

	}

	public void init() {
		try {
			IoAcceptor acceptor = new NioSocketAcceptor();
			acceptor.setHandler(new SocketHandler());
			acceptor.getFilterChain().addLast("codec", new ProtocolCodecFilter(new ObjectSerializationCodecFactory()));
			acceptor.getSessionConfig().setReadBufferSize(2048);
			acceptor.getSessionConfig().setIdleTime(IdleStatus.BOTH_IDLE, 10);

			acceptor.bind(new InetSocketAddress(PORT));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
