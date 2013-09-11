<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>YetAnotherGM!</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet" media="screen">
<style type='text/css'>
body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
</style>

<!--  style for jqueryui -->
<style>
  body { min-width: 520px; }
  .column { width: 170px; float: left; padding-bottom: 100px; }
  .portlet { margin: 0 1em 1em 0; }
  .portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
  .portlet-header .ui-icon { float: right; }
  .portlet-content { padding: 0.4em; }
  .ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
  .ui-sortable-placeholder * { visibility: hidden; }
  </style>
<!-- end style for jquery ui -->

</head>
<body>
		<!-- header nav bar -->
			<div class="navbar navbar-inverse navbar-fixed-top">
		      <div class="navbar-inner">
		        <div class="container-fluid">
		          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		          </button>
		          <a class="brand" href="#">YetAnotherGM</a>
		          <div class="nav-collapse collapse">
		            <ul class="nav">
		              <li class="active"><a href="#">GMK</a></li>
		              <li><a href="#" id="signin-button">Sign in to DropBox</a></li>
		            </ul>
		          </div><!--/.nav-collapse -->
		        </div>
		      </div>
		    </div>
	    <!-- end header nav bar -->
    
	  <div class="container-fluid">
	      <div class="row-fluid">
	        <div class="span12">
		        <div class="tabbable tabs-left">
		        
		        <!--  tab names -->
		        <ul class="nav nav-tabs">
			        <li><a href="#tab2" data-toggle="tab">Projects</a></li>
				    <li class="active"><a href="#tab1" data-toggle="tab">Sprites</a></li>
				    <li><a href="#tab2" data-toggle="tab">Sounds</a></li>
				    <li><a href="#tab2" data-toggle="tab">Backgrounds</a></li>
				    <li><a href="#tab2" data-toggle="tab">Fonts</a></li>
				    <li><a href="#tab2" data-toggle="tab">Timelines</a></li>
				    <li><a href="#tab2" data-toggle="tab">Scripts</a></li>
				    <li><a href="#tab2" data-toggle="tab">Objects</a></li>
				    <li><a href="#tab2" data-toggle="tab">Rooms</a></li>
				</ul>
		        <!-- End Tab names -->
		        
		        <div class="tab-content">
		        
			        <!--  Main content area -->
			        
			        <div class="row-fluid">
			        <div class="span12">
			        
				        <div class="column">
	 
							  <div class="portlet">
							    <div class="portlet-header">Sprite1</div>
							    <div class="portlet-content"><jsp:include page="spriteEditor.jsp" /></div>
							  </div>
							 
							  <div class="portlet">
							    <div class="portlet-header">Sound</div>
							    <div class="portlet-content"><a id="simpleLink" class="textLink" href="<c:url value="/simple" />">GET /simple</a></div>
							  </div>
						</div>
						 
						<div class="column">
						  <div class="portlet">
						    <div class="portlet-header">Background</div>
						    <div class="portlet-content"><a id="callableResponseBodyLink" class="textLink"
				href="<c:url value="/async/callable/opengmk" />">GET /async/callable/opengmk</a></div>
						  </div>
						</div>
						
						<div class="column">
						  <div class="portlet">
						    <div class="portlet-header">Sprite4</div>
						    <div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
						  </div>
						</div>
						
						<div class="column">
						  <div class="portlet">
						    <div class="portlet-header">Sprite5</div>
						    <div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
						  </div>
						</div>
			        
			        </div>
			        
			        
			        
			        <!--  <div class="span6">
						  <ul class="thumbnails">
							  <li class="span1">
								  <div class="thumbnail">
								      <img data-src="holder.js/300x200" alt="">
								      <div class="caption">
									      <h6>Sprite1</h6>
									      <p>settings here</p>
								      </div>
								  </div>
							  </li>
						  </ul>
					</div>-->
			        </div>
			        <!-- End Main content area -->
		        </div>
		          
	          </div> <!-- tabbable -->
	        </div><!--/span-->
	  
	  </div>
	  </div>
  

    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
  <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  
  <script src="//cdnjs.cloudflare.com/ajax/libs/dropbox.js/0.10.1/dropbox.min.js"></script>
  
  <script>
  function load_dropbox() {
	  var client = new Dropbox.Client({ key: "h6oeblm6hp2oa2w" });
	  
	// Try to use cached credentials.
	  client.authenticate({interactive: false}, function(error, client) {
	    if (error) {
	      return handleError(error);
	    }
	    if (client.isAuthenticated()) {
	      // Cached credentials are available, make Dropbox API calls.
	      cool(client);
	    } else {
	      // show and set up the "Sign into Dropbox" button
	      var button = document.querySelector("#signin-button");
	      button.setAttribute("class", "visible");
	      button.addEventListener("click", function() {
	        // The user will have to click an 'Authorize' button.
	        client.authenticate(function(error, client) {
	          if (error) {
	            return handleError(error);
	          }
	          cool(client);
	        });
	      });
	    }
	  });
	  
	
	  
  }
  
  var showError = function(error) {
	  switch (error.status) {
	  case Dropbox.ApiError.INVALID_TOKEN:
	    // If you're using dropbox.js, the only cause behind this error is that
	    // the user token expired.
	    // Get the user through the authentication flow again.
	    break;

	  case Dropbox.ApiError.NOT_FOUND:
	    // The file or folder you tried to access is not in the user's Dropbox.
	    // Handling this error is specific to your application.
	    break;

	  case Dropbox.ApiError.OVER_QUOTA:
	    // The user is over their Dropbox quota.
	    // Tell them their Dropbox is full. Refreshing the page won't help.
	    break;

	  case Dropbox.ApiError.RATE_LIMITED:
	    // Too many API requests. Tell the user to try again later.
	    // Long-term, optimize your code to use fewer API calls.
	    break;

	  case Dropbox.ApiError.NETWORK_ERROR:
	    // An error occurred at the XMLHttpRequest layer.
	    // Most likely, the user's network connection is down.
	    // API calls will not succeed until the user gets back online.
	    break;

	  case Dropbox.ApiError.INVALID_PARAM:
	  case Dropbox.ApiError.OAUTH_ERROR:
	  case Dropbox.ApiError.INVALID_METHOD:
	  default:
	    // Caused by a bug in dropbox.js, in your application, or in Dropbox.
	    // Tell the user an error occurred, ask them to refresh the page.
	  }
	};
	
	function cool(client) {
		client.getAccountInfo(function(error, accountInfo) {
			  if (error) {
			    return showError(error);  // Something went wrong.
			  }

			  alert("Hello, " + accountInfo.name + "!");
			});
	}
	load_dropbox();
  </script>
  
  <script>
  
  $(function() {
    $( ".column" ).sortable({
      connectWith: ".column"
    });
 
    $( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
      .find( ".portlet-header" )
        .addClass( "ui-widget-header ui-corner-all" )
        .prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
        .end()
      .find( ".portlet-content" );
 
    $( ".portlet-header .ui-icon" ).click(function() {
      $( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
      $( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
    });
 
    $( ".column" ).disableSelection();
  });
  </script>
  
  <!-- YAGM scripts -->
  <script>$("a.textLink").click(function(){
		var link = $(this);
		$.ajax({ url: link.attr("href"), dataType: "text", success: function(text) { /*MvcUtil.showSuccessResponse(text, link);*/ alert(text); }, error: function(xhr) { MvcUtil.showErrorResponse(xhr.responseText, link); }});
		return false;
	});</script>
  <!--  end YAGM scripts -->
</body>
</html>