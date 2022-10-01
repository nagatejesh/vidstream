<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html>
<%@ include file="navigation.jsp" %>
<html>
<head>
<%@ include file="./file.txt"%>
<meta charset="ISO-8859-1">
<title>Anime Series | <%=new Date().toLocaleString() %></title>
<link rel="shortcut icon" type="image/x-icon" href="/favicon.jpg" >
<link rel="icon" type="image/x-icon" href="/favicon.jpg" >
<style>
html, body {
	padding: 0;
	margin: 0;
	background: repeating-linear-gradient(45deg,#ccffff,#ffcccc);
	overflow-x: hidden;
}

.container-fluid {
	padding: 0;
	marging: 0;
}
.card{
	background: lightgray;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="card col-sm-10">
				<div class="card-header">
					<h3 class="card-title text-center">Welcome to VidStream</h3>
				</div>
				<div class="card-body">
					<f:form action="/add" method="post" modelAttribute="anime">
						<f:input path="id" class="form-control" type="text" id="id"
								name="id" cssStyle="display:none;" />
						<div class="form-group col-lg-8">
							<label for="engName">English Name</label>
							<f:input path="engName" class="form-control" type="text" id="engName"
								name="engName" />
						</div>
						<div class="form-group col-lg-8">
							<label for="japName">Japanese Name</label>
							<f:input path="japName" class="form-control" type="text" id="japName"
								name="japName" />
						</div>
						<div class="form-group col-lg-8">
							<label for="description">Description</label>
								<f:textarea path="description" class="form-control" id="description"
								name="description" rows="3"/>
						</div>
						
						<div class="form-group col-lg-8">
							<label for="tags">Tags/Genre</label>
							<f:input path="tags" class="form-control" type="text"
								id="tags" name="tags" placeholder='Comedy,Drama etc'/>
						</div>
						<div class="form-group col-lg-8">
							<label for="noOfSeasons">No of Seasons</label>
							<f:input path="noOfSeasons" class="form-control" type="number"
								id="noOfSeasons" name="noOfSeasons" />
						</div>
						<div class="form-group col-lg-8">
							<label for="noOfEpisodes">No of Episodes</label>
							<f:input path="noOfEpisodes" class="form-control" type="number"
								id="noOfEpisodes" name="noOfEpisodes" />
						</div>
						<div class="form-group col-lg-8">
							<label class="checkbox-inline"><f:checkbox path="watched" id="watched" name="watched"/>Watched</label>
						</div>
						<div class="form-group col-lg-8">
							<label class="checkbox-inline"><f:checkbox path="plus18" id="plus18" name="plus18"/>&#128286;</label>
						</div>

						<div class="form-group col-lg-8">
							<input class="btn btn-success float-right" type="submit" value="Add">
						</div>

					</f:form>
				</div>
			</div>
		</div>
	</div>

<script>
var url = document.URL;
if(url.includes('add')){
	document.getElementById('id').remove()
}
function setTrue(id){
	var ele = document.getElementById(id)
	if(ele.getAttribute('value')==='true')
		ele.setAttribute('value','false')
	else
		ele.setAttribute('value','true')
}
</script>

<%@ include file="./script.txt" %>
</body>
</html>