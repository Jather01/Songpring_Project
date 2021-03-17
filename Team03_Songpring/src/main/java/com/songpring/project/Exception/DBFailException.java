package com.songpring.project.Exception;
/*
 * 일반적인 예외 클래스는 RuntimeException 클래스를 상속받아서 만든다.
 * - 생성자의 인자로 예외 메세지를 전달받아서 부모 생성자에 넘겨주면
 *   .getMessage() 메소드를 호출해서 예외 메세지를 받아 갈 수 있다.
 */
public class DBFailException extends RuntimeException {
	// 생성자
	public DBFailException(String msg) {
		super(msg);
	}
}
