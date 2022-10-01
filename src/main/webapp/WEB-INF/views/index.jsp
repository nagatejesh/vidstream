<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="./file.txt" %>
<!-- <link rel="stylesheet" href="bootstrap.css"> -->
<meta charset="ISO-8859-1">
<title>VidStream</title>
<style>
	html, body{
		padding:0;
		margin:0;
	}
	.container-fluid{
		width:100vw;
		height:100vh;
		padding:0;
		marging:0;
	}
	a{
		text-decoration: none;
		cursor: pointer;
	}
	.btn{
		border-radius:5%;
	}
</style>
</head>
<body>
<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="card col-sm-5">
			<div class="card-header"><h3 class="card-title">Welcome to VidStream</h3></div>
			<div class="card-body">
				<div class="btn btn-primary-outline"><a href="/anime">Show my Anime</a></div>
				<div class="btn btn-primary-outline"><a href="/add">Add new Anime</a></div>
			</div>
		</div>
	</div>
</div>

<%@ include file="./script.txt" %>
</body>
</html>