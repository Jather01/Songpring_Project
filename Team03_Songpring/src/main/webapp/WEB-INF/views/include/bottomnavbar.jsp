<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container center">
	<div style="height: 20px"></div>
	<div class="row">
		<div class="col-md-4" align = "center">
			<h2>SNS</h2>
			<table>
				<tr>
					<td>
						<a href="#">
							<img style="width: 100px; height: 100px;" src="${pageContext.request.contextPath }/resources/images/kakao.png"/>
						</a>
					</td>
					<td>
						<a href="#">
							<img style="width: 100px; height: 100px;" src="${pageContext.request.contextPath }/resources/images/facebook.png"/>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<a href="#">
							<img style="width: 100px; height: 100px;" src="${pageContext.request.contextPath }/resources/images/instargram.png"/>
						</a>
					</td>
					<td>
						<a href="#">
							<img style="width: 100px; height: 100px;" src="${pageContext.request.contextPath }/resources/images/twitter.png"/>
						</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="col-md-4" align = "center">
			<h2>ACCOUNT INFO</h2>
			<table>
				<tr>
					<td width ="80">농협</td>
					<td>000-0000-0000-00</td>
				</tr>
				<tr>
					<td width ="80">국민</td>
					<td>000000-00-000000</td>
				</tr>
				<tr>
					<td width ="80">신한</td>
					<td>000-000-000000</td>
				</tr>
				<tr>
					<td width ="80">우리</td>
					<td>0000-000-000000</td>
				</tr>
				<tr>
					<td width ="80">예금주</td>
					<td>㈜송프링</td>
				</tr>
			</table>
		</div>
		<div class="col-md-4" align = "center">
			<h2>COMPANY INFO</h2>
			<table>
				<tr>
					<td width ="130">상호명</td>
					<td>㈜송프링</td>
				</tr>
				<tr>
					<td width ="130" rowspan="2">주소</td>
					<td>서울 강남구 테헤란로</td>
				</tr>
				<tr>
					<td>124 삼원타워 5층</td>
				</tr>
				<tr>
					<td width ="130">전화</td>
					<td>02)000-0000</td>
				</tr>
				<tr>
					<td width ="130">사업자등록번호</td>
					<td>000-00-00000</td>
				</tr>
			</table>
		</div>
	</div>
</div>