﻿<%@ Page language="C#" CodeFile="log_gcp.aspx.cs" AutoEventWireup="true" Inherits="WebApplication.CodeFile" %>
<!-- Copyright 2015, Google, Inc.
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License. -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="Cache-Control" content="no-cache">
  <link rel="stylesheet" href="css/style.css" type="text/css">
  <title>GCPの画像認識サービスによる文字認識（OCR）</title>
  <script type="text/javascript" src="key.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
  <script type="text/javascript" src="main.js"></script>
</head>
<body>
	<div class="ocr_container">
		<div class="ocr_headerArea">
			<div class="ocr_header_box">
				<h1 id="header_title">GCPの画像認識サービスによる文字認識（OCR）</h1>
			</div>
		</div>
		<div class="contain">
			<div id="fukidashi001">
				<div id="comment001">
					こちらでは、Google Cloud Platformを利用したOCRが無料でお試しいただけます。
					<br/>
					ただし、以下の点にご注意ください。
					<ul>
						<li>クラウドサービスを利用しているため、営業機密情報を含む画像でのご利用はお控えください。</li>
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
					<br/>
					日常業務の中で、画像や原紙を見ながら人手でテキスト化している業務はありませんか？
					<ul>
						<li>営業機密情報を含む文書をテキスト化したい</li>
						<li>帳票レイアウトで、テキスト化したい領域がだいたい決まっている</li>
						<li>OCR結果を確認しやすい画面が欲しい</li>
					</ul>
					といった業務にOCRを適用したい方は、別の提供方法が適している可能性があります。
					<br/>
					よろしければ<a href="mailto:it.souhatsu@daikin.co.jp?subject=OCR%e3%81%ab%e9%96%a2%e3%81%99%e3%82%8b%e5%95%8f%e3%81%84%e5%90%88%e3%82%8f%e3%81%9b">ご相談</a>ください！
				</div>
			</div>
			<div id="ocr_input">
				<form id="inputArea">
					<div id="inputFile">
					テキスト化したい画像ファイルを選択して、「テキスト化開始」ボタンをクリックして下さい。
					<br/>
					<span class="akamoji">
					※アップロードできるファイル形式：jpg, jpeg, png, bmp
					<br/>
					※最大ファイルサイズ：10MB
					</span>
					</div>
					<div>
						<input type="hidden" name="type" value="TEXT_DETECTION">
						<input type="file" name="fileField" id="ocr_upFile">
						<input type="submit" class="ocr_submit_btn" id="ocr_submit_btn" name="submit" value="テキスト化開始">
					</div>
				</form>
				<div id="wrapper">
					<div id="jsonOutput">
					テキスト化の結果：
					<br/>
					<!--<code style="white-space:pre" id="results"></code>-->
					<textarea id="results" class="UIInput" readonly></textarea>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
