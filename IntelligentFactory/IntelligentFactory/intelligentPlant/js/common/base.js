//base

function Base() {

   	//this.mainDomain = "http://10.246.136.233:8080"; //测试
    // this.mainDomain = "http://10.246.138.84"; //正式
    this.mainDomain = "http://10.246.109.109";  //服务器地址

	this.getQuery = function(search, name) {
		if(search.indexOf('?') >= 0) search = search.substr(1);
		var params = search.match(new RegExp('(^|&)' + name + '=([^&]*)(&|$)'));
		if(params != null && params.length > 2) return window.unescape(params[2]);
		return '';
	}

	//将日期转化为2016/10/28日的格式
	this.formatDate = function (date) {  
		var date=new Date(date)
	    var y = date.getFullYear();  
	    var m = date.getMonth() + 1;  
	    m = m < 10 ? '0' + m : m;  
	    var d = date.getDate();  
	    d = d < 10 ? ('0' + d) : d;  
	    return y + '/' + m + '/' + d;  
	}; 
	
	//将日期转化为2016-10-28日的格式
	this.formatNDate = function (date) {  
		var date=new Date(date)
	    var y = date.getFullYear();  
	    var m = date.getMonth() + 1;  
	    m = m < 10 ? '0' + m : m;  
	    var d = date.getDate();  
	    d = d < 10 ? ('0' + d) : d;  
	    return y + '-' + m + '-' + d;  
	};
	
	//将日期转化为2015-03-19 12:00的格式
	this.formatDateTime = function (date) {  
		var date=new Date(date)
	    var y = date.getFullYear();  
	    var m = date.getMonth() + 1;  
	    m = m < 10 ? ('0' + m) : m;  
	    var d = date.getDate();  
	    d = d < 10 ? ('0' + d) : d;  
	    var h = date.getHours();  
	    var minute = date.getMinutes();  
	    minute = minute < 10 ? ('0' + minute) : minute;  
	    return y + '-' + m + '-' + d+' '+h+':'+minute;  
	}; 
	
	//将日期转化为9日  12:00的格式
	this.formatTime = function (date) {
		var date=new Date(date)
		var d = date.getDate();  
	    d = d < 10 ? ('0' + d) : d;
	    var h = date.getHours();  
	    var minute = date.getMinutes();  
	    minute = minute < 10 ? ('0' + minute) : minute;  
	    return d+'日' +h+':'+minute;  
	};

	
};

//加载进度
function Loading() {
	this.show = function() {
		layer.load(1, {shade: [0.3, '#000000']});
	}
	this.hide = function() {
		layer.closeAll();
	}

	this.alertMsg = function(msg) {
		/*layer.open({
		  	type: 1,
		  	//skin: 'layui-layer-demo', //样式类名
		  	closeBtn: 1, //不显示关闭按钮
		  	//anim: 2,
		  	shadeClose: true, //开启遮罩关闭
		  	content: msg
		});*/
		layer.msg(msg, {
		  	shade: 0.1
		});
	}
}
