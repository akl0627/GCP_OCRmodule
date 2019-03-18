// Copyright 2015, Google, Inc.
// Licensed under the Apache License, Version 2.0 (the "License")
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

'use strict';
/**TODO：APIキー使わない方法で実装（割り当て未）*/
var CV_URL = 'https://vision.googleapis.com/v1/images:annotate?key=' + window.apiKey;

$(function () {
  $('#inputArea').on('submit', uploadFiles);
});

/**
 * 'submit' event handler - reads the image bytes and sends it to the Cloud
 * Vision API. 【対象ファイルを変換してOCR処理】
 */
function uploadFiles (event) {
  event.preventDefault(); // Prevent the default form post

  // Grab the file and asynchronously convert to base64.
  var file = $('#inputArea [name=fileField]')[0].files[0];
  var reader = new FileReader();
  reader.onloadend = processFile;
  reader.readAsDataURL(file);
}

/**
 * Event handler for a file's data url - extract the image data and pass it off.
 */
function processFile (event) {
  var content = event.target.result;

  /**TODO：pdfの場合、ページ分割して画像jpg変換する処理入れる(工藤)*/
  
  /**TODO：画像が複数枚の場合の繰り返し処理追加(石川)*/
  if (content.indexOf('jpeg')===11){    /*jpegの場合*/
	  var encordedValue =content.replace('data:image/jpeg;base64,', '')
  }else if(content.indexOf('png')=== 11){   /*pngの場合*/
	  var encordedValue =content.replace('data:image/png;base64,', '')
  }else if(content.indexOf('bmp')=== 11){    /*bmpの場合*/
	  var encordedValue =content.replace('data:image/bmp;base64,', '')
  }else{
	  /**何もしないが、ゆくゆくエラー表示させたい*/
  }
  sendFileToCloudVision(encordedValue);　  /**TODO：ここも複数枚分処理*/
}

/**
 * Sends the given file contents to the Cloud Vision API and outputs the
 * results.【OCR結果受け取るところ】
 */
function sendFileToCloudVision (content) {
  var type = $('#inputArea [name=type]').val();

  // Strip out the file prefix when you convert to json.
  var request = {
    requests: [{
      image: {
        content: content
      },
      features: [{
        type: type,
        maxResults: 200
      }]
    }]
  };

  $('#results').text('Loading...');
  $.post({
    url: CV_URL,
    data: JSON.stringify(request),
    contentType: 'application/json'
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $('#results').text('ERRORS: ' + textStatus + ' ' + errorThrown);
  }).done(displayJSON);
}

/**
 * Displays the results.
 */
function displayJSON (data) {
  var wk_contents = JSON.stringify(data, null, 4);
  var wk_parseJson = JSON.parse(wk_contents)
  var contents = wk_parseJson.responses[0].fullTextAnnotation.text
  /**evt.resultsにOCR結果を代入*/
  /**TODO：結果を順次追加する（工藤）*/
  $('#results').text(contents);
  var evt = new Event('results-displayed');
  evt.results = contents;
  document.dispatchEvent(evt);
}
