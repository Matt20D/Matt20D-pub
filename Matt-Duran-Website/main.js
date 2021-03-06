/* 
 * Where I will house javascript code to be pulled in to 
 * my index.html webpage
 */

/* jQuery code that makes the <header> element stretch across 
 * entire screen
 */
/*
$(document).ready(function(){
        $('.header').height($(window).height());
})
*/

/* this below code does the same as the jQuery stuff above */
var ready = (callback) => {
        if (document.readyState != "loading") callback();
        else document.addEventListener("DOMContentLoaded", callback);
}

ready(() => {
        document.querySelector(".header").style.height = window.innerHeight + "px";
})


/* videoPlayer code */
var videoPlayer = document.getElementById("videoPlayer");
var myVideo = document.getElementById("myVideo");

function stopVideo(){
    videoPlayer.style.display = "none"
}

function playVideo(file){
    myVideo.src = file;
    videoPlayer.style.display = "block"
}
