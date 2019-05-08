<!DOCTYPE html >
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");%>
 --%><html>
<head>
<meta charset="utf-8">
<meta name="google-site-verification" content="NiCTcNow3UOyeN9LS8U2gyKMciZ8DHGqUhGHI2GvmfY" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="sat, 01 Dec 2001 00:00:00 GMT">
<title>Star EAI | Mercedes-Benz</title>
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">
<link rel="icon" type="image/png"
	href="https://www.mbusa.com/favicon.ico">

</head>
<body>
	<c:choose>
		<c:when test="${mode=='MODE_HOME' }">
			<div class="container" id="homediv">
				<div class="jumbotron text-center">
					<h1>Welcome to Star EAI Data Portal</h1>
					<h3>U.S.A | Canada | Mexico</h3>
				</div>
			</div>

		</c:when>
</c:choose>
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
</body>
</html>