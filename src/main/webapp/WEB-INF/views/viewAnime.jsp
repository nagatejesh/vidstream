<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ include file="navigation.jsp" %>
<html>
<head>
<%@ include file="file.txt"%>
<meta charset="ISO-8859-1">
<title>Anime | ${anime.engName}</title>
<style>
html, body {
	padding: 0;
	margin: 0;
	background: repeating-linear-gradient(45deg,#ccffff,#ffcccc);
	overflow: hidden;
}

.container-fluid {
	padding:20vh 25vw;
	margin: 0;
}
.card{
	padding:1rem;
}
.card-text{
	margin: 0;
}
</style>
</head>
<body>
	<div class="container-fluid">
				<div class="card">
					<div class="card-body">
							<h2 class="card-title">${anime.engName}</h2>
							<h4 class="card-subtitle text-muted">${anime.japName}</h4>
							<p class="card-text text-muted">${anime.description}</p>
							<c:forTokens items='${anime.tags}' delims="," var="str">
								<a class="btn btn-outline-warning text-muted" role="button" href="/genre/${str}" >${str}</a>
							</c:forTokens>
							<div class="card-text row">
							<p class="align-self-start">
								<c:if test="${anime.isWatched()}"><span class="text-success">&#x2714;</span></c:if>
								<c:if test="${not anime.isWatched()}"><span class="text-danger">&#x2716;</span></c:if>
							</p>
							<p>
								<c:if test="${anime.isPlus18()}"><span class="text-danger">&#128286;</span></c:if>
							</p>
							</div>
					</div>
					<div class="card-footer">
						<a class="btn btn-success float-left"
							href="/edit/${anime.id}" role="button">Edit</a>
						<a class="btn btn-danger float-right"
							href="/delete/${anime.id}" role="button">Delete</a>
					</div>

				</div>
				
		</div>
<%@ include file="./script.txt" %>
</body>
</html>