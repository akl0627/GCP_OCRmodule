<%@ Page language="C#" CodeFile="log_azure.aspx.cs" AutoEventWireup="true" Inherits="WebApplication.CodeFile" %>
<! DOCTYPE HTML>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../css/azure_ocr.css" rel="stylesheet">
        <title>Azureの画像認識サービスによる文字認識（OCR）</title>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
        <script src="../../assets/js/functions.js" type="text/javascript"></script>
    </head>
    <body>
        <script type="text/javascript">
            function startOCR(){
    	// ファイルのアップロード処理
                var upNm = document.getElementById("ocr_upFile").value;
    		    if(!upNm){
    			    window.alert('ファイルを選択して下さい。');
	        	}else{
		//********定義********//
		// ストレージアカウント
        	    	var account = "imagerecognitiondiag871";
		// コンテナ
        	    	var container  = "poc-gazoutest";
		// SharedAccessSignature(SAS)
                    var sas = "?sv=2017-07-29&ss=bfqt&srt=sco&sp=rwdlacup&se=2118-03-31T14:59:59Z&st=2018-04-11T03:01:24Z&spr=https&sig=GbMGnezsRBxJvkliESk5%2BY6IMOKUI5sYYSbLuAdFPVo%3D"
		// APIを利用
    	        	var files = document.getElementById('ocr_upFile').files;
	    	        var file = files[0];
    		        var reader = new FileReader();
	    	        reader.onloadend = function (e2) {
        // 画像URL取得
                        refUrl= 'https://' + account + '.blob.core.windows.net/' + container + '/' + file.name + sas;
    		    	    var requestData = new Uint8Array(e2.target.result);
        		    	$.ajax({
	        		    	url: refUrl,
		        		    type: "PUT",
    			        	data: requestData,
	    			        processData: false,
    	    				beforeSend: function(xhr) {
	    	    			    xhr.setRequestHeader('x-ms-blob-type', 'BlockBlob');
    	    	    		    xhr.setRequestHeader('Content-Length', requestData.length);
	    	    	    	},
		    	    	    success: function (data, status) {
			    	    	    console.log(data);
    				    	    console.log(status);
    	        			},
	    	        		error: function(xhr, desc, err) {
		    	        		console.log(xhr);
			    	        	console.log(desc);
				    	        console.log(err);
        					}
                        });
        //パラメータセット
        		        subscriptionKey = "c76c5af0d3624c7faab9e5bce560775e";
        		        uriBase = "https://westcentralus.api.cognitive.microsoft.com/vision/v1.0/ocr";
                        params = {
                            "language": "unk",
                            "detectOrientation": "true",
                        };
        // 認識
        // jqueryにて、Perform the REST API call.
                        $.ajax({
                            url: uriBase + "?" + $.param(params),
        // Request headers.
                            beforeSend: function(xhrObj){
        // 画像URLを与える（直接の場合は'application/octet-stream'）を指定。
                                xhrObj.setRequestHeader("Content-Type","application/json");
                                xhrObj.setRequestHeader("Ocp-Apim-Subscription-Key", subscriptionKey);
                            },
                            type: "POST",
        // Request body.
                            data: '{"url": ' + '"' + refUrl + '"}',
                        })
                        .done(function(data) {
                            var parse = jsonParser(data);
                            if(parse!=""){
                                $("#responseTextArea").html(parse);
                            }else{
                                $("#responseTextArea").html("認識できませんでした。別の画像でお試しください。");
                            }
                        })
                    .fail(function(jqXHR, textStatus, errorThrown) {
        // Display error message.
                        var errorString = (errorThrown === "") ? "Error. " : errorThrown + " (" + jqXHR.status + "): ";
                        errorString += (jqXHR.responseText === "") ? "" : (jQuery.parseJSON(jqXHR.responseText).message) ?
                        jQuery.parseJSON(jqXHR.responseText).message : jQuery.parseJSON(jqXHR.responseText).error.message;
                        alert(errorString);
                    });
                }
                reader.readAsArrayBuffer(file);
            }
        }

        // (文字認識用)json形式の見栄えを変更
    	function jsonParser(data) {
	        var content = "";
    	    var dataArray1 = data.regions;
        	for(var i in dataArray1){
		   		var dataArray2 = dataArray1[i].lines;
	        	for(var j in dataArray2){
			    	var dataArray3 = dataArray2[j].words;
	    		    for(var k in dataArray3){
					    content = content + dataArray3[k].text;
    	    		}
	                content = content + "\n";
		   	    }
		       }
    	    return content;
        }
        </script>
		<div class="ocr_container">
			<div class="ocr_headerArea">
				<div class="ocr_header_box">
					<h1 id="header_title">Azureの画像認識サービスによる文字認識（OCR）</h1>
				</div>
			</div>
			<div class="contain">
				<div id="fukidashi001">
					<div id="comment001">
						こちらでは、Microsoft Azureを利用したOCRが無料でお試しいただけます。
						<br />
						ただし、以下の点にご注意ください。
						<ul>
							<li>クラウドサービスを利用しているため、営業機密や個人情報を含む画像でのご利用はお控えください。</li>
							<li>下記の条件が含まれる場合、精度が低くなります。</li>
							<ul>
								<li>罫線がある</li>
								<li>手書き文字や特殊なフォント</li>
							</ul>
							<li>画像によっては何も表示されないことがあります。</li>
						</ul>
					</div>
				</div>
				<div id="fukidashi002">
					<div id="comment002">
						<span class="mark">【募集】</span>
						<br />
						日常業務の中で、画像や原紙を見ながら人手でテキスト化している業務はありませんか？
						<ul>
							<li>営業機密や個人情報を含む文書をテキスト化したい</li>
							<li>帳票レイアウトで、テキスト化したい領域がだいたい決まっている</li>
							<li>OCR結果を確認しやすい画面が欲しい</li>
						</ul>
						といった業務にOCRを適用したい方は、別の提供方法が適している可能性があります。
						<br />
						よろしければ<a href="mailto:it.souhatsu@daikin.co.jp?subject=OCR%e3%81%ab%e9%96%a2%e3%81%99%e3%82%8b%e5%95%8f%e3%81%84%e5%90%88%e3%82%8f%e3%81%9b">ご相談</a>ください！
					</div>
				</div>
				<div id="ocr_input">
					<form id="inputArea">
						<div id="inputFile">テキスト化したい画像ファイルを選択して、「テキスト化開始」ボタンをクリックして下さい。
						<br />
						<span class="akamoji">※アップロードできるファイル形式：jpg, png, bmp</span>
						</div>
						<div>
							<input type="file" name="ocr_upFile" id="ocr_upFile" value="" size="30" name="ocr_upFile" accept=".jpg,.png,.bmp" />
							<input type="button" class="ocr_submit_btn" id="ocr_submit_btn" value="テキスト化開始" onclick="startOCR()" />
						</div>
					</form>
					<div id="wrapper">
						<div id="jsonOutput">
							テキスト化の結果:<br />
							<textarea id="responseTextArea" class="UIInput" readonly></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>


