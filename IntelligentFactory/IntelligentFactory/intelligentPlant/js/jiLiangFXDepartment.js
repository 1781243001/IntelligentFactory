$(function(){
	/*setTimeout(function(){
		$("body").css({"display":"block"})
	},1600)*/
	var baseObj = new Base();
	var domainStr = baseObj.mainDomain;
	var loading = new Loading()
	
	var jiLiangDataAll = baseObj.getQuery(window.location.search, 'sjson');
	//var jiLiangDataAll = '[{"id":"5466","text":"化工部东区","orderId":0,"selected":1},{"id":"5461","text":"化工部西区","orderId":0,"selected":1}]'
	/*var P = '<p>'+jiLiangDataAll+'</p><p>第三方斯蒂芬</p>';
	$("body").append(P)*/
	
	if(jiLiangDataAll == ""){
		//bm_mrAreaListData()
	} else {
		localStorage.setItem("jiLiangData",jiLiangDataAll);
		var jiLiangData = JSON.parse(localStorage.getItem("jiLiangData"));
		console.log(jiLiangData)
		//bm_dzAreaListData(Department)
	}
    
    $(".company_name p").on("click",function(){
		console.log($(this).text())
		
		if($(this).hasClass("dz")){
			$(this).removeClass("dz").siblings().addClass("dz")
		}
		if($(this).text() == "切换到定制"){
			$(".chmrListBody").css({"display":'none'}).siblings().css({"display":'block'})
			console.log("这是定制页面")
			$(".bodyall").css({"padding-bottom":".88rem"})
			$(".footer").css({"display":'block'})
			//var jiLiangData = JSON.parse(localStorage.getItem("jiLiangData")) || [];
			//console.log(jiLiangData)
			//bm_dzAreaListData(jiLiangData)
		} else if($(this).text() == "切换到默认"){
			//bm_mrAreaListData()
			$(".bodyall").css({"padding-bottom":"0"})
			$(".chdzListBody").css({"display":'none'}).siblings().css({"display":'block'})
			$(".footer").css({"display":'none'})
		}
		
	})
    
    $(".footer").on("click",function(){
		window.location.href = 'dingZHiGuanWangTiaoZhuanjiLiang.html?DepartmentDatajiLiang=DepartmentDatajiLiang';
	})
    
    $(".left-c").on("click",function(){
    	console.log(1111111)
    	var areaId = "";
    	window.location.href = "jiLiangFXdetails.html?areaId="+areaId+"&FactoryData=";
    	//window.location.href = "jiLiangFXdetails.html?FactoryData=";
    })
    
    $(".right_c ").on("click",function(){
    	//console.log(1111111)
    	var areaId = "";
    	window.location.href = "jiLiangFXWorkshop.html?areaId="+areaId+"&FactoryData=";
    	//window.location.href = "jiLiangFXWorkshop.html?FactoryData=";
    })
	
	
	var jlEareParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|7f0911a0-7fbf-48a2-aea5-45f618c10ce5",
        RequestParams: [{"value": "0", "key": "value1"}]
        
  	}
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(jlEareParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	var jlJZParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|e64bcabf-0b2b-4490-b2c6-7298a36ac4f6",
        RequestParams: [{"value": "0", "key": "value1"}]
        
  	}
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(jlJZParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	//KPI面板
	var NYParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        //RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|ea7a0e1b-7cbd-4486-b76d-72a1bef9d73c",
        //RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-20","key":"DateTime"}]
        //RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-20","key":"DateTime"}]
        RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|ea7a0e1b-7cbd-4486-b76d-72a1bef9d73c",
        RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}] 
        
    }
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(NYParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	//总表数面板汇总表  ========返回数据多了
	var zParam = {
        AppID: "zb.s20170704000000001",
        DeviceID: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipSN: "92203450-4267-4AA1-93DB-45CE7C2097DE",
        EquipType: "iPhone",
        IsEncrypted: 'false',
        UserID: "test",
        //RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|ea7a0e1b-7cbd-4486-b76d-72a1bef9d73c",
        //RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-20","key":"DateTime"}]
        //RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-20","key":"DateTime"}]
        RequestMethod: "1b363376-cfba-4b3e-bc48-53e361f3de1e|ea7a0e1b-7cbd-4486-b76d-72a1bef9d73c",
        //RequestParams: [{"value":"2","key":"AreaId"},{"value":"1921000","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}] 
        RequestParams: [{"value":"6141","key":"AreaIdList"},{"value":"-3","key":"Condition1"},{"value":"1","key":"DateType"},{"value":"2017-06-18","key":"DateTime"}]
        
    }
	$.ajax({
	   	type: "post",
        async: true,
        url: domainStr+"/app/api/MobileBusiness/GetPageViewData",
        contentType: "application/x-www-form-urlencoded",
        data: JSON.stringify(zParam),
	   	success: function(msg){
	   		console.log(JSON.parse(msg))
	   		
   			
	   		
	   	},
	   	error: function (XMLHttpRequest, textStatus, errorThrown) {
			console.log("错误")
		    console.log(XMLHttpRequest.responseText)
		    console.log(textStatus)
		    console.log(errorThrown)
			
		}
	});
	
	/*$(".footer").on("click",function(){
		var sjson = [{"id":"5461","name":"炼油工厂","orderId":0,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5482","name":"炼油仪表车间","orderId":2,"selected":1},{"id":"5484","name":"炼油技术中心","orderId":3,"selected":1},{"id":"5468","name":"炼油联合三车间","orderId":4,"selected":1},{"id":"5470","name":"炼油联合五车间","orderId":5,"selected":1},{"id":"5471","name":"炼油联合六车间","orderId":6,"selected":1},{"id":"5472","name":"炼油润滑油一车间","orderId":7,"selected":1},{"id":"5473","name":"炼油润滑油二车间","orderId":8,"selected":1},{"id":"5474","name":"炼油润滑油三车间","orderId":9,"selected":1},{"id":"5475","name":"炼油加氢精制车间","orderId":10,"selected":1},{"id":"5476","name":"炼油重整车间","orderId":11,"selected":1},{"id":"5477","name":"炼油联合七车间","orderId":12,"selected":1},{"id":"5478","name":"炼油输油车间","orderId":13,"selected":1},{"id":"5479","name":"炼油装油车间","orderId":14,"selected":1},{"id":"5546","name":"4号常减压-LY","orderId":15,"selected":1},{"id":"5549","name":"3号催化裂化-LY","orderId":16,"selected":1},{"id":"5568","name":"1号轻烃回收-LY","orderId":17,"selected":1},{"id":"5618","name":"2号轻烃回收-LY","orderId":18,"selected":1},{"id":"5500","name":"化工裂解车间","orderId":19,"selected":1},{"id":"5501","name":"化工芳烃车间","orderId":20,"selected":1},{"id":"5502","name":"化工高压车间","orderId":21,"selected":1},{"id":"5504","name":"化工聚丙烯车间","orderId":22,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1},{"id":"5467","name":"炼油联合二车间","orderId":1,"selected":1}]
		window.location.href = "http://10.238.10.222:8080/jiLiangFXdetails.html?sjson="+sjson
	})*/
})
