<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" href="">
    <style>
        .displayImg img{
            width: 50px;
            height: 50px;
        }
    </style>
</head>
<body>

<%-- Main content --%>
<form action="UploadDownloadFileServlet" method="post" enctype="multipart/form-data" style="border:solid 1px #000">
    Select File to Upload:
    <input type="file" name="fileName" id="fileName" onchange="displayImg()" multiple min="1" max="4"> <br>
    <div id="displayImg">

    </div>
    <input type="submit" value="Upload">
</form>

<script>
    const inputFile = document.getElementById('fileName');
    function displayImg() {
        var file = document.getElementById('fileName').files;
        var imgs = document.getElementById('displayImg').getElementsByTagName('img').length;
        if(imgs >= 4){
            alert('You can only have 4 files.');
            inputFile.value = ''; // Clear the selected files
            return;
        }
        if(file.length > 0){
            if (file.length > 4) {
                alert('You can only select a maximum of 4 files.');
                inputFile.value = ''; // Clear the selected files
            } else {
                for(let i = 0 ; i < file.length ; i++){
                    let fileToLoad = file[i];
                    let fileReader = new FileReader();
                    fileReader.onload = function (fileLoaderEvent) {
                        let srcData = fileLoaderEvent.target.result;
                        let img = document.createElement('img');
                        img.src = srcData;
                        document.getElementById('displayImg').innerHTML += img.outerHTML;
                    }
                    fileReader.readAsDataURL(fileToLoad);
                }
            }
        } else {
            alert('select at last 1 file');
           inputFile.value = ''; // Clear the selected files
        }
    }
</script>
</body>
</html>